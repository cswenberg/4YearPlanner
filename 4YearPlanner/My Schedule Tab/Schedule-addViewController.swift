//
//  Schedule-addViewController.swift
//  4YearPlanner
//
//  Created by Omar Rasheed on 5/5/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit
import SnapKit

class Schedule_addViewController: UIViewController, UISearchBarDelegate {
    
    var subContainerView: UIView!
    var searchBar: UISearchBar!
    var subContainerViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        let searchBarTextField = searchBar.value(forKey: "searchField") as? UITextField
        searchBarTextField?.backgroundColor = .lightGray
        if let backgroundView = searchBarTextField?.subviews.first {
            backgroundView.layer.cornerRadius = 20
            backgroundView.clipsToBounds = true
        }
        searchBarTextField?.layer.cornerRadius = 20
        definesPresentationContext = true
        
        subContainerView = UIView()
        subContainerView.backgroundColor = .white
        
        subContainerViewController = AddCoursesViewController()
        
        subContainerView.addSubview(subContainerViewController.view)
        
        view.addSubview(subContainerView)
        view.addSubview(searchBar)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        subContainerViewController.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        
        subContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: "reload", object: nil)
        self.perform(#selector(self.reload), with: searchText, afterDelay: 1.0)
    }
    
    @objc func reload (string: String) {
        if let searchText = searchBar.text {
            if !searchText.isEmpty {
                if searchText.contains(" "){
                    var textParams = searchText.components(separatedBy: " ")
                    sharedVars.searchSubject = textParams[0]
                    sharedVars.searchNumber = textParams[1]
                    print("Subject: "+sharedVars.searchSubject+" Number: "+sharedVars.searchNumber)
                } else {
                    if isClassNumber(s: searchText) {sharedVars.searchNumber = searchText
                        print("Number: "+sharedVars.searchNumber)
                    }
                    else {sharedVars.searchSubject = searchText
                        print("Subject: "+sharedVars.searchSubject)
                    }
                }
            }
        }
    }
    
    func isClassNumber(s: String) -> Bool {
        for num in 0...9 {
            if s.contains(String(num)) {return true}
        }
        return false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


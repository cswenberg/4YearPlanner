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
    var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = aesthetics.backgroundColor
        
        searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        let searchBarTextField = searchBar.value(forKey: "searchField") as? UITextField
        searchBarTextField?.backgroundColor = aesthetics.searchBarGray
        if let backgroundView = searchBarTextField?.subviews.first {
            backgroundView.layer.cornerRadius = 20
            backgroundView.clipsToBounds = true
        }
        searchBarTextField?.layer.cornerRadius = 20
        definesPresentationContext = true
        
        subContainerView = UIView()
        subContainerView.backgroundColor = aesthetics.backgroundColor
        subContainerViewController = AddCoursesViewController()
        subContainerView.addSubview(subContainerViewController.view)
    
        backButton = UIButton()
        backButton.setTitle("<", for: .normal)
        backButton.setTitleColor(aesthetics.textColor, for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 48)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        view.addSubview(backButton)
    
        
        view.addSubview(subContainerView)
        view.addSubview(searchBar)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        // back button
        backButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(backButton.intrinsicContentSize.width)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(backButton.intrinsicContentSize.height)
        }
        //searchbar
        searchBar.snp.makeConstraints { (make) in
            make.centerY.equalTo(backButton.snp.centerY)
            make.leading.equalTo(backButton.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        //subcontainer view
        subContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
        //subcontainer vc
        subContainerViewController.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: nil)
        self.perform(#selector(reload), with: nil , afterDelay: 1.0)
    }
    
    @objc func reload (string: String) {
        if let searchText = searchBar.text {
            if !searchText.isEmpty {
                if searchText.contains(" "){
                    var textParams = searchText.components(separatedBy: " ")
                    sharedVars.searchSubject = textParams[0]
                    sharedVars.searchNumber = textParams[1]
                } else {
                    if isClassNumber(s: searchText) {sharedVars.searchNumber = searchText}
                    else {sharedVars.searchSubject = searchText}
                }
                Network.getCourses { (courses) in
                    print(courses)
                }
                if let optionsviewcontroller = self.subContainerViewController as? AddCoursesViewController {
                    optionsviewcontroller.addCoursesCollectionView.reloadData()
                }
            }
            else {
                sharedVars.discoverCourses = sharedVars.allCourses
                if let optionsviewcontroller = self.subContainerViewController as? AddCoursesViewController {
                    optionsviewcontroller.addCoursesCollectionView.reloadData()
                }
            }
        }
    }
    @objc func reload2() {
        if let optionsviewcontroller = self.subContainerViewController as? AddCoursesViewController {
            optionsviewcontroller.addCoursesCollectionView.reloadData()
        }
    }
    
    func isClassNumber(s: String) -> Bool {
        for num in 0...9 {
            if s.contains(String(num)) {return true}
        }
        return false
    }
    
    // ONLY returns from modal VC
    @objc func backButtonPressed(sender: UIButton) {
        dismiss(animated: false, completion: nil)
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


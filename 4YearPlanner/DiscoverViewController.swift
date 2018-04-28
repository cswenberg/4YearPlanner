//
//  DiscoverViewController.swift
//  4YearPlanner
//
//  Created by Con Swenberg on 4/27/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit

protocol discoverViewDelegate {
    func changeSelectedSemester(number: Int)
}

class DiscoverViewController: UIViewController, optionsViewDelegate, addCoursesDelegate {
    func passChosenOps(chosenitem: Requirements, name: String) {
        return
    }
    
    
    var delegate: discoverViewDelegate?

    var searchBar: UISearchBar!
    var backButton: UIButton!
    
    var selectedCollection = "Colleges"
    
    var subContainerView: UIView!
    var subContainerViewController: UIViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        subContainerView = UIView()
        subContainerView.backgroundColor = .white
        
        searchBar = UISearchBar()
        definesPresentationContext = true
        
        // Back Button
        backButton = UIButton()
        backButton.setTitle("<", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 32)
        backButton.titleLabel?.textAlignment = .center
        backButton.addTarget(self, action: #selector(discoverBackButtonPressed), for: .touchUpInside)
        
        view.addSubview(backButton)
        view.addSubview(searchBar)
        view.addSubview(subContainerView)
        
        setupDiscoverConstraints()
        updateChildViewController()
    }
    
    func setupDiscoverConstraints() {
        // Back Button
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalTo(searchBar.snp.centerY)
            make.height.equalTo(searchBar.snp.height)
            make.width.equalTo(backButton.intrinsicContentSize.width)
        }
        
        // SearchBar
        searchBar.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.leading.equalTo(backButton.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(40)
        }
        // subContainer view
        subContainerView.snp.makeConstraints{ (make) in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func removeChildViewControllers() {
        for vc in childViewControllers {
            vc.willMove(toParentViewController: nil)
            vc.view.removeFromSuperview()
            vc.removeFromParentViewController()
        }
    }
    
    func updateChildViewController() {
        removeChildViewControllers()
        var newViewController: UIViewController!
        if selectedCollection == "Courses" {
            let addcoursesViewController = AddCoursesViewController()
            addcoursesViewController.delegate = self
            newViewController = addcoursesViewController
        } else {
            let optionViewController = OptionsViewController()
            optionViewController.delegate = self
            newViewController = optionViewController
        }
        subContainerViewController = newViewController
        addChildViewController(subContainerViewController)
        subContainerView.addSubview(subContainerViewController.view)
        subContainerViewController.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        subContainerViewController?.didMove(toParentViewController: self)
    }
    
    @objc func discoverBackButtonPressed(sender: UIButton) {
        if selectedCollection == "Majors" || selectedCollection == "Minors" {
            if let optionsviewcontroller = subContainerViewController as? OptionsViewController {
                optionsviewcontroller.reverseSwitchCollection()
                optionsviewcontroller.optionsCollectionView.reloadData()
            }
        }
    }
    
    func selectedNewSemester(number: Int) {
        delegate?.changeSelectedSemester(number: number)
    }

    func switchCollection(newcollection: String) {
        print("received switchCollection delegate call")
        selectedCollection = newcollection
        if selectedCollection == "Courses" {updateChildViewController()}
    }

}

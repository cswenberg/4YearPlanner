//
//  DiscoverViewController.swift
//  4YearPlanner
//
//  Created by Con Swenberg on 4/27/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController, UISearchBarDelegate, showCoursesDelegate {
    
    func showCourses() {
        updateChildViewController()
    }

    var searchBar: UISearchBar!
    var backButton: UIButton!
    
    var subContainerView: UIView!
    var subContainerViewController: UIViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        subContainerView = UIView()
        subContainerView.backgroundColor = .white
        
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
            make.trailing.equalToSuperview().offset(-10)
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
    
    // Part 1 of switching child VC (options/add courses)
    func removeChildViewControllers() {
        for vc in childViewControllers {
            vc.willMove(toParentViewController: nil)
            vc.view.removeFromSuperview()
            vc.removeFromParentViewController()
        }
    }
    
    // Part 2 of switching child VC (options/add courses)
    func updateChildViewController() {
        removeChildViewControllers()
        var newViewController: UIViewController!
        if sharedVars.current_category == "Courses" {
            let addcoursesViewController = AddCoursesViewController()
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
    
    // Go back 1 section in options VC
    @objc func discoverBackButtonPressed(sender: UIButton) {
        if sharedVars.current_category == "Majors" || sharedVars.current_category == "Minors" {
            if let optionsviewcontroller = subContainerViewController as? OptionsViewController {
                reverseSwitchCollection()
                optionsviewcontroller.optionsCollectionView.reloadData()
            }
        } else {
            reverseSwitchCollection()
        }
    }
    
    // Switches Collection when back button is pressed (backward)
    func reverseSwitchCollection() {
        if sharedVars.current_category == "Majors" {
            sharedVars.current_category = "Colleges"
        } else if sharedVars.current_category == "Minors" {
            sharedVars.current_category = "Majors"
        } else if sharedVars.current_category == "Courses" {
            sharedVars.current_category = "Minors"
            updateChildViewController()
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
                    
                }
            }
        }
    }
}
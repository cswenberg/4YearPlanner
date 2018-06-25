//
//  DiscoverViewController.swift
//  4YearPlanner
//
//  Created by Con Swenberg on 4/27/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController, UISearchBarDelegate, showCoursesDelegate, networksDelegate, addCoursesDelegate {
    func presentDVC(cellClass: Class) {
        let dVC = DetailViewController()
        dVC.detailedClass = cellClass
        dVC.loadedFrom = "Add Courses"
        present(dVC, animated: true, completion: nil)
    }
    
    
    func reloadCourses() {
        if let optionsviewcontroller = self.subContainerViewController as? AddCoursesViewController {
            optionsviewcontroller.addCoursesCollectionView.reloadData()
        }
    }
    
    func showCourses() {
        updateChildViewController()
    }
    
    func updateCategoryLabel() {
        categoryLabel.text = sharedVars.current_category
        if sharedVars.current_category == "Courses" {
            
        }
    }

    var searchBar: UISearchBar!
    var backButton: UIButton!
    var categoryLabel: UILabel!
    var recommendedButton: UIButton!
    var allCoursesButton: UIButton!
    
    var subContainerView: UIView!
    var subContainerViewController: UIViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = aesthetics.backgroundColor
        
        
        subContainerView = UIView()
        subContainerView.backgroundColor = .white
        
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
        
        // Back Button
        backButton = UIButton()
        backButton.setTitle("<", for: .normal)
        backButton.setTitleColor(aesthetics.textColor, for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 36)
        backButton.titleLabel?.textAlignment = .center
        backButton.addTarget(self, action: #selector(discoverBackButtonPressed), for: .touchUpInside)
        
        recommendedButton = UIButton()
        recommendedButton.setTitle("Recommended", for: .normal)
        recommendedButton.setTitleColor(aesthetics.textColor, for: .normal)
        recommendedButton.titleLabel?.font = .systemFont(ofSize: 24)
        recommendedButton.titleLabel?.textAlignment = .center
        recommendedButton.addTarget(self, action: #selector(careerButtonPressed), for: .touchUpInside)
        
        allCoursesButton = UIButton()
        allCoursesButton.setTitle("All", for: .normal)
        allCoursesButton.setTitleColor(aesthetics.textColor, for: .normal)
        allCoursesButton.titleLabel?.font = .systemFont(ofSize: 24)
        allCoursesButton.titleLabel?.textAlignment = .center
        allCoursesButton.addTarget(self, action: #selector(careerButtonPressed), for: .touchUpInside)
        
        // Category Label
        categoryLabel = UILabel()
        categoryLabel.text = sharedVars.current_category
        categoryLabel.font = .boldSystemFont(ofSize: 36)
        categoryLabel.textColor = aesthetics.textColor
        
        view.addSubview(backButton)
        view.addSubview(searchBar)
        view.addSubview(subContainerView)
        view.addSubview(categoryLabel)
        
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
        // Category Label
        categoryLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.width.equalTo(categoryLabel.intrinsicContentSize.width+20)
            make.height.equalTo(categoryLabel.intrinsicContentSize.height)
        }
        // subContainer view
        subContainerView.snp.makeConstraints{ (make) in
            make.top.equalTo(categoryLabel.snp.bottom)
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
    
    // Go back 1 section in options VC
    @objc func discoverBackButtonPressed(sender: UIButton) {
        if sharedVars.current_category == "Majors" || sharedVars.current_category == "Minors" {
            if let optionsviewcontroller = subContainerViewController as? OptionsViewController {
                reverseSwitchCollection()
                optionsviewcontroller.optionsCollectionView.reloadData()
                optionsviewcontroller.cellsToDisplay = []
            }
        } else {
            reverseSwitchCollection()
        }
    }
    
    // Switches Collection when back button is pressed (backward)
    func reverseSwitchCollection() {
        if sharedVars.current_category == "Majors" {
            sharedVars.current_category = "Colleges"
            updateCategoryLabel()
        } else if sharedVars.current_category == "Minors" {
            sharedVars.current_category = "Majors"
            updateCategoryLabel()
        } else if sharedVars.current_category == "Courses" {
            sharedVars.current_category = "Minors"
            updateCategoryLabel()
            updateChildViewController()
        }
        aesthetics.gradientRandomizer = Int(arc4random_uniform(4))
    }
    
    // testing new function for SearchBar (trying to reduce lag and bugs)
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: nil)
        self.perform(#selector(reload), with: nil, afterDelay: 1.0)
        
    }

    // function that happens after 1 second delay
    @objc func reload () {
        Network.delegate = self
        if let searchText = searchBar.text {
            if !searchText.isEmpty {
                if searchText.contains(" ") {
                    var textParams = searchText.components(separatedBy: " ")
                    sharedVars.searchSubject = textParams[0]
                    sharedVars.searchNumber = textParams[1]
                } else if isClassNumber(s: searchText) {
                    sharedVars.searchNumber = searchText
                } else {
                    sharedVars.searchSubject = searchText
                    sharedVars.searchNumber = ""
                }
                print("'\(sharedVars.searchSubject) + \(sharedVars.searchNumber)' was searched")
                Network.getCourses { (courses) in
                    print(courses)
                }
            }
            else {
                sharedVars.discoverCourses = sharedVars.allCourses
                reloadCourses()
            }
        }
    }
    
    @objc func careerButtonPressed (sender: UIButton) {
        if sender == allCoursesButton {
            sharedVars.discoverCourses = sharedVars.allCourses
        }
    }


    
    func isClassNumber(s: String) -> Bool {
        for num in 0...9 {
            if s.contains(String(num)) {return true}
        }
        return false
    }
}

//
//  DiscoverViewController.swift
//  4YearPlanner
//
//  Created by Con Swenberg on 4/27/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit

protocol discoverDelegate {
    func showFiltersBlurView ()
}

class DiscoverViewController: UIViewController, UISearchBarDelegate, showCoursesDelegate, addCoursesDelegate {
    func presentDVC(cellClass: Class) {
        let dVC = DetailViewController()
        dVC.detailedClass = cellClass
        dVC.loadedFrom = "Add Courses"
        present(dVC, animated: true, completion: nil)
    }
    
    func showCourses() {
        updateChildViewController()
    }
    
    func updateCategoryLabel() {
        categoryLabel.text = sharedVars.current_category
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    
    func showCoursesOptions() {
        showCourseOptionsFilters()
    }
    
    func showBackButton () {
        let distanceChange = self.backButton.intrinsicContentSize.width + CGFloat(aesthetics.smallGap)
        let newHeight = self.searchBar.frame.height
        let newWidth = self.searchBar.frame.width - distanceChange
        let newX = self.searchBar.frame.origin.x + distanceChange
        let newY = self.searchBar.frame.origin.y
        let newFrame = CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
        
        UIView .animate(withDuration: 0.5) {
            self.backButton.alpha = 1.0
            self.searchBar.frame = newFrame
            self.view.layoutIfNeeded()
        }
    }
    
    var delegate: discoverDelegate?

    var searchBar: UISearchBar!
    var backButton: UIButton!
    var categoryLabel: UILabel!
    var filtersButton: UIButton!
    
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
        backButton.titleLabel?.font = aesthetics.backButtonFont
        backButton.titleLabel?.textAlignment = .center
        backButton.addTarget(self, action: #selector(discoverBackButtonPressed), for: .touchUpInside)
        
        // Filters Button
        filtersButton = UIButton()
        filtersButton.setTitle("⌔", for: .normal)
        filtersButton.setTitleColor(aesthetics.textColor, for: .normal)
        filtersButton.titleLabel?.font = aesthetics.backButtonFont
        //filtersButton.setImage(UIImage(named: "filterIcon"), for: .normal)
        filtersButton.backgroundColor = aesthetics.backgroundColor
        filtersButton.layer.cornerRadius = filtersButton.intrinsicContentSize.height/2
        filtersButton.addTarget(self, action: #selector(careerButtonPressed), for: .touchUpInside)
        
        // Category Label
        categoryLabel = UILabel()
        categoryLabel.text = sharedVars.current_category
        categoryLabel.font = .boldSystemFont(ofSize: 36)
        categoryLabel.textColor = aesthetics.textColor
        
        view.addSubview(backButton)
        view.addSubview(searchBar)
        view.addSubview(subContainerView)
        view.addSubview(categoryLabel)
        
        if sharedVars.current_category == "Courses" {
            showCourseOptionsFilters()
        }
        setupDiscoverConstraints()
        updateChildViewController()
    }
    
    func setupDiscoverConstraints() {
        // Back Button
        if sharedVars.current_category != "Colleges" {
            view.addSubview(backButton)
            backButton.snp.makeConstraints { (make) in
                make.leading.equalToSuperview().offset(aesthetics.smallGap)
                make.centerY.equalTo(searchBar.snp.centerY)
                make.height.equalTo(searchBar.snp.height)
                make.width.equalTo(backButton.intrinsicContentSize.width)
            }
        }
        
        // SearchBar
        if sharedVars.current_category == "Colleges" {
            searchBar.snp.makeConstraints { (make) in
                make.trailing.equalToSuperview().offset(-aesthetics.smallGap)
                make.leading.equalToSuperview().offset(aesthetics.smallGap)
                make.height.equalTo(40)
                make.top.equalToSuperview().offset(aesthetics.smallGap)
            }
        } else {
            searchBar.snp.makeConstraints { (make) in
                make.trailing.equalToSuperview().offset(-aesthetics.smallGap)
                make.leading.equalTo(backButton.snp.trailing).offset(aesthetics.smallGap)
                make.top.equalToSuperview().offset(aesthetics.smallGap)
                make.height.equalTo(40)
            }
        }
        // Category Label
        categoryLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(aesthetics.smallGap)
            make.top.equalTo(searchBar.snp.bottom).offset(aesthetics.smallGap)
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
            if (userData.myMinor == nil) {
                if (userData.myMajor == nil) {
                    sharedVars.current_category = "Colleges"
                } else {
                    sharedVars.current_category = "Majors"
                }
            }
            filtersButton.removeFromSuperview()
            reverseSwitchCollection()
        }
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    
    // Switches Collection when back button is pressed (backward)
    func reverseSwitchCollection() {
        if sharedVars.current_category == "Majors" {
            sharedVars.current_category = "Colleges"
            updateCategoryLabel()
            hideBackButton()
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
        
        if sharedVars.current_category == "Courses" {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: nil)
            self.perform(#selector(reload), with: nil, afterDelay: 1.0)
        } else {
            searchNotClasses(searchText: searchText)
        }
    }

    // function that happens after 1 second delay
    @objc func reload () {
        if let searchText = searchBar.text {
            if !searchText.isEmpty {
                if searchText.contains(" ") {
                    var textParams = searchText.components(separatedBy: " ")
                    sharedVars.searchSubject = textParams[0]
                    sharedVars.searchNumber = textParams[1]
                } else {
                    if isClassNumber(s: searchText) {
                        sharedVars.searchNumber = searchText
                        sharedVars.searchSubject = ""
                    } else {
                        sharedVars.searchSubject = searchText
                        sharedVars.searchNumber = ""
                    }
                }
                print("'\(sharedVars.searchSubject) + \(sharedVars.searchNumber)' was searched")
                Network.getCourses { (courses) in
                    sharedVars.discoverCourses = courses
                    self.reloadCourses()
                }
            }
            else {
                // Change to get recommended courses instead
                // use logic to determine what filters are applied
                sharedVars.discoverCourses = userData.allCourses
                sharedVars.searchSubject = ""
                sharedVars.searchNumber = ""
                if let optionsviewcontroller = self.subContainerViewController as? AddCoursesViewController {
                    optionsviewcontroller.addCoursesCollectionView.reloadData()
                }
            }
        }
    }
    
    // Switches filter background and reloads cells with right data
    @objc func careerButtonPressed (sender: UIButton) {
        delegate?.showFiltersBlurView()
    }
    
    func hideBackButton () {
        let distanceChange = self.backButton.intrinsicContentSize.width + CGFloat(aesthetics.smallGap)
        let newHeight = searchBar.frame.height
        let newWidth = searchBar.frame.width + distanceChange
        let newX = searchBar.frame.origin.x - distanceChange
        let newY = searchBar.frame.origin.y
        let newFrame = CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
        
        UIView .animate(withDuration: 0.5) {
            self.backButton.alpha = 0.0
            self.searchBar.frame = newFrame
            self.view.layoutIfNeeded()
        }
    }
    
    // Add filters to subview and setup constraints
    func showCourseOptionsFilters() {
        
        view.addSubview(filtersButton)
        
        filtersButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(32)
            make.trailing.equalToSuperview().offset(-aesthetics.smallGap)
            make.centerY.equalTo(categoryLabel.snp.centerY)
        }
    }
    
    // Search function for Colleges, Majors, and Minors
    func searchNotClasses(searchText: String) {
//        if sharedVars.current_category == "Colleges" {
//            if !searchText.isEmpty {
//                if let optionsviewcontroller = subContainerViewController as? OptionsViewController {
//                    optionsviewcontroller.displayedColleges = []
//                    for each in requirementData.allColleges {
//                        if each.rawValue.contains(searchText){
//                            optionsviewcontroller.displayedColleges.append(each)
//                        }
//                    }
//                    optionsviewcontroller.optionsCollectionView.reloadData()
//                }
//            } else {
//                if let optionsviewcontroller = subContainerViewController as? OptionsViewController {
//                    optionsviewcontroller.displayedColleges = requirementData.allColleges
//                    optionsviewcontroller.optionsCollectionView.reloadData()
//                }
//            }
//        } else if sharedVars.current_category == "Majors" {
//            if !searchText.isEmpty {
//                if let optionsviewcontroller = subContainerViewController as? OptionsViewController {
//                    optionsviewcontroller.displayedMajors = []
//                    for each in userData.myCollege.majorOptions {
//                        if each.rawValue.contains(searchText){
//                            optionsviewcontroller.displayedMajors.append(each)
//                        }
//                    }
//                    optionsviewcontroller.optionsCollectionView.reloadData()
//                }
//            } else {
//                if let optionsviewcontroller = subContainerViewController as? OptionsViewController {
//                    optionsviewcontroller.displayedMajors = userData.myCollege.majorOptions
//                    optionsviewcontroller.optionsCollectionView.reloadData()
//                }
//            }
//        } else if sharedVars.current_category == "Minors" {
//            if !searchText.isEmpty {
//                if let optionsviewcontroller = subContainerViewController as? OptionsViewController {
//                    optionsviewcontroller.displayedMinors = []
//                    for each in userData.myMajor.minorOptions {
//                        if each.rawValue.contains(searchText){
//                            optionsviewcontroller.displayedMinors.append(each)
//                        }
//                    }
//                    optionsviewcontroller.optionsCollectionView.reloadData()
//                }
//            } else {
//                if let optionsviewcontroller = subContainerViewController as? OptionsViewController {
//                    optionsviewcontroller.displayedMinors = userData.myMajor.minorOptions
//                    optionsviewcontroller.optionsCollectionView.reloadData()
//                }
//            }
//        }
    }
    
    func reloadCourses() {
        if let addCoursesViewController = self.subContainerViewController as? AddCoursesViewController{
            addCoursesViewController.addCoursesCollectionView.reloadData()
        }
    }
    
    // Check if text is number (Search Bar Filtering)
    func isClassNumber(s: String) -> Bool {
        for num in 0...9 {
            if s.contains(String(num)) {return true}
        }
        return false
    }
}

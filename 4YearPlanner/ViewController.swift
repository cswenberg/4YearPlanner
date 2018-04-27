//
//  ViewController.swift
//  4YearPlanner
//
//  Created by Con Swenberg on 4/26/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//
//bishshhhhhhh
//buiuiuhh2
//yasuhysdgbi ub
import UIKit
import SnapKit

class HomeViewController: UIViewController {

    

    
//    var myCollege: College
//    var myMajor: Major
//    var myMinor: Requirements
    var allClasses: [Class] = []
    var allSemesters: [Semester] = []
    var selectedButton = "Discover"
    var selectedSemester = 0
    var selectedDiscoverCollection: String = "Colleges"
    var coursesDisplayed: [Class] = []
    var searchBar: UISearchBar!
    var homeScrollView: UIScrollView!
    var scrollStackView: UIStackView!
    var tabsStackView: UIStackView!
    var mainStackView: UIStackView!
    var discoverButton: UIButton!
    var myScheduleButton: UIButton!
    var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
    // Nice Color of Gray
        let niceGray = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        
    // Font for Tabs
        let tabsFont = UIFont.systemFont(ofSize: 20)
        
    // Search Bar for Colleges/Majors/etc..
        searchBar = UISearchBar()
        
        definesPresentationContext = true
        
    // Initializes ScrollView for Colleges/Majors/etc..
        homeScrollView = UIScrollView()
        homeScrollView.alwaysBounceVertical = true
        
    // Button for the Discover Tab
        discoverButton = UIButton()
        discoverButton.layer.cornerRadius = 16
        discoverButton.backgroundColor = niceGray
        discoverButton.setTitle("Discover", for: .normal)
        discoverButton.titleLabel?.font = tabsFont
        discoverButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
    // Button for the MySchedule Tab
        myScheduleButton = UIButton()
        myScheduleButton.layer.cornerRadius = 16
        myScheduleButton.backgroundColor = niceGray
        myScheduleButton.setTitle("My Schedule", for: .normal)
        myScheduleButton.titleLabel?.font = tabsFont
        myScheduleButton.titleLabel?.textColor = .black
        myScheduleButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
    // Button for Settings Tab
        settingsButton = UIButton()
        settingsButton.layer.cornerRadius = 16
        settingsButton.backgroundColor = niceGray
        settingsButton.setTitle("Settings", for: .normal)
        settingsButton.titleLabel?.font = tabsFont
        settingsButton.titleLabel?.textColor = .black
        settingsButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
    // StackView for tabs at the top
        tabsStackView = UIStackView(arrangedSubviews: [discoverButton, myScheduleButton, settingsButton])
        tabsStackView.axis = .horizontal
        tabsStackView.distribution = .equalCentering
        view.addSubview(tabsStackView)

    // StackView within Scrollview
    // Add CollegeCollection, MajorCollection, CourseCollection above this
        scrollStackView = UIStackView(arrangedSubviews: [])
        scrollStackView.backgroundColor = .orange
        scrollStackView.axis = .vertical
        scrollStackView.distribution = .equalSpacing
        homeScrollView.addSubview(scrollStackView)
        
    // StackView that holds SearchBar & ScrollView
        mainStackView = UIStackView(arrangedSubviews: [searchBar ,homeScrollView])
        mainStackView.backgroundColor = .white
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalCentering
        view.addSubview(mainStackView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
    // Constraints:
        
    // Tabs StackView
        tabsStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(32)
        }
    
    // StackView for Search Bar & ScrollView
        mainStackView.snp.makeConstraints { (make) in
            make.top.equalTo(tabsStackView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    // Search Bar within StackView
        searchBar.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(40)
        }
        
    // ScrollView for Colleges/Majors/etc..
        homeScrollView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom).offset(10)
        }
        
    // Stackview that holds the cells in the ScrollView
        scrollStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(400)
            make.height.equalTo(100)
        }
        
    // Discover Button
        discoverButton.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalTo(discoverButton.intrinsicContentSize.width + 20)
        }

    // My Schedule Button
        myScheduleButton.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalTo(myScheduleButton.intrinsicContentSize.width + 20)
        }

    // Settings Button
        settingsButton.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalTo(settingsButton.intrinsicContentSize.width + 20)
        }
    }
    
    
    /** Return: list of all college/major/minor requirements that are left unsatisfied,
     empty list if all requirements are satisfied */
//    func requirementsLeft() -> [Class] {
//        var requirementsLeft = [Class]()
//        requirementsLeft+=myCollege.requirementsLeft(classes: allClasses)
//        requirementsLeft+=myMajor.requirementsLeft(classes: allClasses)
//        requirementsLeft+=myMinor.requirementsLeft(classes: allClasses)
//        return requirementsLeft
//    }
    
// Changes variable selectedButton to buttons title
    @objc func buttonPressed (sender: UIButton) {
        selectedButton = (sender.titleLabel?.text)!
        print(selectedButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  4YearPlanner
//
//  Created by Con Swenberg on 4/26/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    

//    var myCollege: College
//    var myMajor: Major
//    var myMinor: Requirements
//    var allClasses: [Class] = []
//    var allSemesters: [Semester] = []
    var selectedButton = "Discover"
//    var selectedSemester = 0
//    var selectedDiscoverCollection: String
//    var coursesDisplayed: [Class]
    var homeScrollView: UIScrollView!
    var mainStackView: UIStackView!
    var tabsStackView: UIStackView!
    var discoverLabel: UILabel!
    var myScheduleLabel: UILabel!
    var settingsLabel: UILabel!
    var discoverView: UIView!
    var myScheduleView: UIView!
    var settingsView: UIView!
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
        
    // Initializes ScrollView for Colleges/Majors/etc..
        homeScrollView = UIScrollView()
        homeScrollView.alwaysBounceVertical = true
        view.addSubview(homeScrollView)
        
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

        
    // Main StackView within Scrollview
    // Add everything above this
        mainStackView = UIStackView(arrangedSubviews: [])
        mainStackView.backgroundColor = .orange
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        homeScrollView.addSubview(mainStackView)
        
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
        
    // ScrollView for Colleges/Majors/etc..
        homeScrollView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(tabsStackView).offset(10)
        }
        
    // Stackview that holds the cells in the ScrollView
        mainStackView.snp.makeConstraints { (make) in
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


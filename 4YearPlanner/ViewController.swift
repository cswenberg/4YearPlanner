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
    var allClasses: [Class] = []
    var allSemesters: [Semester] = []
    var selectedTab = "Discover"
    var selectedSemester = 1
    var selectedDiscoverCollection: String = "Colleges"
    var coursesDisplayed: [Class] = []
    /////////Variables for 'Discover' views////////
    var searchBar: UISearchBar!
    var homeScrollView: UIScrollView!
    var scrollStackView: UIStackView!
    var tabsStackView: UIStackView!
    var mainStackView: UIStackView!
    var hugeView: UIView!
    /////////Main tabs//////////
    var discoverButton: UIButton!
    var myScheduleButton: UIButton!
    var settingsButton: UIButton!
    ///////////Variables for 'My Schedule' views///////////
    var scheduleButtonsStackView: UIStackView!
    var selectedSemesterLabel: UILabel!
    var addCourseButton: UIButton!
    var goLeftButton: UIButton!
    var goRightButton: UIButton!
    var myCoursesCollectionView: UICollectionView!
    var myCoursesCollectionViewCell: UICollectionViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewController(DiscoverViewController())
        view.backgroundColor = .white
    // Nice Color of Gray
        let niceGray = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
    // Font for Tabs
        let tabsFont = UIFont.systemFont(ofSize: 20)
    
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
        
        setupConstraints()

    }
    
    func setupConstraints() {
    // Tabs StackView
        tabsStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(32)
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


    @objc func buttonPressed (sender:UIButton) {
        selectedTab = (sender.titleLabel?.text)!
        print(selectedTab)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


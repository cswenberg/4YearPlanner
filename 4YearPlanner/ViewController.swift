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
    
    var homeScrollView: UIScrollView!
    var mainStackView: UIStackView!
    var tabsStackView: UIStackView!
    var discoverLabel: UILabel!
    var myScheduleLabel: UILabel!
    var settingsLabel: UILabel!
    var discoverView: UIView!
    var myScheduleView: UIView!
    var settingsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        
        let niceGray = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        
        let tabsFont = UIFont(name: "Arial-Bold", size: 34)
        
        homeScrollView = UIScrollView()
        homeScrollView.alwaysBounceVertical = true
        view.addSubview(homeScrollView)
        
        discoverView = UIView()
        discoverView.layer.cornerRadius = 32
        discoverView.backgroundColor = niceGray
        
        myScheduleView = UIView()
        myScheduleView.layer.cornerRadius = 32
        
        settingsView = UIView()
        settingsView.layer.cornerRadius = 32
        
        discoverLabel = UILabel()
        discoverLabel.text = "Discover"
        discoverLabel.textColor = .white
        discoverLabel.font = tabsFont
        discoverView.addSubview(discoverLabel)
        
        myScheduleLabel = UILabel()
        myScheduleLabel.text = "My Schedule"
        myScheduleLabel.font = tabsFont
        myScheduleLabel.textColor = .black
        myScheduleView.addSubview(myScheduleLabel)
        
        settingsLabel = UILabel()
        settingsLabel.text = "Settings"
        settingsLabel.font = tabsFont
        settingsLabel.textColor = .black
        settingsView.addSubview(settingsLabel)
        
    // StackView for tabs at the top
        tabsStackView = UIStackView(arrangedSubviews: [discoverView, myScheduleView, settingsView])
        tabsStackView.axis = .horizontal
        tabsStackView.spacing = 45
        tabsStackView.distribution = .equalSpacing

        
    // Main StackView within Scrollview
    // Add everything above this
        mainStackView = UIStackView(arrangedSubviews: [tabsStackView])
        mainStackView.backgroundColor = .orange
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        homeScrollView.addSubview(mainStackView)
        
        
        
        
        setupConstraints()
    }
    
    func setupConstraints() {
        homeScrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(100)
        }
        
        tabsStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.height.equalTo(64)
        }
        
        discoverView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(175)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  4YearPlanner
//
//  Created by Con Swenberg on 4/26/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit
import SnapKit

let niceGray = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)

class HomeViewController: UIViewController, myscheduleViewDelegate, optionsViewDelegate {
    
    var myCollege: College!
    var myMajor: Major!
    var myMinor: Requirements!
    var mySemesters = [Semester]()
    var selectedTab = "Discover"
    var containerView: UIView!
    var containerViewController: UIViewController!
    var tabsStackView: UIStackView!
    var discoverButton: UIButton!
    var myScheduleButton: UIButton!
    var settingsButton: UIButton!
    var buttonGradient: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let tabsFont = UIFont.systemFont(ofSize: 20)
        
        
        
    
        containerView = UIView()
        
    // Button for the Discover Tab
        discoverButton = UIButton()
        discoverButton.layer.cornerRadius = 16
        discoverButton.setTitle("Discover", for: .normal)
        discoverButton.titleLabel?.font = tabsFont
        discoverButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        setBackgroundGradient(button: discoverButton)
        discoverButton.layer.addSublayer(buttonGradient)
        
    // Button for the MySchedule Tab
        myScheduleButton = UIButton()
        myScheduleButton.layer.cornerRadius = 16
        myScheduleButton.setTitle("My Schedule", for: .normal)
        myScheduleButton.titleLabel?.font = tabsFont
        myScheduleButton.titleLabel?.textColor = .black
        myScheduleButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
    // Button for Settings Tab
        settingsButton = UIButton()
        settingsButton.layer.cornerRadius = 16
        settingsButton.setTitle("Settings", for: .normal)
        settingsButton.titleLabel?.font = tabsFont
        settingsButton.titleLabel?.textColor = .black
        settingsButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
    // StackView for tabs at the top
        tabsStackView = UIStackView(arrangedSubviews: [discoverButton, myScheduleButton, settingsButton])
        tabsStackView.axis = .horizontal
        tabsStackView.distribution = .equalCentering
        
        
        view.addSubview(tabsStackView)
        view.addSubview(containerView)
        
        setupConstraints()
        updateChildViewController()
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
        //container view
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(tabsStackView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // Part 1 of switching view controllers
    func removeChildViewControllers() {
        for vc in childViewControllers {
            vc.willMove(toParentViewController: nil)
            vc.view.removeFromSuperview()
            vc.removeFromParentViewController()
        }
    }
    
    // Part 2 of switching view controllers
    func updateChildViewController() {
        removeChildViewControllers()
        var newViewController: UIViewController!
        if selectedTab=="My Schedule" {
            myScheduleButton.layer.addSublayer(buttonGradient)
            let myscheduleViewController = MyScheduleViewController()
            myscheduleViewController.delegate = self
            newViewController = myscheduleViewController
        } else {
            let discoverViewController = DiscoverViewController()
  //          discoverViewController.delegate = self
            newViewController = discoverViewController
        }
        containerViewController = newViewController
        addChildViewController(containerViewController)
        containerView.addSubview(containerViewController.view)
        containerViewController.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        containerViewController?.didMove(toParentViewController: self)
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
        sender.backgroundColor = niceGray
        sender.titleLabel?.textColor = .white
        updateChildViewController()
    }
    
    // Switches collection(??)
    func switchCollection(newcollection: String) {
        return
    }
    
    // Changes our variables depending on option chosen
    func passChosenOps(chosenitem: Requirements, name: String) {
        if name=="College" {myCollege = chosenitem as! College}
        else if name == "Major" {myMajor = chosenitem as! Major}
        else if name == "Minor" {myMinor = chosenitem}
    }
    
    // Updates semesters variable
    func updateSemesters(semesters: [Semester]) {
        mySemesters = semesters
    }
    
    func setBackgroundGradient (button: UIButton) {
        
        buttonGradient = CAGradientLayer()
        buttonGradient.colors = [UIColor.red.cgColor,
                                 UIColor.blue.cgColor]
        buttonGradient.locations = [0,1]
        buttonGradient.startPoint = CGPoint(x: 1, y: 0)
        buttonGradient.endPoint = CGPoint(x: 0, y: 1)
        buttonGradient.cornerRadius = 16
        
        button.layer.insertSublayer(buttonGradient, at: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


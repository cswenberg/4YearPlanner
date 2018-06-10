//
//  ViewController.swift
//  4YearPlanner
//
//  Created by Con Swenberg on 4/26/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit
import SnapKit

let tabsFont = UIFont.systemFont(ofSize: 20)

class HomeViewController: UIViewController {
    
    var containerView: UIView!
    var containerViewController: UIViewController!
    var tabsStackView: UIStackView!
    var discoverButton: UIButton!
    var myScheduleButton: UIButton!
    var settingsButton: UIButton!
    var buttonGradient: CAGradientLayer!
    var courses = [Class]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

    // Loads all of the courses in from the beginning
    // We need to change so that we get the recocmmended courses instead
        Network.getAllCourses { (courses) in
            print(courses)
        }
        requirementData.dictionariesInit()
        userData.loadDefaults()
        sharedVars.setTab()
        sharedVars.setCategory()
        
        
    // Initialize the containerView that's going to hold basically everything
        containerView = UIView()
        
    // Button for the Discover Tab
        discoverButton = UIButton()
        discoverButton.layer.cornerRadius = 16
        discoverButton.setTitle("Discover", for: .normal)
        discoverButton.titleLabel?.font = tabsFont
        discoverButton.setTitleColor(.black, for: .normal)
        discoverButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        discoverButton.bounds = discoverButton.frame
        
    // Button for the MySchedule Tab
        myScheduleButton = UIButton()
        myScheduleButton.layer.cornerRadius = 16
        myScheduleButton.setTitle("My Schedule", for: .normal)
        myScheduleButton.titleLabel?.font = tabsFont
        myScheduleButton.setTitleColor(.black, for: .normal)
        myScheduleButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        myScheduleButton.bounds = myScheduleButton.frame
        
    // Button for Settings Tab
        settingsButton = UIButton()
        settingsButton.layer.cornerRadius = 16
        settingsButton.setTitle("Settings", for: .normal)
        settingsButton.titleLabel?.font = tabsFont
        settingsButton.setTitleColor(.black, for: .normal)
        settingsButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        settingsButton.bounds = settingsButton.frame
        
    // StackView for tabs at the top
        tabsStackView = UIStackView(arrangedSubviews: [discoverButton, myScheduleButton, settingsButton])
        tabsStackView.axis = .horizontal
        tabsStackView.distribution = .equalCentering
        
    // Set initial gradient
        buttonGradient = CAGradientLayer()
        buttonGradient.colors = sharedVars.tabGradient
        buttonGradient.startPoint = CGPoint(x: 1, y: 0.5)
        buttonGradient.endPoint = CGPoint(x: 0, y: 0.5)
        buttonGradient.cornerRadius = 16
        if sharedVars.current_tab == "Discover" {
            buttonGradient.frame = CGRect(x: 0, y: 0, width: 96, height: 36)
            setBackgroundGradient(button: discoverButton)
        }
        if sharedVars.current_tab == "My Schedule" {
            buttonGradient.frame = CGRect(x: 0, y: 0, width: 134, height: 36)
            setBackgroundGradient(button: myScheduleButton)
        }
        
        view.addSubview(tabsStackView)
        view.addSubview(containerView)
        
        setupConstraints()
        updateChildViewController()
    }
    
    func setupConstraints() {
    // Tabs StackView
        tabsStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(36)
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
            make.top.equalTo(tabsStackView.snp.bottom).offset(6)
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
        if sharedVars.current_tab=="My Schedule" {
            let myscheduleViewController = MyScheduleViewController()
            newViewController = myscheduleViewController
        } else if sharedVars.current_tab=="Discover"{
            let discoverViewController = DiscoverViewController()
            newViewController = discoverViewController
        } else {
            let settingsViewController = SettingsViewController()
            newViewController = settingsViewController
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
        if sharedVars.current_tab != sender.titleLabel?.text {
            if sharedVars.current_tab == "Discover" {
                if discoverButton.layer.sublayers![0] is CAGradientLayer {
                    discoverButton.layer.sublayers![0].removeFromSuperlayer()
                    discoverButton.setTitleColor(.black, for: .normal)
                }
            } else if sharedVars.current_tab == "My Schedule" {
                myScheduleButton.layer.sublayers![0].removeFromSuperlayer()
                myScheduleButton.setTitleColor(.black, for: .normal)
            } else if sharedVars.current_tab == "Settings" {
                settingsButton.layer.sublayers![0].removeFromSuperlayer()
                settingsButton.setTitleColor(.black, for: .normal)
            }
            sharedVars.current_tab = (sender.titleLabel?.text)!
            setBackgroundGradient(button: sender)
            updateChildViewController()
        }
    }
    
    //function used to add gradients
    func setBackgroundGradient (button: UIButton) {
        buttonGradient.frame = button.bounds
        print(button.bounds)
        print(buttonGradient.frame)
        button.layer.insertSublayer(buttonGradient, at: 0)
        button.setTitleColor(.white, for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


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

        Network.getAllCourses { (courses) in
            print(courses)
        }
        let tabsFont = UIFont.systemFont(ofSize: 20)
        
        containerView = UIView()
        
    // Button for the Discover Tab
        discoverButton = UIButton()
        discoverButton.layer.cornerRadius = 16
        discoverButton.setTitle("Discover", for: .normal)
        discoverButton.titleLabel?.font = tabsFont
        discoverButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        discoverButton.bounds = discoverButton.frame
        
    // Set initial gradient
        buttonGradient = CAGradientLayer()
        buttonGradient.colors = [UIColor.blue.cgColor,UIColor.white.cgColor]
        buttonGradient.startPoint = CGPoint(x: 1, y: 0.5)
        buttonGradient.endPoint = CGPoint(x: 0, y: 0.5)
        buttonGradient.cornerRadius = 16
        buttonGradient.frame = CGRect(x: 0, y: 0, width: 96, height: 36)
        discoverButton.layer.insertSublayer(buttonGradient, at: 0)
        
    // Button for the MySchedule Tab
        myScheduleButton = UIButton()
        myScheduleButton.layer.cornerRadius = 16
        myScheduleButton.setTitle("My Schedule", for: .normal)
        myScheduleButton.titleLabel?.font = tabsFont
        myScheduleButton.setTitleColor(.black, for: .normal)
        myScheduleButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
    // Button for Settings Tab
        settingsButton = UIButton()
        settingsButton.layer.cornerRadius = 16
        settingsButton.setTitle("Settings", for: .normal)
        settingsButton.titleLabel?.font = tabsFont
        settingsButton.setTitleColor(.black, for: .normal)
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
        print("setting up constraints")
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
        } else {
            let discoverViewController = DiscoverViewController()
            
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
        print(discoverButton.bounds)
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
            sender.setTitleColor(.white, for: .normal)
            updateChildViewController()
        }
        
        
    }
    
    func setBackgroundGradient (button: UIButton) {
        print("tries to set gradient for \(button)")
        buttonGradient = CAGradientLayer()
        buttonGradient.colors = [UIColor.blue.cgColor, UIColor.white.cgColor]
        buttonGradient.startPoint = CGPoint(x: 1, y: 0.5)
        buttonGradient.endPoint = CGPoint(x: 0, y: 0.5)
        buttonGradient.cornerRadius = 16
        buttonGradient.frame = button.bounds
        button.layer.insertSublayer(buttonGradient, at: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


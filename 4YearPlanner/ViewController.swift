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
    
    var homeStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        
        homeStackView = UIStackView()
        
        
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


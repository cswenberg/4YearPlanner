//
//  Singleton UserData.swift
//  4YearPlanner
//
//  Created by Conner Swenberg on 6/5/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import Foundation
import UIKit

var userData = userInfo()

class userInfo {
    
    var mySemesters: [Semester] = [Semester(number: 1),Semester(number: 2),Semester(number: 3),Semester(number: 4),Semester(number: 5),Semester(number: 6),Semester(number: 7),Semester(number: 8)]
    var myCollege: College!
    var myMajor: Major!
    var myMinor: Minor!
    
    
    func loadDefaults() {
        let defaults = UserDefaults.standard
        if let decodedData = defaults.object(forKey: "mySemesters") as! Data? {
            let semesters = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as! [Semester]
            mySemesters = semesters
        }
        if let decodedData = defaults.object(forKey: "myCollege") as! Data? {
            let college = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as! College
            myCollege = college
        }
        if let decodedData = defaults.object(forKey: "myMajor") as! Data? {
            let major = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as! Major
            myMajor = major
        }
        if let decodedData = defaults.object(forKey: "myMinor") as! Data? {
            let minor = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as! Minor
            myMinor = minor
        }
    }
    
    @objc func setCollege(college: College)  {
        myCollege = college
//        let encodedData = NSKeyedArchiver.archivedData(withRootObject: myCollege)
//        let defaults = UserDefaults.standard
//        defaults.set(encodedData, forKey: "myCollege")
    }
    
    func setMajor(major: Major) {
        myMajor = major
//        let encodedData = NSKeyedArchiver.archivedData(withRootObject: myMajor)
//        let defaults = UserDefaults.standard
//        defaults.set(encodedData, forKey: "myMajor")
    }
    
    func setMinor(minor: Minor) {
        myMinor = minor
//        let encodedData = NSKeyedArchiver.archivedData(withRootObject: myMinor)
//        let defaults = UserDefaults.standard
//        defaults.set(encodedData, forKey: "myMinor")
    }
    
    func setMySemesters() {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: mySemesters)
        let defaults = UserDefaults.standard
        defaults.set(encodedData, forKey: "mySemesters")
    }
}

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
            let collegeString = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as! String
            myCollege = stringToCollege(collegeString: collegeString)
        }
        if let decodedData = defaults.object(forKey: "myMajor") as! Data? {
            let majorString = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as! String
            myMajor = stringToMajor(majorString: majorString)
        }
        if let decodedData = defaults.object(forKey: "myMinor") as! Data? {
            let minorString = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as! String
            myMinor = stringToMinor(minorString: minorString)
        }
    }
    
    func stringToCollege(collegeString: String) -> College {
        return College(Enum: requirementData.stringCollegeDict[collegeString]!, requirements: requirementData.getCollegeRequirements(collegeName: collegeString))
    }
    
    func stringToMajor(majorString: String) -> Major {
        return Major(Enum: requirementData.stringMajorDict[majorString]!, requirements: [])
    }
    
    func stringToMinor(minorString: String) -> Minor {
        return Minor(Enum: requirementData.stringMinorDict[minorString]!, requirements: [])
    }
    
    
    @objc func setCollege(college: College)  {
        myCollege = college
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: myCollege.getTitle())
        let defaults = UserDefaults.standard
        defaults.set(encodedData, forKey: "myCollege")
    }
    
    func setMajor(major: Major) {
        myMajor = major
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: myMajor.getTitle())
        let defaults = UserDefaults.standard
        defaults.set(encodedData, forKey: "myMajor")
    }
    
    func setMinor(minor: Minor) {
        myMinor = minor
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: myMinor.getTitle())
        let defaults = UserDefaults.standard
        defaults.set(encodedData, forKey: "myMinor")
    }
    
    func setMySemesters() {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: mySemesters)
        let defaults = UserDefaults.standard
        defaults.set(encodedData, forKey: "mySemesters")
    }
    
    func resetUserInfo() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "myCollege")
        defaults.removeObject(forKey: "myMajor")
        defaults.removeObject(forKey: "myMinor")
        myMajor = nil
        myCollege = nil
        myMinor = nil
    }
}

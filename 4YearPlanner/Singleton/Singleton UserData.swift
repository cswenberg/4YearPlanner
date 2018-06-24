//
//  Singleton UserData.swift
//  4YearPlanner
//
//  Created by Conner Swenberg on 6/5/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

var userData = userInfo()

class userInfo {
    
    var mySemesters: [Semester] = [Semester(number: 1),Semester(number: 2),Semester(number: 3),Semester(number: 4),Semester(number: 5),Semester(number: 6),Semester(number: 7),Semester(number: 8)]
    var myCollege: College!
    var myMajor: Major!
    var myMinor: Minor!
    
    var tmpClass: Class!
    
    func loadDefaults() {
        let defaults = UserDefaults.standard

        if let decodedData = defaults.data(forKey: "myCollege") {
            let collegeString = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as! String
            myCollege = stringToCollege(collegeString: collegeString)
        }
        if let decodedData = defaults.data(forKey: "myMajor") {
            let majorString = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as! String
            myMajor = stringToMajor(majorString: majorString)
        }
        if let decodedData = defaults.data(forKey: "myMinor") {
            let minorString = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as! String
            myMinor = stringToMinor(minorString: minorString)
        }
        if let decodedData = defaults.data(forKey: "selectedTheme") {
            let theme = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as! String
            aesthetics.selectedTheme = theme
        }
        if let decodedData = defaults.data(forKey: "mySemesters") {
            let semesters = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as! [Semester]
            mySemesters = semesters
        }
        aesthetics.updateTheme()
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
    
    func setCollege(college: College)  {
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
    
    func saveSemesters() {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: mySemesters)
        let defaults = UserDefaults.standard
        defaults.set(encodedData, forKey: "mySemesters")
    }
    
    func setTheme() {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: aesthetics.selectedTheme)
        let defaults = UserDefaults.standard
        defaults.set(encodedData, forKey: "selectedTheme")
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
    
    func resetSemesters() {
        for eachsemester in mySemesters {
            eachsemester.wipe()
        }
        saveSemesters()
    }
    
    func saveCourse() {
        mySemesters[sharedVars.selected_semester-1].addClass(newclass: tmpClass)
        print("class saved to schedule")
    }
    
    func printSemester(number: Int) {
        for each in mySemesters[number].classes {
            print(each.classLabel())
        }
    }
}

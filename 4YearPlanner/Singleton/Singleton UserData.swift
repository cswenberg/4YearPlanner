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
    
    let defaults = UserDefaults.standard
    var mySemesters: [Semester] = [Semester(number: 1),Semester(number: 2),Semester(number: 3),Semester(number: 4),Semester(number: 5),Semester(number: 6),Semester(number: 7),Semester(number: 8)]
    var myCollege: College!
    var myMajor: Major!
    var myMinor: Minor!
    var myRequirements: [Requirement]!
    
    var tmpClass: Class!
    var allCourses = [Class]()
    
    func fakeLoadDefaults() {
        myCollege = requirementData.Engineering
        myMajor = requirementData.aep
        myMinor = requirementData.noMinor
        aesthetics.updateTheme()
    }
    
    // Loads user info
    func loadDefaults() {
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
            let theme = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as! Theme
            aesthetics.selectedTheme2 = theme
            print("theme loaded")
        }
 
        if let decodedData = defaults.data(forKey: "mySemesters") {
            let semesters = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as! [Semester]
            mySemesters = semesters
        }
        if let decodedData = defaults.data(forKey: "allCourses") {
            let courses = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as! [Class]
            allCourses = courses
            sharedVars.allCourses = allCourses
        }
        aesthetics.updateTheme()
    }
    
    // Turns a string that represents a college into the College Class
    func stringToCollege(collegeString: String) -> College {
        for each in requirementData.allColleges {
            if each.title == collegeString {
                return each
            }
        }
        return requirementData.Engineering
    }

    // Turns a string that represents a major into the Major Class
    func stringToMajor(majorString: String) -> Major {
        for each in myCollege.majorOptions {
            if each.title == majorString {
                return each
            }
        }
        return requirementData.imEng
    }
    
    // Turns a string that represents a minor into the Minor Class
    func stringToMinor(minorString: String) -> Minor {
        for each in requirementData.allMinors {
            if each.title == minorString {
                return each
            }
        }
        return requirementData.noMinor
    }

    
    // Stores user's college data
    func setCollege(college: College)  {
        myCollege = college
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: myCollege.title)
        defaults.set(encodedData, forKey: "myCollege")
    }
    
    // Stores user's major data
    func setMajor(major: Major) {
        myMajor = major
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: myMajor.title)
        defaults.set(encodedData, forKey: "myMajor")
    }
    
    // Stores user's minor data
    func setMinor(minor: Minor) {
        myMinor = minor
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: myMinor.title)
        defaults.set(encodedData, forKey: "myMinor")
    }
    
    // Store user's Semester data
    func saveSemesters() {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: mySemesters)
        defaults.set(encodedData, forKey: "mySemesters")
    }
    
    // Store user's Theme data
    func setTheme() {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: aesthetics.selectedTheme2)
        defaults.set(encodedData, forKey: "selectedTheme")
    }
    
    // reset user's academic information
    func resetUserInfo() {
        defaults.removeObject(forKey: "myCollege")
        defaults.removeObject(forKey: "myMajor")
        defaults.removeObject(forKey: "myMinor")
        myMajor = nil
        myCollege = nil
        myMinor = nil
    }
    
    // reset all of the user's semesters
    func resetSemesters() {
        for eachsemester in mySemesters {
            eachsemester.wipe()
        }
        saveSemesters()
    }
    
    // Add course to schedule
    func saveCourse() {
        mySemesters[sharedVars.selected_semester-1].addClass(newclass: tmpClass)
        print("class saved to schedule")
    }
    
    // Print all classes in a specified semester
    func printSemester(number: Int) {
        for each in mySemesters[number].classes {
            print(each.classLabel())
        }
    }
    
    // Returns True if a semester is not empty
    func hasCourses() -> Bool {
        for each in mySemesters {
            if each.classes.count>0 {return true}
        }
        return false
    }
    
    // Stores all courses from DB into app
    func saveAllCourses() {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: allCourses)
        let defaults = UserDefaults.standard
        defaults.set(encodedData, forKey: "allCourses")
    }
}

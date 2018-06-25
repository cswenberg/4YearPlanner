//
//  Singleton Vars.swift
//  4YearPlanner
//
//  Created by Omar Rasheed on 5/1/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import Foundation
import UIKit

var sharedVars = globalVars()

class globalVars {
    
    var current_tab: String = ""
    func setTab() {
        current_tab = "Discover"
        if userData.hasCourses() {
            current_tab = "My Schedule"
        }
    }
    
    var current_category: String = ""
    func setCategory() {
        if userData.myCollege == nil {
            current_category = "Colleges"
        } else if userData.myMajor == nil {
            current_category = "Majors"
        } else if userData.myMinor == nil {
            current_category = "Minors"
        } else {
            current_category = "Courses"
        }
    }
    
    var current_term = "Fall"
    var selected_semester = 1
    var discoverCourses = [Class]()
    var allCourses = [Class]()
    var searchSubject = ""
    var searchNumber = ""
    var searchTerm = ""
    var searchCourse = "Math 1920"
    
    func yearTerm() -> String {
        var year: String
        var term: String
        if selected_semester % 2 == 1 {
            term = "Fall"
        } else { term = "Spring"}
        if selected_semester<=2 {year = "Freshman"}
        else if selected_semester<=4 {year = "Sophomore"}
        else if selected_semester<=6 {year="Junior"}
        else {year="Senior"}
        return year+" "+term
    }
    
    let logicFilterWords = ["and", "or", "either", "as well as", "through"]
    let otherFilterWords = ["equivalent", "equivalents", "Recommended prerequisite:", "Recommended corequisite:", "Prerequisite:"]
    let punctuationFilters = [".", ",", ";", "(", ")", ":", "/", "-"]
    let numberFilters = ["1","2","3","4","5","6","7","8","9","0"]
}

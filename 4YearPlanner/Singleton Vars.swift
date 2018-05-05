//
//  Singleton Vars.swift
//  4YearPlanner
//
//  Created by Omar Rasheed on 5/1/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import Foundation

var sharedVars = globalVars()

class globalVars {
    
    var current_tab = "Discover"
    var current_category = "Colleges"
    var current_term = "Fall"
    var selected_semester = 1
    let cellGradientList = [[0.0, 0.0, 0.0, 1.0]]
    var mySemesters: [Semester] = [Semester(number: 1),Semester(number: 2),Semester(number: 3),Semester(number: 4),Semester(number: 5),Semester(number: 6),Semester(number: 7),Semester(number: 8)]
    var myCollege: College!
    var myMajor: Major!
    var myMinor: Requirements!
    var discoverCourses = [Class]()
    
    var searchSubject = ""
    var searchNumber = ""
    var searchTerm = ""
    
}

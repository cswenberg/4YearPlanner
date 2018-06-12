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
        if userData.myMinor != nil {
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
    var loadedNewCourses = false

}

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
    let cellGradientList = [[0.0, 0.0, 0.0, 1.0]]
    var discoverCourses = [Class]()
    var allCourses = [Class]()
    var searchSubject = ""
    var searchNumber = ""
    var searchTerm = ""
    var loadedNewCourses = false
    
    var tabGradient = [UIColor(red: 9/255, green: 154/255, blue: 255/255, alpha: 1).cgColor, UIColor(red: 202/255, green: 227/255, blue: 255/255, alpha: 1).cgColor]
    var gradientList = [[UIColor(red: 241/255, green: 178/255, blue: 122/255, alpha: 1).cgColor, UIColor(red: 219/255, green: 86/255, blue: 147/255, alpha: 1).cgColor],
                        [UIColor(red: 139/255, green: 112/217, blue: 217/255, alpha: 1).cgColor, UIColor(red: 214/255, green: 147/255, blue: 225/255, alpha: 1).cgColor],
                        [UIColor(red: 71/255, green: 166/255, blue: 252/255, alpha: 1).cgColor, UIColor(red: 54/255, green: 229/255, blue: 211/255, alpha: 1).cgColor],
                        [UIColor(red: 94/255, green: 210/255, blue: 133/255, alpha: 1).cgColor , UIColor(red: 69/255, green: 225/255, blue: 197/255, alpha: 1).cgColor]]
    var gradientRandomizer = 0
    
    var termColor = UIColor(red: 120/255, green: 154/255, blue: 241/255, alpha: 1)
    var searchBarGray = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
    var orange = UIColor(red: 241, green: 178, blue: 122, alpha: 1)
    var nextorange = UIColor(red: 219, green: 86, blue: 147, alpha: 1)
    var iceBlue = UIColor(red: 204, green: 255, blue: 255, alpha: 1)
    var redOrange = UIColor(red: 255, green: 80, blue: 80, alpha: 1)
    var lightOrange = UIColor(red: 255, green: 531, blue: 51, alpha: 1)
    var lightPurp = UIColor(red: 203, green: 153, blue: 255, alpha: 1)
    var deepPurp = UIColor(red: 102, green: 0, blue: 204, alpha: 1)
    var cyan = UIColor(red: 102, green: 255, blue: 255, alpha: 1)
    var cerulean = UIColor(red: 0, green: 204, blue: 153, alpha: 1)
    var limeGreen = UIColor(red: 153, green: 255, blue: 102, alpha: 1)
    var lightPink = UIColor(red: 255, green: 204, blue: 255, alpha: 1)
    var regularPink = UIColor(red: 255, green: 102, blue: 204, alpha: 1)
    let niceOrange = UIColor(red: 1, green: 0.73, blue: 0.19, alpha: 1)
    let niceGreen = UIColor(red: 0.25, green: 0.85, blue: 0.51, alpha: 1)
}

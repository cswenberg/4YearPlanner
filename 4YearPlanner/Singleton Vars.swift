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
    var selected_semester: Int!
    let cellGradientList = [[0.0, 0.0, 0.0, 1.0]]

}

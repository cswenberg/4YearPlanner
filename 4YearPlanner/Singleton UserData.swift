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
}

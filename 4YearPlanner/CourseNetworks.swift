//
//  CourseNetworks.swift
//  4YearPlanner
//
//  Created by Omar Rasheed on 5/1/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

class Network {
    private static let endpoint = "http://35.190.187.113/planner/courses"
    
    static func getAllCourses(_ completion: @escaping ([Class]) -> Void) {
    
        
        Alamofire.request(endpoint).responseJSON { (response) in
            
            switch response.result {
                
            case .success(let json):
                
                let json = JSON(json)
                var classes = [Class]()
                
                for each in json["data"]["courses"].arrayValue {
                    classes.append(Class(from: each))
                }
                sharedVars.discoverCourses = []
                sharedVars.discoverCourses = classes
                sharedVars.allCourses = classes
            
            case .failure(let error):
                print("Error", error)
                completion([])
            }
        }
    }
    
    static func getCourses(_ completion: @escaping ([Class]) -> Void) {
        let term: String
        var parameters = Parameters()
        if sharedVars.searchTerm == ""{
            term = "fall and spring"
        } else {
            term = sharedVars.searchTerm
        }
        if sharedVars.searchSubject != "" {parameters["subject"]=sharedVars.searchSubject}
        if sharedVars.searchNumber != "" {parameters["number"]=sharedVars.searchNumber}
        if sharedVars.searchTerm != "" {parameters["term"]=term}
        
        Alamofire.request(endpoint, parameters: parameters).validate().responseJSON { (response) in
            
            switch response.result {
                
            case .success(let json):
                
                let json = JSON(json)
                var classes: [Class] = []
                
                for each in json["data"]["courses"].arrayValue {
                    classes.append(Class(from: each))
                }
                sharedVars.discoverCourses = []
                sharedVars.discoverCourses = classes
                
            case .failure(let error):
                print("Error", error)
                completion([])
            }
        }
    }
}

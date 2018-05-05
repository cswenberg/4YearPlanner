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
        
        let parameters: Parameters = [:]
        
        Alamofire.request(endpoint, parameters: parameters).validate().responseJSON { (response) in
            
            switch response.result {
                
            case .success(let json):
                
                let json = JSON(json)
                var classes: [Class] = []
                
                for each in json["results"].arrayValue {
                    classes.append(Class(from: each))
                }
                print("do something")
            
            case .failure(let error):
                print("Error", error)
                completion([])
            }
        }
    }
    
    static func getCourses(_ completion: @escaping ([Class]) -> Void) {
        
        let parameters: Parameters = [
            "subject" : sharedVars.searchSubject,
            "number" : sharedVars.searchNumber,
            "term" : sharedVars.searchTerm
            ]
        
        Alamofire.request(endpoint, parameters: parameters).validate().responseJSON { (response) in
            
            switch response.result {
                
            case .success(let json):
                
                let json = JSON(json)
                var classes: [Class] = []
                
                for each in json["results"].arrayValue {
                    classes.append(Class(from: each))
                }
                print("successful request")
                
            case .failure(let error):
                print("Error", error)
                completion([])
            }
        }
    }
}

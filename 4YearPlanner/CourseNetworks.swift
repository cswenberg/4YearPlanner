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

protocol networksDelegate {
    func reloadCourses()
}

class Network {
    
    static var delegate: networksDelegate?
    
    private static let endpoint = "http://52.10.105.162/planner/courses"
    
    // Pulls all of the courses from the DB
    static func getAllCourses(_ completion: @escaping ([Class]) -> Void) {
        
        Alamofire.request(endpoint).responseJSON { (response) in
            
            switch response.result {
                
            case .success(let json):
                
                let json = JSON(json)
                var classes = [Class]()
                
                for each in json["data"]["courses"].arrayValue {
                    classes.append(Class(from: each))
                }
                
                completion(classes)
            
            case .failure(let error):
                print("Error", error)
                completion([])
            }
        }
    }
    
    // Pulls the filtered courses from the DB
    static func getCourses(_ completion: @escaping ([Class]) -> Void) {
        var term: String
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
                print("success")
                let json = JSON(json)
                var classes: [Class] = []
                
                for each in json["data"]["courses"].arrayValue {
                    classes.append(Class(from: each))
                }
                completion(classes)
                
            case .failure(let error):
                print("Error", error)
                completion([])
            }
        }
    }
    
    static func getRecommendedCourses(_ completion: @escaping ([Class]) -> Void) {
        
    }
    
    /** Return a Class object given a String representation of a class
        ex: "Math 1920", "CS 2110" */
    static func getClassObject(_ completion: @escaping ([Class]) -> Void) {
        var textParams = sharedVars.searchCourse.components(separatedBy: " ")
        var params = Parameters()
        params["subject"] = textParams[0]
        params["number"] = textParams[1]
        print(params)
        var returnClass: Class?
        Alamofire.request(endpoint, parameters: params).validate().responseJSON { (response) in
            print("in request")
            switch response.result {
            case .success(let json):
                print("success")
                let json = JSON(json)
                returnClass = Class(from: json["data"]["courses"][0])
                userData.tmpClass = returnClass
                print(userData.tmpClass.classLabel())
                userData.saveCourse()
            case .failure(let error):
                print("Error", error)            }
        }
    }
    
    
    
}

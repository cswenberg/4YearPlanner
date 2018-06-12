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
    private static let endpoint = "http://54.245.146.135/planner/courses"
    
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
                sharedVars.discoverCourses = []
                sharedVars.discoverCourses = classes
                sharedVars.allCourses = classes
            
            // Change the singleton variable to stop the while loop
                sharedVars.loadedNewCourses = true
            
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
                
                let json = JSON(json)
                var classes: [Class] = []
                
                for each in json["data"]["courses"].arrayValue {
                    classes.append(Class(from: each))
                }
                sharedVars.discoverCourses = []
                sharedVars.discoverCourses = classes
                
            // Change singleton variable to stop the while loop
                sharedVars.loadedNewCourses = true
                print("done")
                
            case .failure(let error):
                print("Error", error)
                completion([])
            }
        }
    }
    
    /** Return a Class object given a String representation of a class
        ex: "Math 1920", "CS 2110" */
    static func getClassObject(course: String) {
        var textParams = course.components(separatedBy: " ")
        var params = Parameters()
        params["subject"] = textParams[0]
        params["number"] = textParams[1]
        print(params)
        var returnClass: Class = Class(subject: "", number: "", title: "", description: "", term: [""], credits: 1, prerequisites: [])
        Alamofire.request(endpoint, parameters: params).validate().responseJSON { (response) in
            print("in request")
            switch response.result {
            case .success(let json):
                print("success")
                let json = JSON(json)
                returnClass = Class(from: json["data"]["courses"][0])
                userData.tmpClass = returnClass
                print(userData.tmpClass.classLabel())
                print(returnClass.classLabel())
                sharedVars.loadedNewCourses = true
                break
            case .failure(let error):
                print("Error", error)            }
        }
        print("out of request")
    }
    
}

//
//  Class.swift
//  4YearPlanner
//
//  Created by Con Swenberg on 4/26/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import Foundation

import SwiftyJSON

/**
 An instance of Semester represents the planned class schedule for a certain semester.
 Attributes:
 number - the index of the semester, 1..8
 term - the term of semester, "Fall" or "Spring"
 classes - list of Class objects
 credits - sum of credits from classes, 0..
 numCourses - number of courses taken in semester, 0..
 */
class Semester: NSObject, NSCoding {
    
    var number: Int
    var term: String
    var classes: [Class]
    var credits: Int
    var numCourses: Int
    
    init(number: Int) {
        self.number = number
        classes = []
        credits = 0
        numCourses = 0
        if self.number%2==1 {term = "Fall"}
        else {term = "Spring"}
    }
    /** Return: boolean that answers if a certain class is being taken this semester */
    func contains(someclass: Class) -> Bool {
        for eachclass in classes {
            if eachclass.equals(someclass: someclass) {return true}
        }
        return false
    }
    /** Adds a new class to this semester's schedule */
    func addClass(newclass: Class) {
        classes.append(newclass)
        credits+=newclass.creditsChosen
        numCourses+=1
        newclass.semesterTaken = number
        userData.saveSemesters()
    }
    /** Removes a class from this semester's schedule */
    func removeClass(someclass: Class) {
        if !contains(someclass: someclass) {return}
        credits-=someclass.creditsChosen
        numCourses-=1
        someclass.semesterTaken = nil
        let index = classes.index(where: {$0.equals(someclass: someclass)})
        classes.remove(at: index!)
        userData.saveSemesters()
    }
    
    func alterCourseCredits(someclass: Class, new: Int) {
        let index = classes.index(where: {$0.equals(someclass: someclass)})
        credits-=classes[index!].creditsChosen-new
        classes[index!].creditsChosen = new
    }
    /** Return: boolean that expresses if enough credits are being taken for current schedule */
    func enoughCredits() -> Bool {
        return credits>=12
    }
    /** Return: any classes whose available terms do not match with this semester's term */
    func incorrectTerms() -> [Class] {
        var incorrectTerms = [Class]()
        for eachclass in classes {
            if !eachclass.hasTerm(someterm: term) {incorrectTerms.append(eachclass)}
        }
        return incorrectTerms
    }
    /** Removes all classes from this semester's schedule */
    func wipe() {
        for eachclass in classes {
            removeClass(someclass: eachclass)
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(number, forKey: "number")
        aCoder.encode(term, forKey: "term")
        aCoder.encode(classes, forKey: "classes")
        aCoder.encode(credits, forKey: "credits")
        aCoder.encode(numCourses, forKey: "numCourses")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.number = aDecoder.decodeInteger(forKey: "number")
        self.term = aDecoder.decodeObject(forKey: "term") as! String
        self.classes = []
        if let classes = aDecoder.decodeObject(forKey: "classes") as? [Class] {
            self.classes = classes
        }
        self.credits = aDecoder.decodeInteger(forKey: "credits")
        self.numCourses = aDecoder.decodeInteger(forKey: "numCourses")
    }
    
}
/**
 An instance of Class contains essential information about a certain course.
 Attributes:
 subject - specific subject code, i.e. "MATH", "ECON", "ENGRI", "ENGL"
 number - specific number code, i.e. "1910", "2090", "1110"
 title - title of course, i.e. "Calculus I for Engineers", "Physics: Mechanics", "American Voices"
 description - description of course material
 term - what terms course is offered, "Fall" and/or "Spring"
 credits - number of credits for course, 0..6 (0 if taken S/U)
 prerequisites - list of prerequisite classes (in reverse order)
 semesterTaken - index of semester in which this class resides in the schedule, 0..8 (nil if not taken in any semester)
 */
class Class: NSObject, NSCoding {
    
    var subject: String
    var number: String
    var title: String
    var descriptionn: String
    var term: [String]
    var semesterTaken: Int!
    var creditsChosen: Int
    var creditsMin: Int
    var creditsMax: Int
    var distribution: String
    var gradingType: String
    var academicGroup: String
    var pulledPrereqs: String?
    var stringPrerequisites = [String]()
    var prerequisites: [Class]!
    
    init(subject: String, number: String, title: String, description: String, term: [String], creditsMin: Int, creditsMax: Int, prerequisites: [Class], distribution: String, gradingType: String, academicGroup: String) {
        self.subject = subject
        self.number = number
        self.title = title
        self.descriptionn = description
        self.term = term
        self.creditsMin = creditsMin
        self.creditsMax = creditsMax
        self.prerequisites = prerequisites
        self.distribution = distribution
        self.gradingType = gradingType
        self.creditsChosen = self.creditsMin
        self.academicGroup = academicGroup
    }
    
    // initializing from API query
    init(from json: JSON) {
        self.subject = json["subject"].stringValue
        self.number = json["number"].stringValue
        self.title = json["title"].stringValue
        self.descriptionn = json["description"].stringValue
        self.term = [json["term"].stringValue]
        self.creditsMin = json["creditsMin"].intValue
        self.creditsMax = json["creditsMax"].intValue
        let pulledPrereqs2 = json["prereqs"].stringValue
        if pulledPrereqs2 == "" || pulledPrereqs2 == " " {
            self.pulledPrereqs = "None"
        } else {
            self.pulledPrereqs = pulledPrereqs2
            
        }
        let pulledDistribution = json["distribution"].stringValue
        if pulledDistribution == "" || pulledDistribution == " " {
            self.distribution = "None"
        } else {
            self.distribution = pulledDistribution
        }
        self.gradingType = json["gradingType"].stringValue
        self.creditsChosen = self.creditsMin
        self.academicGroup = json["acadGroup"].stringValue
        super.init()
        slicePulledPrereqs()
    }
    /** Return: boolean to answer if two classes are the same by comparing subject and number */
    func equals(someclass: Class) -> Bool {
        return self.subject==someclass.subject && self.number==someclass.number
    }
    /** Return: boolean that answers if a class has any prerequisites, does NOT return said prereqs if there exists any */
    func hasPrereqs() -> Bool {
        return self.prerequisites.count>0
    }
    /** Return: boolean that answers if this class is offered in some term */
    func hasTerm(someterm: String) -> Bool {
        return term.contains(someterm)
    }
    
    func classLabel() -> String {
        return subject+" "+number
    }
    
    func hasNumbers(s: String) -> Bool {
        for (_, element) in s.enumerated() {
            if ["1","2","3","4","5","6","7","8","9","0"].contains(element) {return true}
        }
        return false
    }
    
    func isOnlyNumbers(s: String) -> Bool {
        for (_, element) in s.enumerated() {
            if !["1","2","3","4","5","6","7","8","9","0"].contains(element) {return false}
        }
        return true
    }
    
    func slicePulledPrereqs() {
        if let s = pulledPrereqs?.components(separatedBy: " ") {
            if s[0] == "Prerequisite:" {
                let filter1 = filterPunctuation(strings: s)
                let filter2 = joinSubjNum(strings: filter1)
                let filter3 = joinRecommendedPrereqs(strings: filter2)
                print(filter3)
                let filter4 = joinNonsense(strings: filter3)
                print(filter4)
            }
        }
    }
    
    func filterPunctuation(strings: [String]) -> [String] {
        var newStrings = [String]()
        for each in strings {
            var newString = each
            if newString == "" {continue}
            if newString.hasSuffix(".") {newString.remove(at: newString.index(of: ".")!)}
            if newString.hasSuffix(",") {newString.remove(at: newString.index(of: ",")!)}
            if newString.hasSuffix(";") {newString.remove(at: newString.index(of: ";")!)}
            if newString.contains("/") {
                let s = newString.components(separatedBy: "/")
                newStrings.append(s[0])
                newStrings.append(s[1])
            } else if newString.contains("-") {
                let s = newString.components(separatedBy: "-")
                newStrings.append(s[0])
                newStrings.append(s[1])
            } else if newString.count>0 {newStrings.append(newString)}
        }
        newStrings.removeFirst() //removes the "Prerequisite:" from the array
        return newStrings
    }
    
    func joinSubjNum(strings: [String]) -> [String] {
        var newStrings = [String]()
        for (i, e) in strings.enumerated() {
            if e.uppercased() == e && !hasNumbers(s: e) && i<strings.count-1 && isOnlyNumbers(s: strings[i+1]) {
                let subjNum = e+" "+strings[i+1]
                newStrings.append(subjNum)
            } else if hasNumbers(s: e) && e.count == 4 {}
            else {newStrings.append(e)}
        }
        return newStrings
    }
    
    func joinRecommendedPrereqs(strings: [String]) -> [String] {
        var newStrings = [String]()
        var skip = false
        for (i, e) in strings.enumerated() {
            if (e == "Recommended" || e == "recommended") && i<strings.count-1 && (strings[i+1] == "prerequisite:" || strings[i+1] == "corequisite:") {
                let s = e+" "+strings[i+1]
                newStrings.append(s)
                skip = true
            } else if skip {skip = false}
            else {newStrings.append(e)}
        }
        return newStrings
    }
    
    func joinNonsense(strings: [String]) -> [String] {
        var newStrings = [String]()
        var start = 0
        var end = 0
        for (index, each) in strings.enumerated() {
            if sharedVars.logicFilterWords.contains(each) || sharedVars.otherFilterWords.contains(each) || each.contains(" ") {
                newStrings.append(each)
                continue
            } else if index<=end && end != 0 {continue}
            var newString = each
            start = index
            end = index+1
            let newArray = strings.suffix(from: start+1)
            for each in newArray {
                if sharedVars.logicFilterWords.contains(each) || sharedVars.otherFilterWords.contains(each) || each.contains(" ") {break}
                newString += " "+each
                end+=1
            }
            newStrings.append(newString)
        }
        return newStrings
    }
    
    func removeOrEquivalent(strings: [String]) -> [String] {
        var newStrings = [String]()
        for (i, e) in strings.enumerated() {
            if e.uppercased() == e && !hasNumbers(s: e) && i<strings.count-1 && isOnlyNumbers(s: strings[i+1]) {
                let subjNum = e+" "+strings[i+1]
                newStrings.append(subjNum)
            } else if hasNumbers(s: e) && e.count == 4 {}
            else {newStrings.append(e)}
        }
        return newStrings
    }
    
    func testForSpaces(strings: [String]) -> [String] {
        var newStrings = [String]()
        for each in strings {
            if each.contains(" ") {newStrings.append(each)}
        }
        return newStrings
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(subject, forKey: "subject")
        aCoder.encode(number, forKey: "number")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(descriptionn, forKey: "description")
        aCoder.encode(term, forKey: "term")
        aCoder.encode(creditsMin, forKey: "creditsMin")
        aCoder.encode(creditsMax, forKey: "creditsMax")
        aCoder.encode(gradingType, forKey: "gradingType")
        aCoder.encode(academicGroup, forKey: "academicGroup")
        aCoder.encode(semesterTaken, forKey: "semesterTaken")
        aCoder.encode(creditsChosen, forKey: "creditsChosen")
        if let reqs = pulledPrereqs{
            aCoder.encode(reqs, forKey: "pulledPrereqs")
            print(classLabel()+" ; "+pulledPrereqs!)
        }
        aCoder.encode(distribution, forKey: "distribution")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.subject = aDecoder.decodeObject(forKey: "subject") as! String
        self.number =  aDecoder.decodeObject(forKey: "number") as! String
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.descriptionn = aDecoder.decodeObject(forKey: "description") as! String
        self.term = aDecoder.decodeObject(forKey: "term") as! [String]
        self.creditsMin = aDecoder.decodeInteger(forKey: "creditsMin")
        self.creditsMax = aDecoder.decodeInteger(forKey: "creditsMax")
        self.prerequisites = []
        self.distribution = aDecoder.decodeObject(forKey: "distribution") as! String
        self.gradingType = aDecoder.decodeObject(forKey: "gradingType") as! String
        self.creditsChosen = aDecoder.decodeInteger(forKey: "creditsChosen")
        self.academicGroup = (aDecoder.decodeObject(forKey: "academicGroup") as? String)!
        self.pulledPrereqs = aDecoder.decodeObject(forKey: "pulledPrereqs") as? String
        print(pulledPrereqs!)
    }
}




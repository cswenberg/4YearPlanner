//
//  Requirements.swift
//  4YearPlanner
//
//  Created by Con Swenberg on 4/26/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import Foundation
/**
 An instance of Requirements represents a collection of required classes that some title/degree holds.
 Used to keep track of college, major, or minor requirements.
 Attributes:
 requirements - list of Class objects
 title - String
 */
class Requirement {
    
    var parent: Any?
    var title: String!
    var description: String!
    var satisfied: Bool!
    var nested: [Requirement]
    
    init(tit: String, desc: String, nest: [Requirement] = [], par: Any? = nil) {
        parent = par
        title = tit
        description = desc
        satisfied = false
        nested = nest
    }
    
    func addNested(req: Requirement) {
        req.parent = self
        nested.append(req)
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getDescription() -> String {
        return description
    }
    
    func getNested() -> [Requirement] {
        return nested
    }
    
    func encodeHelper(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(description, forKey: "description")
        aCoder.encode(satisfied, forKey: "satisfied")
        aCoder.encode(nested, forKey: "nested")
        if let par = parent {
            aCoder.encode(par, forKey: "parent")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.description = aDecoder.decodeObject(forKey: "description") as! String
        self.satisfied  = aDecoder.decodeObject(forKey: "satified") as! Bool
        self.nested =  aDecoder.decodeObject(forKey: "nested") as! [Requirement]
        self.parent = aDecoder.decodeObject(forKey: "parent") as Any?
    }
}
/** Course Specific Requirements are a subclass of Requirement that is composed of a list of classes that needs to be fulfilled.
 Example: All Engineers are required to take Math 1910 and Math 1920
 */
class CourseSpecific: Requirement, NSCoding {
    
    var coursesNeeded: [Class]
    var coursesPresent: [Class]
    
    init(title: String, description: String, needed: [Class], nested: [Requirement] = [], parent: Any? = nil) {
        coursesNeeded = needed
        coursesPresent = []
        super.init(tit: title, desc: description, nest: nested, par: parent)
    }
    
    func coursesUnsatisfied() -> [Class] {
        var unsatisfied: [Class] = []
        for each in coursesNeeded {
            if coursesPresent.contains(each) {
                continue
            }
            unsatisfied.append(each)
        }
        return unsatisfied
    }
    
    func encode(with aCoder: NSCoder) {
        encodeHelper(with: aCoder)
        aCoder.encode(coursesNeeded, forKey: "coursesNeeded")
        aCoder.encode(coursesPresent, forKey: "coursesPresent")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.coursesNeeded = aDecoder.decodeObject(forKey: "coursesNeeded") as! [Class]
        self.coursesPresent = aDecoder.decodeObject(forKey: "coursesPresent") as! [Class]
        super.init(coder: aDecoder)
    }
}
/** GenericType requirements are a subclass of Requirement that simply implies a specified number of typed courses is needed.
 Example: Liberal Strudies requirement for Engineers
*/
class GenericType: Requirement, NSCoding {
    
    func encode(with aCoder: NSCoder) {
        encodeHelper(with: aCoder)
        aCoder.encode(size, forKey: "size")
        aCoder.encode(completed, forKey: "completed")
        aCoder.encode(coursesUsed, forKey: "coursesUsed")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.size = aDecoder.decodeInteger(forKey: "size")
        self.completed = aDecoder.decodeInteger(forKey: "completed")
        self.coursesUsed = aDecoder.decodeObject(forKey: "coursesUsed") as! [Class]
        super.init(coder: aDecoder)
    }
    
    var size: Int
    var completed: Int
    var coursesUsed: [Class]
    
    init(title: String, description: String, number: Int, nested: [Requirement] = [], parent: Any? = nil) {
        size = number
        completed = 0
        coursesUsed = []
        super.init(tit: title, desc: description, nest: nested, par: parent)
    }
    
    func numberLeft() -> Int {
        return size - completed
    }
}



class Option: NSObject, NSCoding {
    var title: String!
    var descriptionn: String!
    var satisfied: Bool!
    var requirements: [Requirement]
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(descriptionn, forKey: "description")
        aCoder.encode(satisfied, forKey: "satisfied")
        aCoder.encode(requirements, forKey: "requirements")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.descriptionn = aDecoder.decodeObject(forKey: "description") as! String
        self.satisfied  = aDecoder.decodeObject(forKey: "satified") as! Bool
        self.requirements =  aDecoder.decodeObject(forKey: "requirements") as! [Requirement]
    }
    
    init(title: String, description: String, reqs: [Requirement]) {
        self.title = title
        self.descriptionn = description
        self.requirements = reqs
        satisfied = false
    }
    
    func getReqs() -> [Requirement] {
        return requirements
    }
    
    func addReq(req: Requirement) {
        requirements.append(req)
    }
}

class College: Option {
    
    var majorOptions: [Major]
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(majorOptions, forKey: "majorOptions")
        super.encode(with: aCoder)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.majorOptions = aDecoder.decodeObject(forKey: "majorOptions") as! [Major]
        super.init(coder: aDecoder)

    }
    
    init(title: String, description: String, majorOptions: [Major], reqs: [Requirement]) {
        self.majorOptions = majorOptions
        super.init(title: title, description: description, reqs: reqs)
    }
}

class Major: Option {

}

class Minor: Option {
    
}
























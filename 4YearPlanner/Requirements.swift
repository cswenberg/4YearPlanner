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
class Requirements {
    
    var requirements: [Class]
    var title: String
    
    init (title: String, requirements: [Class]) {
        self.requirements = requirements
        self.title = title
    }
    /** Return: list required classes that are not satisfied by input of classes,
     empty list if all requirements are fulfilled */
    func requirementsLeft(classes: [Class]) -> [Class] {
        var classesNeeded = [Class]()
        for eachclass in self.requirements {
            var check = false
            for classelem in classes {
                if eachclass.equals(someclass: classelem) {
                    check = true
                    break}
            }
            if !check {classesNeeded.append(eachclass)}
        }
        return classesNeeded
    }
    /** Return: title attribute */
    func getTitle() -> String {
        return title
    }
    /** Return: requirements attribute */
    func getRequirements() -> [Class] {
        return requirements
    }
}

class College: Requirements {
    /** Enum to represent all college options, will use cases to determine requirements by using a switch and drawing information from server */
    enum colleges {
        case engineering
        case artsnsciences
        case cals
        case hotel
        case dyson
        case architecture
    }
    
    var college: colleges
    var majorOptions: [Major.majors]
    
    init (title: colleges, requirements: [Class]) {
        var collegeTitle = ""
        var majorChoices = [Major.majors]()
        college = title
        switch college {
        case .engineering:
            collegeTitle = "Engineering"
            majorChoices = [.ece,.aep,.cheme,.meche,.orie,.bme,.cse,.isst,.mse,.civil]
        case .artsnsciences:
            collegeTitle = "Arts & Sciences"
            majorChoices = []
        case .cals:
            collegeTitle = "College of Arts & Life Sciences"
            majorChoices = []
        case .hotel:
            collegeTitle = "Hotel"
            majorChoices = []
        case .dyson:
            collegeTitle = "Dyson"
            majorChoices = []
        case .architecture:
            collegeTitle = "Architecture"
            majorChoices = []
        }
        majorOptions = majorChoices
        super.init(title: collegeTitle, requirements: requirements)
    }
}

class Major: Requirements {
    enum majors {
        case ece
        case aep
        case cheme
        case meche
        case orie
        case bme
        case cse
        case isst
        case mse
        case civil
    }
    var major: majors
    
    init (title: majors, requirements: [Class]) {
        var majorTitle = ""
        major = title
        switch major {
        case .ece:
            majorTitle = "Electrical and Computer Engineering"
        case .aep:
            majorTitle = "Applied and Engineernig Physics"
        case .cheme:
            majorTitle = "Chemical Engineering"
        case .meche:
            majorTitle = "Mechanical Engineering"
        case .orie:
            majorTitle = "Operations Research and Information Engineering"
        case .bme:
            majorTitle = "Biomedical Engineering"
        case .cse:
            majorTitle = "Computer Science Engineering"
        case .isst:
            majorTitle = "Information Science and Systems Technology"
        case .mse:
            majorTitle = "Material Science Engineering"
        case .civil:
            majorTitle = "Civil Engineering"
        }
        
        super.init(title: majorTitle, requirements: requirements)
    }
}










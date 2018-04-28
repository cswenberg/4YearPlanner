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
enum colleges: String {
    case engineering = "Engineering"
    case artsnsciences = "Arts and Sciences"
    case cals = "CALS"
    case hotel = "Hotel Administration"
    case dyson = "Dyson Business School"
    case architecture = "Art, Architecture, and Planning"
}

enum majors: String {
    case ece = "Electrical and Computer Engineering"
    case aep = "Applied Engineering Physics"
    case cheme = "Chemical Engineering"
    case meche = "Mechanical Engineering"
    case orie = "Operations Research"
    case bme = "Biomedical Engineering"
    case cs = "Computer Science"
    case isst = "Information Science and Technology"
    case mse = "Materials Science"
    case civil = "Civil Engineering"
}

let allColleges: [colleges] = [.engineering, .artsnsciences, .cals, .hotel, .dyson, .architecture]

let allMajors: [majors] = [.ece, .aep, .cheme, .meche, .orie, .bme, .cs, .isst, .mse, .civil]

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
    
    var college: colleges
    var majorOptions: [majors]
    
    init (title: colleges, requirements: [Class]) {
        var collegeTitle = ""
        var majorChoices = [majors]()
        college = title
        switch college {
        case .engineering:
            collegeTitle = "Engineering"
            majorChoices = [.ece,.aep,.cheme,.meche,.orie,.bme,.cs,.isst,.mse,.civil]
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
        case .cs:
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










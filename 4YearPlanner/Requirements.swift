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
    case aep = "Applied and Engineering Physics"
    case cheme = "Chemical Engineering"
    case meche = "Mechanical Engineering"
    case orie = "Operations Research and Information Engineering"
    case bme = "Biomedical Engineering"
    case cs = "Computer Science"
    case isst = "Information Science and Systems Technology"
    case mse = "Materials Science Engineering"
    case civil = "Civil Engineering"
}

enum minors: String {
    case nm = "No Minor"
    case ase = "Aerospace Engineering"
    case am = "Applied Mathematics"
    case be = "Biological Engineering"
    case bme = "Biomedical Engineering"
    case bus = "Business for Engineering Students"
    case civ = "Civil Infrastructure"
    case cs = "Computer Science"
    case ece = "Electrical and Computer Engineering"
    case ee = "Engineering Entrepreneurship"
    case em = "Engineering Management"
    case es = "Engineering Statistics"
    case env = "Environmental Engineering"
    case gd = "Game Design"
    case isst = "Industrial Systems and Information Technology"
    case info = "Information Science"
    case mse = "Materials Science and Engineering"
    case meche = "Mechanical Engineering"
    case orie = "Operations Research and Management Science"
    case ses = "Science of Earth Systems"
    case sust = "Sustainable Energu Systems"
}

let allColleges: [colleges] = [.engineering, .artsnsciences, .cals, .hotel, .dyson, .architecture]

let allMinors: [minors] = [.nm,.ase, .am, .be, .bme, .bus, .civ, .cs, .ece, .ee, .em, .es, .env, .gd, .isst, .info, .mse, .meche, .orie, .ses, .sust]

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
    
    func friendlyTitle() -> String {
        return title
    }
}


class College: Requirements {
    /** Enum to represent all college options, will use cases to determine requirements by using a switch and drawing information from server */
    
    var college: colleges
    var majorOptions: [majors]
    
    init (title: colleges, requirements: [Class]) {
        var majorChoices = [majors]()
        college = title
        let collegeTitle = college.rawValue
        switch college {
        case .engineering:
            majorChoices = [.ece,.aep,.cheme,.meche,.orie,.bme,.cs,.isst,.mse,.civil]
        case .artsnsciences:
            majorChoices = []
        case .cals:
            majorChoices = []
        case .hotel:
            majorChoices = []
        case .dyson:
            majorChoices = []
        case .architecture:
            majorChoices = []
        }
        majorOptions = majorChoices
        super.init(title: collegeTitle, requirements: requirements)
    }
    
    override func friendlyTitle() -> String {
        var friendlyTitle = title
        switch college {
        case .cals:
            friendlyTitle = "College of Arts\n&\nLife Sciences"
        case .artsnsciences:
            friendlyTitle = "Arts\n&\nSciences"
        case .engineering:
            break
        case .hotel:
            break
        case .dyson:
            break
        case .architecture:
            break
        }
        return friendlyTitle
    }
}

class Major: Requirements {

    var major: majors
    
    init (title: majors, requirements: [Class]) {
        major = title
        let majorTitle = major.rawValue

        
        super.init(title: majorTitle, requirements: requirements)
    }
    
    override func friendlyTitle() -> String {
        var friendlyTitle = title
        switch major {
        case .ece:
            friendlyTitle = "Electrical and\nComputer Engineering"
        case .aep:
            friendlyTitle = "Applied and\nEngineering Physics"
        case .cheme:
            break
        case .meche:
            break
        case .orie:
            friendlyTitle = "Operations Research\nand\nInformation Engineering"
        case .bme:
            break
        case .cs:
            break
        case .isst:
            friendlyTitle = "Information Science\nand\nSystems Engineering"
        case .mse:
            break
        case .civil:
            break
        }
        return friendlyTitle
    }
}

class Minors: Requirements {
    var minor: minors
    
    init(title: minors, requirements: [Class]) {
        self.minor = title
        let minorTitle = minor.rawValue
        super.init(title: minorTitle, requirements: requirements)
    }
}










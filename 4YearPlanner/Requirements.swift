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
    case ilr = "Industrial Labor Relations"
}

enum majors: String {
    //engineering
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
    //arts and sciences
    case music = "Music"
    case sts = "Science and Technology Studies"
    case gov = "Government"
    case scholar = "College Scholar"
    case asian = "Asian Studies"
    case soc = "Sociology"
    case eng = "English"
    case arch = "Archaeology"
    case infsc = "Information Science"
    case complit = "Comparitive Literature"
    case ses = "Science of Earth Systems"
    case astro = "Astronomy"
    case acompsci = "Computer Science "
    case phys = "Physics"
    case ling = "Linguistics"
    case germstud = "German Studies"
    case chinpacstud = "Chinese & Asian-Pacific Studies"
    case hist = "History"
    case astats = "Statistical Science"
    case achem = "Chemistry & Chemical Biology"
    case french = "French"
    case anthro = "Anthropology"
    case ital = "Italian"
    case amerstud = "American Studies"
    case psych = "Psychology"
    case fem = "Feminist, Gender & Sexual Studies"
    case span = "Spanish"
    case afristud = "Africana Studies"
    case neaststud = "Near Eastern Studies"
    case relig = "Religious Studies"
    case perfmed = "Performin & Media Arts"
    case aecon = "Economics"
    case amath = "Mathematics"
    case classic = "Classics"
    case philos = "Philosophy"
    case aBS = "Biology & Society"
    case histart = "History of Art"
    case im = "Independent Major"
    case biologsci = "Biological Sciences"
    //cals
    case agsci = "Agricultural Science"
    case atmosci = "Atmospheric Science"
    case anisci = "Animal Science"
    case aem = "Applied Economics and Management"
    case bioeng = "Biological Engineering"
    case biomstat = "Biometry and Statistics"
    case comm = "Communications"
    case devsoc = "Devlopment Sociology"
    case ento = "Entomology"
    case ess = "Environmental and Sustainability Sciences"
    case enveng = "Environmental Engineering"
    case foodsci = "Food Science"
    case gphs = "Global and Public Health Sciences"
    case iard = "International Agriculture and Rural Developments"
    case landarch = "Landscape Architecture"
    case nutrisci = "Nutrional Science"
    case plantsci = "Plant Science"
    case vines = "Vineculture and Enology"
    //hotel
    case smom = "Services Marketing and Operations Management"
    case hold = "Hospitality Leadership"
    case fare = "Finance, Accounting, & Real Estate"
    //ilr
    case ilr = "Industrial Labor Relations"
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
    case sust = "Sustainable Energy Systems"
}

let allColleges: [colleges] = [.engineering, .artsnsciences, .cals, .hotel, .dyson, .architecture, .ilr]

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
            majorChoices = [.ece,.aep,.cheme,.meche,.orie,.bme,.cs,.isst,.mse,.civil,.im]
        case .artsnsciences:
            majorChoices = [.music,.sts,.gov,.scholar,.asian,.soc,.eng,.arch,.infsc,.complit,.ses,.astro,.cs,.phys,.ling,.germstud,.chinpacstud,.hist,.astats,.achem,.french,.anthro,.ital,.amerstud,.psych,.fem,.span,.afristud,.neaststud,.relig,.perfmed,.aecon,.amath,.classic,.philos,.aBS,.histart,.im,.biologsci]
        case .cals:
            majorChoices = [.agsci,.atmosci,.anisci,.aem,.bioeng,.biomstat,.comm,.devsoc,.ento,.ess,.enveng,.foodsci,.gphs,.iard,.landarch,.nutrisci,.plantsci,.vines,.infsc,.ses]
        case .hotel:
            majorChoices = [.smom,.hold,.fare]
        case .dyson:
            majorChoices = [.aem]
        case .architecture:
            majorChoices = [.arch]
        case .ilr:
            majorChoices = [.ilr]
        }
        majorOptions = majorChoices
        super.init(title: collegeTitle, requirements: requirements)
    }
    
    override func friendlyTitle() -> String {
        var friendlyTitle = title
        switch college {
        case .cals:
            friendlyTitle = "CALS"
        case .artsnsciences:
            friendlyTitle = "Arts\n&\nSciences"
        case .engineering:
            break
        case .hotel:
            friendlyTitle = "Hotel Admin."
            break
        case .dyson:
            friendlyTitle = "Dyson"
            break
        case .architecture:
            friendlyTitle = "AAP"
            break
        case .ilr:
            friendlyTitle = "ILR"
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
}

class Minors: Requirements {
    var minor: minors
    
    init(title: minors, requirements: [Class]) {
        self.minor = title
        let minorTitle = minor.rawValue
        super.init(title: minorTitle, requirements: requirements)
    }
}










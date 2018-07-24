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

enum engStuff: String {
    case engri
    case cs
    case liberalarts
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
    case engl = "English"
    case archae = "Archaeology"
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
    case perfmed = "Performing & Media Arts"
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
    case nutrisci = "Nutritional Science"
    case plantsci = "Plant Science"
    case vines = "Vineculture and Enology"
    //hotel
    case smom = "Services Marketing and Operations Management"
    case hold = "Hospitality Leadership"
    case fare = "Finance, Accounting, & Real Estate"
    //ilr
    case ilr = "Industrial Labor Relations"
    //aep
    case archi = "Architecture, Art, and Planning"
}

enum minors: String {
    case nm = "No Minor"
    //engineering
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
    case isit = "Industrial Systems and Information Technology"
    case infosci = "Information Science"
    case mse = "Materials Science and Engineering"
    case meche = "Mechanical Engineering"
    case orie = "Operations Research and Management Science"
    case ses = "Science of Earth Systems"
    case sust = "Sustainable Energy Systems"
    //arts and sciences
    case esa = "Eastern Asian Studies"
    case cogsci = "Cognitive Science"
    case math = "Mathematics"
    case pma = "Performing & Media Arts"
    case js = "Jewish Studies"
    case ams = "American Studies"
    case infoa = "Information Science "
    case music = "Music"
    case hist = "History"
    case vs = "Visual Studies"
    case eng = "English"
    case clciv = "Classical Civilization"
    case scies = "Science of Earth Systems "
    case mitw = "Minority, Indienous & Third World Studies"
    case aas = "Asian American Studies"
    case sas = "South Asian Studies"
    case phil = "Philosophy"
    case las = "Latin American Studies"
    case gs = "German Studies"
    case arab = "Arabic"
    case ls = "Law and Society"
    case ast = "Astronomy"
    case rus = "Russian"
    case theat = "Theatre"
    case medi = "Medival Studies"
    case vik = "Viking Studies"
    case cita = "Computing in the Arts"
    case phys = "Physics"
    case ins = "Inequality Studies"
    case gad = "Game Design "
    case fren = "French"
    case hista = "History of Art"
    case seas = "Southeast Asian Studies"
    case ling = "Linguistics"
    case pbs = "Portuguese & Brazilian Studies"
    case cpej = "Crime, Prisons, Education & Justice"
    case hc = "History of Capitalism"
    case ital = "Italian"
    case nes = "Near Eastern Studies"
    case biosci = "Biological Sciences"
    case csa = "Computer Science "
    case dan = "Dance"
    case lat = "Latina/o Studies"
    case rels = "Religious Studies"
    case clas = "Classics"
    case ixr = "International Relations"
    case arch = "Archaeology"
    case caps = "China & Asia-Pacific Studies"
    case psych = "Psychology"
    case sts = "Science & Technology Studies"
    case anthr = "Anthropology"
    case film = "Film"
    case afr = "Africana Studies"
    case cw = "Creative Writing"
    case lgbt = "LGBT Studies"
    case span = "Spanish"
    case fgs = "Feminist, Gender & Sexuality Studies"
    // Hotel
    case re = "Real Estate"
    //Cals
    case agm = "Agricultural Management"
    case aiis = "American Indian and Indigenous Studies"
    case anisci = "Animal Science"
    case appe = "Applied Economics"
    case atmosci = "Atmospheric Science"
    case biosc = "Biological Science"
    case biostat = "Biometry and Statistics"
    case busi = "Business"
    case cc = "Climate Change"
    case comm = "Communication"
    case cfs = "Community Food Systems"
    case cm = "Crop Management"
    case dscoc = "Development Sociology"
    case edu = "Education"
    case ent = "Entomology"
    case eer = "Environmental, Energy, and Resource Economics"
    case ess = "Environmental & Sustainability Sciences"
    case foodsci = "Food Science"
    case ged = "Globalization, Ethnicity & Development"
    case hort = "Horticulture"
    case hfba = "Horticulture with a Focus in the Botanical Arts"
    case idb = "Infectious Disease Biology"
    case infos = " Information Science"
    case ids = "International Development Studies"
    case itd = "International Trade & Development"
    case lands = "Landscape Studies"
    case lead = "Leadership"
    case marb = "Marine Biology"
    case nutri = "Nutrition & Health"
    case plb = "Plant Breeding"
    case scie = "Sciene of Earth Systems"
    case sois = "Soil Systems"
    case viti = "Viticulture & Enology"
}

// NEW SHIT YA BOIIIIIII //

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

class College: Requirement, NSCoding {
    func encode(with aCoder: NSCoder) {
        encodeHelper(with: aCoder)
        aCoder.encode(majorOptions, forKey: "majorOptions")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.majorOptions = aDecoder.decodeObject(forKey: "majorOptions") as! [Major]
        super.init(coder: aDecoder)

    }
    var majorOptions: [Major]
    
    init(title: String, description: String, majorOptions: [Major], reqs: [Requirement]) {
        self.majorOptions = majorOptions
        super.init(tit: title, desc: description, nest: reqs)
    }
    //naming changed to be more expressive
    func getReqs() -> [Requirement] {
        return getNested()
    }
    //naming changed to be more expressive
    func addReq(req: Requirement) {
        addNested(req: req)
    }
}

class Major: Requirement, NSCoding {
    func encode(with aCoder: NSCoder) {
        encodeHelper(with: aCoder)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    init(title: String, description: String, reqs: [Requirement]){
        super.init(tit: title, desc: description, nest: reqs)
    }
    //naming changed to be more expressive
    func getReqs() -> [Requirement] {
        return getNested()
    }
    //naming changed to be more expressive
    func addReq(req: Requirement) {
        addNested(req: req)
    }
}

class Minor: Requirement, NSCoding {
    func encode(with aCoder: NSCoder) {
        encodeHelper(with: aCoder)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    init(title: String, description: String, reqs: [Requirement]) {
        super.init(tit: title, desc: description, nest: reqs)
    }
    //naming changed to be more expressive
    func getReqs() -> [Requirement] {
        return getNested()
    }
    //naming changed to be more expressive
    func addReq(req: Requirement) {
        addNested(req: req)
    }
}
























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
    case isst = "Industrial Systems and Information Technology"
    case info = "Information Science"
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

let allColleges: [colleges] = [.engineering, .artsnsciences, .cals, .hotel, .dyson, .architecture, .ilr]

let allEngMinors: [minors] = [.nm,.ase, .am, .be, .bme, .bus, .civ, .cs, .ece, .ee, .em, .es, .env, .gd, .isst, .info, .mse, .meche, .orie, .ses, .sust]

let allCals: [minors] = [.agm, .aiis, .anisci, .appe, .atmosci, .biosc, .biostat, .busi, .cc, .comm, .cfs, .cm, .dscoc, .edu, .ent, .eer ,.ess, .foodsci, .ged, .hort, .hfba, .idb, .infos, .ids, .itd, .lands, .lead, .marb, .nutri, .plb, .scie, .sois, .viti]

let allAS: [minors] = [.esa, .cogsci, .math, .pma, .js, .ams, .infoa, .music, .hist, .vs, .eng, .clciv, .scies, .mitw, .aas, .sas, .phil, .las, .gs, .arab, .ls, .ast, .rus, .theat, .medi, .vik, .cita, .phys, .ins, .gad, .fren, .hista, .seas, .ling, .pbs, .cpej, .hc, .ital, .nes, .biosci, .csa, .dan, .lat, .rels, .clas, .ixr, .arch, .caps, .psych, .sts, .anthr, .film, .afr, .cw, .lgbt, .span, .fgs]

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
    var minorOptions: [minors]
    
    init (title: majors, requirements: [Class]) {
        major = title
        let majorTitle = major.rawValue
        switch major  {
        case .ece:
            minorOptions = allEngMinors
        case .aep:
            minorOptions = allEngMinors
        case .cheme:
            minorOptions = allEngMinors
        case .meche:
            minorOptions = allEngMinors
        case .orie:
            minorOptions = allEngMinors
        case .bme:
            minorOptions = allEngMinors
        case .cs:
            minorOptions = allEngMinors
        case .isst:
            minorOptions = allEngMinors
        case .mse:
            minorOptions = allEngMinors
        case .civil:
            minorOptions = allEngMinors
        case .music:
            minorOptions = allAS
        case .sts:
            minorOptions = allAS
        case .gov:
            minorOptions = allAS
        case .scholar:
            minorOptions = allAS
        case .asian:
            minorOptions = allAS
        case .soc:
            minorOptions = allAS
        case .eng:
            minorOptions = allAS
        case .arch:
            minorOptions = allAS
        case .infsc:
            minorOptions = allAS
        case .complit:
            minorOptions = allAS
        case .ses:
            minorOptions = allAS
        case .astro:
            minorOptions = allAS
        case .acompsci:
            minorOptions = allAS
        case .phys:
            minorOptions = allAS
        case .ling:
            minorOptions = allAS
        case .germstud:
            minorOptions = allAS
        case .chinpacstud:
            minorOptions = allAS
        case .hist:
            minorOptions = allAS
        case .astats:
            minorOptions = allAS
        case .achem:
            minorOptions = allAS
        case .french:
            minorOptions = allAS
        case .anthro:
            minorOptions = allAS
        case .ital:
            minorOptions = allAS
        case .amerstud:
            minorOptions = allAS
        case .psych:
            minorOptions = allAS
        case .fem:
            minorOptions = allAS
        case .span:
            minorOptions = allAS
        case .afristud:
            minorOptions = allAS
        case .neaststud:
            minorOptions = allAS
        case .relig:
            minorOptions = allAS
        case .perfmed:
            minorOptions = allAS
        case .aecon:
            minorOptions = allAS
        case .amath:
            minorOptions = allAS
        case .classic:
            minorOptions = allAS
        case .philos:
            minorOptions = allAS
        case .aBS:
            minorOptions = allAS
        case .histart:
            minorOptions = allAS
        case .im:
            minorOptions = allAS
        case .biologsci:
            minorOptions = allAS
        case .agsci:
            minorOptions = allCals
        case .atmosci:
            minorOptions = allCals
        case .anisci:
            minorOptions = allCals
        case .aem:
            minorOptions = allCals
        case .bioeng:
            minorOptions = allCals
        case .biomstat:
            minorOptions = allCals
        case .comm:
            minorOptions = allCals
        case .devsoc:
            minorOptions = allCals
        case .ento:
            minorOptions = allCals
        case .ess:
            minorOptions = allCals
        case .enveng:
            minorOptions = allCals
        case .foodsci:
            minorOptions = allCals
        case .gphs:
            minorOptions = allCals
        case .iard:
            minorOptions = allCals
        case .landarch:
            minorOptions = allCals
        case .nutrisci:
            minorOptions = allCals
        case .plantsci:
            minorOptions = allCals
        case .vines:
            minorOptions = allCals
        case .smom:
            minorOptions = allAS
        case .hold:
            minorOptions = allAS
        case .fare:
            minorOptions = allAS
        case .ilr:
            minorOptions = allAS
        }

        
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










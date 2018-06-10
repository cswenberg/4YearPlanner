//
//  Singelton Requirements.swift
//  4YearPlanner
//
//  Created by Conner Swenberg on 6/4/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import Foundation
import UIKit

var requirementData = globalRequirements()

class globalRequirements {
    //College data
    let allColleges: [colleges] = [.engineering, .artsnsciences, .cals, .hotel, .dyson, .architecture, .ilr]
    
    //Major data
    var engMajorOptions: [majors] = [.ece,.aep,.cheme,.meche,.orie,.bme,.cs,.isst,.mse,.civil,.im]
    var artsMajorOptions: [majors] = [.music,.sts,.gov,.scholar,.asian,.soc,.eng,.archae,.infsc,.complit,.ses,.astro,.cs,.phys,.ling,.germstud,.chinpacstud,.hist,.astats,.achem,.french,.anthro,.ital,.amerstud,.psych,.fem,.span,.afristud,.neaststud,.relig,.perfmed,.aecon,.amath,.classic,.philos,.aBS,.histart,.im,.biologsci]
    var calsMajorOptions: [majors] = [.agsci,.atmosci,.anisci,.aem,.bioeng,.biomstat,.comm,.devsoc,.ento,.ess,.enveng,.foodsci,.gphs,.iard,.landarch,.nutrisci,.plantsci,.vines,.infsc,.ses]
    var hotelMajorOptions: [majors] = [.smom,.hold,.fare]
    var dysonMajorOptions: [majors] = [.aem]
    var ilrMajorOptions: [majors] = [.ilr]
    var archiMajorOptions: [majors] = [.archi]
    var allMajors: [majors] = [.ece,.aep,.cheme,.meche,.orie,.bme,.cs,.isst,.mse,.civil,.im,.music,.sts,.gov,.scholar,.asian,.soc,.eng,.archae,.infsc,.complit,.ses,.astro,.cs,.phys,.ling,.germstud,.chinpacstud,.hist,.astats,.achem,.french,.anthro,.ital,.amerstud,.psych,.fem,.span,.afristud,.neaststud,.relig,.perfmed,.aecon,.amath,.classic,.philos,.aBS,.histart,.im,.biologsci,.agsci,.atmosci,.anisci,.aem,.bioeng,.biomstat,.comm,.devsoc,.ento,.ess,.enveng,.foodsci,.gphs,.iard,.landarch,.nutrisci,.plantsci,.vines,.infsc,.ses,.smom,.hold,.fare,.aem,.ilr,.archi]
    
    //Minor data
    let allEngMinors: [minors] = [.nm,.ase, .am, .be, .bme, .bus, .civ, .cs, .ece, .ee, .em, .es, .env, .gd, .isst, .info, .mse, .meche, .orie, .ses, .sust]
    let allCals: [minors] = [.agm, .aiis, .anisci, .appe, .atmosci, .biosc, .biostat, .busi, .cc, .comm, .cfs, .cm, .dscoc, .edu, .ent, .eer ,.ess, .foodsci, .ged, .hort, .hfba, .idb, .infos, .ids, .itd, .lands, .lead, .marb, .nutri, .plb, .scie, .sois, .viti]
    let allAS: [minors] = [.esa, .cogsci, .math, .pma, .js, .ams, .infoa, .music, .hist, .vs, .eng, .clciv, .scies, .mitw, .aas, .sas, .phil, .las, .gs, .arab, .ls, .ast, .rus, .theat, .medi, .vik, .cita, .phys, .ins, .gad, .fren, .hista, .seas, .ling, .pbs, .cpej, .hc, .ital, .nes, .biosci, .csa, .dan, .lat, .rels, .clas, .ixr, .arch, .caps, .psych, .sts, .anthr, .film, .afr, .cw, .lgbt, .span, .fgs]
    var allMinors: [minors] = [.nm,.ase, .am, .be, .bme, .bus, .civ, .cs, .ece, .ee, .em, .es, .env, .gd, .isst, .info, .mse, .meche, .orie, .ses, .sust, .agm, .aiis, .anisci, .appe, .atmosci, .biosc, .biostat, .busi, .cc, .comm, .cfs, .cm, .dscoc, .edu, .ent, .eer ,.ess, .foodsci, .ged, .hort, .hfba, .idb, .infos, .ids, .itd, .lands, .lead, .marb, .nutri, .plb, .scie, .sois, .viti, .esa, .cogsci, .math, .pma, .js, .ams, .infoa, .music, .hist, .vs, .eng, .clciv, .scies, .mitw, .aas, .sas, .phil, .las, .gs, .arab, .ls, .ast, .rus, .theat, .medi, .vik, .cita, .phys, .ins, .gad, .fren, .hista, .seas, .ling, .pbs, .cpej, .hc, .ital, .nes, .biosci, .csa, .dan, .lat, .rels, .clas, .ixr, .arch, .caps, .psych, .sts, .anthr, .film, .afr, .cw, .lgbt, .span, .fgs]
    
    
    //Dictionaries
    var stringCollegeDict = [String:colleges]()
    var stringMajorDict = [String:majors]()
    var stringMinorDict = [String:minors]()
    
    func dictionariesInit() {
        for each in allColleges {
            stringCollegeDict[each.rawValue] = each
        }
        for each in allMajors {
            stringMajorDict[each.rawValue] = each
        }
        for each in allMinors {
            stringMinorDict[each.rawValue] = each
        }
    }
    
    var engineeringRequirements: [Class] = []
    var artsnscienceRequirements: [Class] = []
    var calsRequirements: [Class] = []
    var architectureRequirements: [Class] = []
    var dysonRequirements: [Class] = []
    var hotelRequirements: [Class] = []
    var ilrRequirements: [Class] = []
    
    var collegeRequirements: [colleges: [Class]] = [.engineering:[], .artsnsciences:[], .cals:[], .hotel:[], .dyson:[], .architecture:[], .ilr:[]]
    
    func updateCollegeRequirements(college: colleges, newRequirements: [Class]) {
        collegeRequirements[college] = newRequirements
    }
    
    func getCollegeRequirements(collegeName: String) -> [Class] {
        return collegeRequirements[stringCollegeDict[collegeName]!]!
    }
    
    var majorRequirements = [majors: [Class]]()
    
    func getMajorRequirements(majorName: String) -> [Class] {
        return []
        
    }
    
    
    var ece: [Class] = []
    var aep: [Class] = []
    var cheme: [Class] = []
    var meche: [Class] = []
    var orie: [Class] = []
    var bme: [Class] = []
    var cs: [Class] = []
    var isst: [Class] = []
    var mse: [Class] = []
    var civil: [Class] = []
    var music: [Class] = []
    var sts: [Class] = []
    var gov: [Class] = []
    var scholar: [Class] = []
    var asian: [Class] = []
    var soc: [Class] = []
    var archae: [Class] = []
    var infsc: [Class] = []
    var complit: [Class] = []
    var ses: [Class] = []
    var astro: [Class] = []
    var acompsci: [Class] = []
    var phys: [Class] = []
    var ling: [Class] = []
    var germstud: [Class] = []
    var chinpacstud: [Class] = []
    var hist: [Class] = []
    var astats: [Class] = []
    var achem: [Class] = []
    var french: [Class] = []
    var anthro: [Class] = []
    var ital: [Class] = []
    var amerstud: [Class] = []
    var psych: [Class] = []
    var fem: [Class] = []
    var span: [Class] = []
    var afristud: [Class] = []
    var neaststud: [Class] = []
    var relig: [Class] = []
    var perfmed: [Class] = []
    var aecon: [Class] = []
    var amath: [Class] = []
    var classic: [Class] = []
    var philos: [Class] = []
    var aBS: [Class] = []
    var histart: [Class] = []
    var im: [Class] = []
    var biologsci: [Class] = []
    var agsci: [Class] = []
    var atmosci: [Class] = []
    var anisci: [Class] = []
    var aem: [Class] = []
    var bioeng: [Class] = []
    var biomstat: [Class] = []
    var comm: [Class] = []
    var devsoc: [Class] = []
    var ento: [Class] = []
    var ess: [Class] = []
    var enveng: [Class] = []
    var foodsci: [Class] = []
    var gphs: [Class] = []
    var iard: [Class] = []
    var landarch: [Class] = []
    var nurtisci: [Class] = []
    var plantsci: [Class] = []
    var vines: [Class] = []
    var smom: [Class] = []
    var hold: [Class] = []
    var fare: [Class] = []
    var ilr: [Class] = []
   
}

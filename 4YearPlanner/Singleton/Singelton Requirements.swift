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
    
    func initEverything() {
        minorsInit()
        majorsInit()
        collegesInit()
    }

// MAJORS
    var allMajors = [Major]()
    func majorsInit() {
        engineeringMajorsInit()
        artsScienceMajorsInit()
        calsMajorsInit()
        hotelMajorsInit()
        dysonMajorsInit()
        architectureMajorsInit()
        allMajors.append(contentsOf: engineeringMajors)
        allMajors.append(contentsOf: artsScienceMajors)
        allMajors.append(contentsOf: calsMajors)
        allMajors.append(contentsOf: hotelMajors)
        allMajors.append(contentsOf: dysonMajors)
        allMajors.append(contentsOf: architectureMajors)
        allMajors.append(contentsOf: ilrMajors)
    }
    
    //Engineering
    var engineeringMajors = [Major]()
    func engineeringMajorsInit() {
        engineeringMajors = [ece, aep, cheme, meche, orie, bme, cse, isst, mse ,civile, imEng]
    }
    var ece = Major(title: "ECE", description: "", reqs: [])
    var aep = Major(title: "AEP", description: "", reqs: [])
    var cheme = Major(title: "Chemical Engineering", description: "", reqs: [])
    var meche = Major(title: "Mechanical Engineering", description: "", reqs: [])
    var orie = Major(title: "ORIE", description: "", reqs: [])
    var bme = Major(title: "Biomedical Engineering", description: "", reqs: [])
    var cse = Major(title: "Computer Science (Engineering)", description: "", reqs: [])
    var isst = Major(title: "ISST", description: "", reqs: [])
    var mse = Major(title: "Material Science Engineering", description: "", reqs: [])
    var civile = Major(title: "Civil Engineering", description: "", reqs: [])
    var imEng = Major(title: "Independant Major", description: "", reqs: [])
    
    //Arts & Science
    var artsScienceMajors = [Major]()
    func artsScienceMajorsInit() {
        artsScienceMajors = [music, sts, gov, scholar, asian, soc, engl, archae, infsciArts, complit, sesArts, astro, csArts, phys, ling, germstud, chinpacstud, hist, statsArts, chemArts, french, anthro, ital, amerstud, psych, fem, span, afristud, neaststud, relig, perfmed, econArts, mathArts, classic, philos, bsArts, histart, imArts, biologsci]
    }
    var music = Major(title: "Music", description: "", reqs: [])
    var sts = Major(title: "Science and Technology Studies", description: "", reqs: [])
    var gov = Major(title: "Government", description: "", reqs: [])
    var scholar = Major(title: "College Scholar", description: "", reqs: [])
    var asian = Major(title: "Asian Studies", description: "", reqs: [])
    var soc = Major(title: "Sociology", description: "", reqs: [])
    var engl = Major(title: "English", description: "", reqs: [])
    var archae = Major(title: "Archaeology", description: "", reqs: [])
    var infsciArts = Major(title: "Information Science", description: "", reqs: [])
    var complit = Major(title: "Comparative Literature", description: "", reqs: [])
    var sesArts = Major(title: "Science and Earth Systems", description: "", reqs: [])
    var astro = Major(title: "Astronomy", description: "", reqs: [])
    var csArts = Major(title: "Computer Science", description: "", reqs: [])
    var phys = Major(title: "Physics", description: "", reqs: [])
    var ling = Major(title: "Linguistics", description: "", reqs: [])
    var germstud = Major(title: "German Studies", description: "", reqs: [])
    var chinpacstud = Major(title: "Chinese & Asia-Pacific Studies", description: "", reqs: [])
    var hist = Major(title: "History", description: "", reqs: [])
    var statsArts = Major(title: "Statistics", description: "", reqs: [])
    var chemArts = Major(title: "Chemistry", description: "", reqs: [])
    var french = Major(title: "French", description: "", reqs: [])
    var anthro = Major(title: "Anthropology", description: "", reqs: [])
    var ital = Major(title: "Italian", description: "", reqs: [])
    var amerstud = Major(title: "American Studies", description: "", reqs: [])
    var psych = Major(title: "Physchology", description: "", reqs: [])
    var fem = Major(title: "Feminist, Gender & Sexual Studies", description: "", reqs: [])
    var span = Major(title: "Spanish", description: "", reqs: [])
    var afristud = Major(title: "Africana Studies", description: "", reqs: [])
    var neaststud = Major(title: "Near Eastern Studies", description: "", reqs: [])
    var relig = Major(title: "Religious Studies", description: "", reqs: [])
    var perfmed = Major(title: "Performing & Media Arts", description: "", reqs: [])
    var econArts = Major(title: "Economics", description: "", reqs: [])
    var mathArts = Major(title: "Mathematics", description: "", reqs: [])
    var classic = Major(title: "Classical Studies", description: "", reqs: [])
    var philos = Major(title: "Philosophy", description: "", reqs: [])
    var bsArts = Major(title: "Biology and Society", description: "", reqs: [])
    var histart = Major(title: "History of Art", description: "", reqs: [])
    var imArts = Major(title: "Independent Major", description: "", reqs: [])
    var biologsci = Major(title: "Biological Sciences", description: "", reqs: [])
    
    //CALS
    var calsMajors = [Major]()
    func calsMajorsInit() {
        calsMajors = [agsci, atmosci, anisci, aem, bioeng, biomstat, comm, devsoc, ento, ess, enveng, foodsci, gphs, iard, landarch, nurtisci, plantsci, vines, infsciCals, sesCals]
    }
    var agsci = Major(title: "Agriculutral Science", description: "", reqs: [])
    var atmosci = Major(title: "Atmoshperic Science", description: "", reqs: [])
    var anisci = Major(title: "Animal Science", description: "", reqs: [])
    var aem = Major(title: "Applied Economics and Management", description: "", reqs: [])
    var bioeng = Major(title: "Biological Engineering", description: "", reqs: [])
    var biomstat = Major(title: "Biometry and Statistics", description: "", reqs: [])
    var comm = Major(title: "Communications", description: "", reqs: [])
    var devsoc = Major(title: "Development Sociology", description: "", reqs: [])
    var ento = Major(title: "Entomology", description: "", reqs: [])
    var ess = Major(title: "Environmental and Sustainability Sciences", description: "", reqs: [])
    var enveng = Major(title: "Environmental Engineering", description: "", reqs: [])
    var foodsci = Major(title: "Food Science", description: "", reqs: [])
    var gphs = Major(title: "Global and Public Health Sciences", description: "", reqs: [])
    var iard = Major(title: "International Agriculture and Rural Developments", description: "", reqs: [])
    var landarch = Major(title: "Landscape Architecture", description: "", reqs: [])
    var nurtisci = Major(title: "Nutritional Science", description: "", reqs: [])
    var plantsci = Major(title: "Plant Science", description: "", reqs: [])
    var vines = Major(title: "Vineculture and Enology", description: "", reqs: [])
    var infsciCals = Major(title: "Information Science", description: "", reqs: [])
    var sesCals = Major(title: "Science and Earth Systems", description: "", reqs: [])
    
    //Hotel
    var hotelMajors = [Major]()
    func hotelMajorsInit() {
        hotelMajors = [smom, hold, fare]
    }
    var smom = Major(title: "Services Marketing and Operations Management", description: "", reqs: [])
    var hold = Major(title: "Hospitality Leadership", description: "", reqs: [])
    var fare = Major(title: "Finance, Accounting & Real-Estate", description: "", reqs: [])
    
    //Dyson
    var dysonMajors = [Major]()
    func dysonMajorsInit() {
        dysonMajors = [aem]
    }
    
    //Architecture
    var architectureMajors = [Major]()
    func architectureMajorsInit() {
        architectureMajors = [archi]
    }
    var archi = Major(title: "Architecture, Art & Planning", description: "", reqs: [])
    
    //ILR
    var ilrMajors = [Major]()
    func ilrMajorsInit() {
        ilrMajors = [ilr]
    }
    var ilr = Major(title: "Industrial Labor Relations", description: "", reqs: [])
    
    
//MINORS
    var allMinors = [Minor]()
    func minorsInit() {
        allMinors = [noMinor, aseMin, amMin, beMin, bmeMin, busMin, civMin, csMin, eceMin, eeMin, emMin, esMin, envMin, gdMin, isitMin, infoMin, mseMin, mecheMin, orieMin, sesMin, sustMin, esaMin, cogsciMin, mathMin, pmaMin, jsMin, amerstudMin, infosciMin, musicMin, histMin, vsMin, englMin, clsccivMin, mitwMin, aasMin, sasMin, philosMin, lasMin, germstudMin, arabMin, lsMin, astroMin, rusMin, theatMin, medistudMin, vikstudMin, citaMin, physMin, ineqstudMin, frenchMin, histartMin, seasianstudMin, lingMin, portbrazstudMin, cpejMin, histcapMin, italMin, neaststudMin, biologsciMin, danceMin, latstudMin, religMin, classicMin, interrelMin, archaeMin, chinapacstudMin, psychMin, stsMin, anthroMin, filmMin, afristudMin, cwMin, lgbtMin, spanMin, femMin, agrimanMin, aiistudMin, anisciMin, appeconMin, atmosciMin, biomstatMin, businessMin, ccMin, commMin, cfsMin, cropmanMin, devsocMin, eduMin, entoMin, eerMin, essMin, foodsciMin, gedMin, hortMin, hortfbaMin, idbMin, idsMin, itdMin, landstudMin, leaderMin, marbioMin, nutriMin, plantbreMin, soilMin, vitiMin, reMin]
    }
    // engineering related
    var noMinor = Minor(title: "No Minor", description: "", reqs: [])
    var aseMin = Minor(title: "Aerospace Engineering", description: "", reqs: [])
    var amMin = Minor(title: "Applied Mathematics", description: "", reqs: [])
    var beMin = Minor(title: "Biological Engineering", description: "", reqs: [])
    var bmeMin = Minor(title: "Biomedical Engineering", description: "", reqs: [])
    var busMin = Minor(title: "Business for Engineering Students", description: "", reqs: [])
    var civMin = Minor(title: "Civil Engineering", description: "", reqs: [])
    var csMin = Minor(title: "Computer Science", description: "", reqs: [])
    var eceMin = Minor(title: "Electrical and Computer Engineering", description: "", reqs: [])
    var eeMin = Minor(title: "Engineering Entreprenuership", description: "", reqs: [])
    var emMin = Minor(title: "Engineering Management", description: "", reqs: [])
    var esMin = Minor(title: "Engineering Statistics", description: "", reqs: [])
    var envMin = Minor(title: "Environmental Engineering", description: "", reqs: [])
    var gdMin = Minor(title: "Game Design", description: "", reqs: [])
    var isitMin = Minor(title: "Industrial System and Information Technology", description: "", reqs: [])
    var infoMin = Minor(title: "Information Science", description: "", reqs: [])
    var mseMin = Minor(title: "Materials Science Engineering", description: "", reqs: [])
    var mecheMin = Minor(title: "Mechanical Engineering", description: "", reqs: [])
    var orieMin = Minor(title: "Operations Research and Information Engineering", description: "", reqs: [])
    var sesMin = Minor(title: "Science of Earth Systems", description: "", reqs: [])
    var sustMin = Minor(title: "Sustainabilite Energy Systems", description: "", reqs: [])
    // arts related
    var esaMin = Minor(title: "Eastern Asian Studies", description: "", reqs: [])
    var cogsciMin = Minor(title: "Cognitive Science", description: "", reqs: [])
    var mathMin = Minor(title: "Mathematics", description: "", reqs: [])
    var pmaMin = Minor(title: "Performing & Media Arts", description: "", reqs: [])
    var jsMin = Minor(title: "Jewish Studies", description: "", reqs: [])
    var amerstudMin = Minor(title: "American Studies", description: "", reqs: [])
    var infosciMin = Minor(title: "Information Science", description: "", reqs: [])
    var musicMin = Minor(title: "Music", description: "", reqs: [])
    var histMin = Minor(title: "History", description: "", reqs: [])
    var vsMin = Minor(title: "Visual Studies", description: "", reqs: [])
    var englMin = Minor(title: "English", description: "", reqs: [])
    var clsccivMin = Minor(title: "Classical Civilization", description: "", reqs: [])
    var mitwMin = Minor(title: "Minority, Indigenous & Third World Studies", description: "", reqs: [])
    var aasMin = Minor(title: "Asian American Studies", description: "", reqs: [])
    var sasMin = Minor(title: "South Asian Studies", description: "", reqs: [])
    var philosMin = Minor(title: "Philosophy", description: "", reqs: [])
    var lasMin = Minor(title: "Latin American Studies", description: "", reqs: [])
    var germstudMin = Minor(title: "German Studies", description: "", reqs: [])
    var arabMin = Minor(title: "Arabic", description: "", reqs: [])
    var lsMin = Minor(title: "Law and Society", description: "", reqs: [])
    var astroMin = Minor(title: "Astronomy", description: "", reqs: [])
    var rusMin = Minor(title: "Russian", description: "", reqs: [])
    var theatMin = Minor(title: "Theatre", description: "", reqs: [])
    var medistudMin = Minor(title: "Medival Studies", description: "", reqs: [])
    var vikstudMin = Minor(title: "Viking Studies", description: "", reqs: [])
    var citaMin = Minor(title: "Computing in the Arts", description: "", reqs: [])
    var physMin = Minor(title: "Physics", description: "", reqs: [])
    var ineqstudMin = Minor(title: "inequality Studies", description: "", reqs: [])
    var frenchMin = Minor(title: "French", description: "", reqs: [])
    var histartMin = Minor(title: "History of Art", description: "", reqs: [])
    var seasianstudMin = Minor(title: "Southeast Asian Studies", description: "", reqs: [])
    var lingMin = Minor(title: "Linguistics", description: "", reqs: [])
    var portbrazstudMin = Minor(title: "Portuguese & Brazilian Studies", description: "", reqs: [])
    var cpejMin = Minor(title: "Crime, Prisons, Education & Justice", description: "", reqs: [])
    var histcapMin = Minor(title: "History of Capitalism", description: "", reqs: [])
    var italMin = Minor(title: "Italian", description: "", reqs: [])
    var neaststudMin = Minor(title: "Near Eastern Studies", description: "", reqs: [])
    var biologsciMin = Minor(title: "Biological Sciences", description: "", reqs: [])
    var danceMin = Minor(title: "Dance", description: "", reqs: [])
    var latstudMin = Minor(title: "Latina/o Studies", description: "", reqs: [])
    var religMin = Minor(title: "Religious Studies", description: "", reqs: [])
    var classicMin = Minor(title: "Classics", description: "", reqs: [])
    var interrelMin = Minor(title: "International Relations", description: "", reqs: [])
    var archaeMin = Minor(title: "Arhcaeology", description: "", reqs: [])
    var chinapacstudMin = Minor(title: "China & Asia-Pacific Studies", description: "", reqs: [])
    var psychMin = Minor(title: "Psychology", description: "", reqs: [])
    var stsMin = Minor(title: "Science & Technology Studies", description: "", reqs: [])
    var anthroMin = Minor(title: "Anthropology", description: "", reqs: [])
    var filmMin = Minor(title: "Film", description: "", reqs: [])
    var afristudMin = Minor(title: "African Studies", description: "", reqs: [])
    var cwMin = Minor(title: "Creative Writing", description: "", reqs: [])
    var lgbtMin = Minor(title: "LGBT Studies", description: "", reqs: [])
    var spanMin = Minor(title: "Spanish", description: "", reqs: [])
    var femMin = Minor(title: "Feminist, Gender & Sexual Studies", description: "", reqs: [])
    //cals related
    var agrimanMin = Minor(title: "Agricultural Management", description: "", reqs: [])
    var aiistudMin = Minor(title: "American Indian and Indigenous Studies", description: "", reqs: [])
    var anisciMin = Minor(title: "Animal Science", description: "", reqs: [])
    var appeconMin = Minor(title: "Applied Economics", description: "", reqs: [])
    var atmosciMin = Minor(title: "Atmospheric Science", description: "", reqs: [])
    var biomstatMin = Minor(title: "Biometry and Statistics", description: "", reqs: [])
    var businessMin = Minor(title: "Business", description: "", reqs: [])
    var ccMin = Minor(title: "Climate Change", description: "", reqs: [])
    var commMin = Minor(title: "Communications", description: "", reqs: [])
    var cfsMin = Minor(title: "Community Food Systems", description: "", reqs: [])
    var cropmanMin = Minor(title: "Crop Management", description: "", reqs: [])
    var devsocMin = Minor(title: "Development Sociology", description: "", reqs: [])
    var eduMin = Minor(title: "Education", description: "", reqs: [])
    var entoMin = Minor(title: "Entomology", description: "", reqs: [])
    var eerMin = Minor(title: "Environmental, Energy & Resource Economics", description: "", reqs: [])
    var essMin = Minor(title: "Environmental & Sustainability Science", description: "", reqs: [])
    var foodsciMin = Minor(title: "Food Science", description: "", reqs: [])
    var gedMin = Minor(title: "Globalization, Ethnicity & Development", description: "", reqs: [])
    var hortMin = Minor(title: "Horticulture", description: "", reqs: [])
    var hortfbaMin = Minor(title: "Horticulture with a Focus in the Botanical Arts", description: "", reqs: [])
    var idbMin = Minor(title: "Infectious Disease Biology", description: "", reqs: [])
    var idsMin = Minor(title: "Internatinoal Development Studies", description: "", reqs: [])
    var itdMin = Minor(title: "Internaitonal Trade & Development", description: "", reqs: [])
    var landstudMin = Minor(title: "Landscape Studies", description: "", reqs: [])
    var leaderMin = Minor(title: "Leadership", description: "", reqs: [])
    var marbioMin = Minor(title: "Marine Biology", description: "", reqs: [])
    var nutriMin = Minor(title: "Nutrition & Health", description: "", reqs: [])
    var plantbreMin = Minor(title: "Plant Breeding", description: "", reqs: [])
    var soilMin = Minor(title: "Soil Systems", description: "", reqs: [])
    var vitiMin = Minor(title: "Viticulture & Enology", description: "", reqs: [])
    //hotel related
    var reMin = Minor(title: "Real Estate", description: "", reqs: [])
    
    
//COLLEGES
    var allColleges = [College]()
    func collegesInit() {
        Engineering.majorOptions = engineeringMajors
        ArtsScience.majorOptions = artsScienceMajors
        CALS.majorOptions = calsMajors
        Hotel.majorOptions = hotelMajors
        Dyson.majorOptions = dysonMajors
        Architecture.majorOptions = architectureMajors
        ILR.majorOptions = ilrMajors
        allColleges = [Engineering, ArtsScience, CALS, Hotel, Dyson, Architecture, ILR]
    }
    var Engineering = College(title: "Engineering", description: "these guys build lit shit", majorOptions: [], reqs: [])
    var ArtsScience = College(title: "Arts & Science", description: "lame", majorOptions: [], reqs: [])
    var CALS = College(title: "CALS", description: "for people who dont like requirements", majorOptions: [], reqs: [])
    var Hotel = College(title: "Hotel", description: "for people who party ONLY", majorOptions: [], reqs: [])
    var Dyson = College(title: "Dyson", description: "for snakes", majorOptions: [], reqs: [])
    var Architecture = College(title: "Architecture", description: "do cool stuff, but don't go outside much", majorOptions: [], reqs: [])
    var ILR = College(title: "ILR", description: "fake lawyers", majorOptions: [], reqs: [])
    

    /*
    //Dictionaries
    var stringCollegeDict = [String:colleges]()
    var stringMajorDict = [String:majors]()
    var stringMinorDict = [String:minors]()
    
    func dictionariesInit() {
        for each in allColleges {
            stringCollegeDict[each.rawValue] = each
        }
        for each in allMajors {
            //stringMajorDict[each.rawValue] = each
        }
        for each in allMinors {
            stringMinorDict[each.rawValue] = each
        }
    }
 
    var engineeringRequirements: [Requirement] = []
    var artsnscienceRequirements: [Requirement] = []
    var calsRequirements: [Requirement] = []
    var architectureRequirements: [Requirement] = []
    var dysonRequirements: [Requirement] = []
    var hotelRequirements: [Requirement] = []
    var ilrRequirements: [Requirement] = []
    
    var collegeRequirements: [colleges: [Class]] = [.engineering:[], .artsnsciences:[], .cals:[], .hotel:[], .dyson:[], .architecture:[], .ilr:[]]
    
    // Changes requirements for College
    func updateCollegeRequirements(college: colleges, newRequirements: [Class]) {
        collegeRequirements[college] = newRequirements
    }
    
    // Grabs College's requirements
    func getCollegeRequirements(collegeName: String) -> [Class] {
        return collegeRequirements[stringCollegeDict[collegeName]!]!
    }
    
    var majorRequirements = [majors: [Class]]()
    
    // Grabs Major's requirements
    func getMajorRequirements(majorName: String) -> [Class] {
        return []
        
    }
 
 */
 
 
 
   
}

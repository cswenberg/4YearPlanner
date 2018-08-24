//
//  Singleton Aesthetics.swift
//  4YearPlanner
//
//  Created by Conner Swenberg on 6/11/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import Foundation
import UIKit

var aesthetics = globalAesthetics()

class globalAesthetics {
    
    //gradients
    let cellGradientList = [[0.0, 0.0, 0.0, 1.0]]
    var gradientRandomizer = 0
    var tabGradient = [UIColor(red: 9/255, green: 154/255, blue: 255/255, alpha: 1).cgColor, UIColor(red: 202/255, green: 227/255, blue: 255/255, alpha: 1).cgColor]
    var gradientList = [[UIColor(red: 241/255, green: 178/255, blue: 122/255, alpha: 1).cgColor, UIColor(red: 219/255, green: 86/255, blue: 147/255, alpha: 1).cgColor],
                        [UIColor(red: 139/255, green: 112/217, blue: 217/255, alpha: 1).cgColor, UIColor(red: 214/255, green: 147/255, blue: 225/255, alpha: 1).cgColor],
                        [UIColor(red: 71/255, green: 166/255, blue: 252/255, alpha: 1).cgColor, UIColor(red: 54/255, green: 229/255, blue: 211/255, alpha: 1).cgColor],
                        [UIColor(red: 94/255, green: 210/255, blue: 133/255, alpha: 1).cgColor , UIColor(red: 69/255, green: 225/255, blue: 197/255, alpha: 1).cgColor]]
    
    //fonts
    let tabsFont = UIFont.systemFont(ofSize: 20)
    let backButtonFont = UIFont.systemFont(ofSize: 42)
    let smallFont = UIFont.systemFont(ofSize: 16)
    let middieFont = UIFont.systemFont(ofSize: 20)
    let mediumFont = UIFont.systemFont(ofSize: 24)
    
    //sizing
    let creditWidth = 26
    let topOffset = 40
    let smallGap = 10
    let mediumGap = 20
    let tabsGap = 30
    
    //colors
    var termColor = UIColor(red: 120/255, green: 154/255, blue: 241/255, alpha: 1)
    var searchBarGray = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
    var orange = UIColor(red: 241, green: 178, blue: 122, alpha: 1)
    var nextorange = UIColor(red: 219, green: 86, blue: 147, alpha: 1)
    var iceBlue = UIColor(red: 204, green: 255, blue: 255, alpha: 1)
    var redOrange = UIColor(red: 255, green: 80, blue: 80, alpha: 1)
    var lightOrange = UIColor(red: 255, green: 531, blue: 51, alpha: 1)
    var lightPurp = UIColor(red: 203, green: 153, blue: 255, alpha: 1)
    var deepPurp = UIColor(red: 102, green: 0, blue: 204, alpha: 1)
    var cyan = UIColor(red: 102, green: 255, blue: 255, alpha: 1)
    var cerulean = UIColor(red: 0, green: 204, blue: 153, alpha: 1)
    var limeGreen = UIColor(red: 153, green: 255, blue: 102, alpha: 1)
    var lightPink = UIColor(red: 255, green: 204, blue: 255, alpha: 1)
    var regularPink = UIColor(red: 255, green: 102, blue: 204, alpha: 1)
    let niceOrange = UIColor(red: 1, green: 0.73, blue: 0.19, alpha: 1)
    let niceGreen = UIColor(red: 0.25, green: 0.85, blue: 0.51, alpha: 1)
    let middleGray = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    let darkGray = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)

    //themes
    let themeList = ["Normal", "Dark"] //for our use to keep track
    var selectedTheme = "Dark"
    var cellTextColor: UIColor!
    var textColor: UIColor!
    var backgroundColor: UIColor!
    
    var selectedTheme2 = darkTheme
    var themes = [lightTheme, darkTheme]
    
    // Change the color values to later affect the rest of the app
    func updateTheme() {
        cellTextColor = selectedTheme2.cellTextColor
        textColor = selectedTheme2.textColor
        backgroundColor = selectedTheme2.backgroundColor
    }
    
    // Helper for switching colors
    func opposite(color: UIColor) -> UIColor{
        if color == darkGray {
            return .white
        } else if color == .white {
            return darkGray
        }
        return .white
    }
}

class Theme: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(cellTextColor, forKey: "cellTextColor")
        aCoder.encode(textColor, forKey: "textColor")
        aCoder.encode(backgroundColor, forKey: "backgroundColor")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.cellTextColor = aDecoder.decodeObject(forKey: "cellTextColor") as! UIColor
        self.textColor = aDecoder.decodeObject(forKey: "textColor") as! UIColor
        self.backgroundColor = aDecoder.decodeObject(forKey: "backgroundColor") as! UIColor
    }
    
    var name: String!
    var cellTextColor: UIColor!
    var textColor: UIColor!
    var backgroundColor: UIColor!
    
    init(name: String, cellText: UIColor, text: UIColor, background: UIColor) {
        self.name = name
        cellTextColor = cellText
        textColor = text
        backgroundColor = background
    }
}

let lightTheme = Theme(name: "Light", cellText: .white, text: .black, background: .white)
let darkTheme = Theme(name: "Dark", cellText: .white, text: .white, background: .black)


//
//  SettingsViewController.swift
//  4YearPlanner
//
//  Created by Conner Swenberg on 6/4/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//
// another commit diff file tho

import UIKit

protocol settingsDelegate {
    func themeUpdated()
}

class SettingsViewController: UIViewController {
    
    var delegate: settingsDelegate?
    var myInfoLabel: UILabel!
    var collegeLabel: UILabel!
    var majorLabel: UILabel!
    var minorLabel: UILabel!
    var resetButton: UIButton!
    var cloutLabel: UILabel!
    var themeLabel: UILabel!
    var themeOption1: UIButton!
    var themeOption2: UIButton!
    var clearSchedulesButton: UIButton!
    var majorAddButton: UIButton!
    var minorAddButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = aesthetics.backgroundColor
        
        //myInfoLabel
        myInfoLabel = UILabel()
        myInfoLabel.text = "My Info"
        myInfoLabel.font = .systemFont(ofSize: 36)
        myInfoLabel.textColor = aesthetics.textColor
        
        //collegeLabel
        collegeLabel = UILabel()
        collegeLabel.text = "College:  None Selected"
        if let collegeText = userData.myCollege?.getTitle() {
            collegeLabel.text = "College:  \(collegeText)"
        }
        collegeLabel.textColor = aesthetics.textColor
        
        //majorLabel
        majorLabel = UILabel()
        majorLabel.text = "Major:     None Selected"
        if let majorText = userData.myMajor?.getTitle() {
            majorLabel.text = "Major:     \(majorText)"
        }
        majorLabel.textColor = aesthetics.textColor
        
        //minorLabel
        minorLabel = UILabel()
        minorLabel.text = "Minor:     None Selected"
        if let minorText = userData.myMinor?.getTitle() {
            minorLabel.text = "Minor:     \(minorText)"
        }
        minorLabel.textColor = aesthetics.textColor
        
        //resetButton
        resetButton = UIButton()
        resetButton.setTitle("RESET", for: .normal)
        resetButton.setTitleColor(.red, for: .normal)
        resetButton.titleLabel?.font = aesthetics.smallFont
        resetButton.titleLabel?.textAlignment = .center
        resetButton.backgroundColor = aesthetics.backgroundColor
        resetButton.layer.borderWidth = 1
        resetButton.layer.borderColor = UIColor.red.cgColor
        resetButton.layer.cornerRadius = 16
        resetButton.clipsToBounds = true
        resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        
        //Wipe Semester Info Button
        clearSchedulesButton = UIButton()
        clearSchedulesButton.setTitle("Clear my Schedule", for: .normal)
        clearSchedulesButton.titleLabel?.font = aesthetics.mediumFont
        clearSchedulesButton.titleLabel?.textColor = aesthetics.cellTextColor
        clearSchedulesButton.backgroundColor = .red
        clearSchedulesButton.layer.cornerRadius = 16
        clearSchedulesButton.clipsToBounds = true
        clearSchedulesButton.titleLabel?.textAlignment = .center
        clearSchedulesButton.addTarget(self, action: #selector(clearButtonPressed), for: .touchUpInside)
        
        //cloutLabel
        cloutLabel = UILabel()
        cloutLabel.text = "Created by Omar Rasheed and Conner Swenberg, Designed by Eric Kim"
        cloutLabel.textColor = .lightGray
        cloutLabel.font = .systemFont(ofSize: 8)
        
        //themeLabel
        themeLabel = UILabel()
        themeLabel.text = "Theme: "
        themeLabel.textColor = aesthetics.textColor
        
        //themeOption1
        themeOption1 = UIButton()
        themeOption1.layer.cornerRadius = 10
        themeOption1.setTitle(aesthetics.themeList[0], for: .normal)
        themeOption1.titleLabel?.font = aesthetics.smallFont
        themeOption1.setTitleColor(aesthetics.textColor, for: .normal)
        themeOption1.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        //themeOption2
        themeOption2 = UIButton()
        themeOption2.layer.cornerRadius = 10
        themeOption2.setTitle(aesthetics.themeList[1], for: .normal)
        themeOption2.titleLabel?.font = aesthetics.smallFont
        themeOption2.setTitleColor(aesthetics.textColor, for: .normal)
        themeOption2.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        //MajorAddButton
        majorAddButton = UIButton()
        majorAddButton.layer.cornerRadius = majorAddButton.intrinsicContentSize.height/2
        majorAddButton.setTitle("+", for: .normal)
        majorAddButton.titleLabel?.font = aesthetics.smallFont
        majorAddButton.setTitleColor(aesthetics.textColor, for: .normal)
        majorAddButton.addTarget(self, action: #selector(majorAddButtonPressed), for: .touchUpInside)
        majorAddButton.layer.borderWidth = 1
        majorAddButton.layer.borderColor = aesthetics.tabGradient[0]
        
        //MinorAddButton
        minorAddButton = UIButton()
        minorAddButton.layer.cornerRadius = majorAddButton.intrinsicContentSize.height/2
        minorAddButton.setTitle("+", for: .normal)
        minorAddButton.titleLabel?.font = aesthetics.smallFont
        minorAddButton.setTitleColor(aesthetics.textColor, for: .normal)
        minorAddButton.addTarget(self, action: #selector(minorAddButtonPressed), for: .touchUpInside)
        minorAddButton.layer.borderWidth = 1
        minorAddButton.layer.borderColor = aesthetics.tabGradient[0]
        
        view.addSubview(myInfoLabel)
        view.addSubview(collegeLabel)
        view.addSubview(majorLabel)
        view.addSubview(minorLabel)
        view.addSubview(resetButton)
        view.addSubview(cloutLabel)
        view.addSubview(themeLabel)
        view.addSubview(themeOption1)
        view.addSubview(themeOption2)
        view.addSubview(clearSchedulesButton)
        view.addSubview(majorAddButton)
        view.addSubview(minorAddButton)
        
        themeHighlight()
        setUpConstraints()
        setupButtons()
    }

    func setUpConstraints() {
        //my info label
        myInfoLabel.snp.makeConstraints{ (make) in
            make.leading.equalToSuperview().offset(aesthetics.smallGap)
            make.top.equalToSuperview().offset(aesthetics.mediumGap)
            make.width.equalTo(myInfoLabel.intrinsicContentSize.width)
        }
        //college label
        collegeLabel.snp.makeConstraints{ (make) in
            make.leading.equalTo(myInfoLabel.snp.leading)
            make.top.equalTo(myInfoLabel.snp.bottom).offset(aesthetics.mediumGap)
            make.trailing.equalToSuperview()
        }
        //major label
        majorLabel.snp.makeConstraints{ (make) in
            make.leading.equalTo(myInfoLabel.snp.leading)
            make.top.equalTo(collegeLabel.snp.bottom).offset(aesthetics.mediumGap)
            checkLabelSizes(label: majorLabel)
        }
        //minor label
        minorLabel.snp.makeConstraints{ (make) in
            make.leading.equalTo(myInfoLabel.snp.leading)
            make.top.equalTo(majorLabel.snp.bottom).offset(aesthetics.mediumGap)
            checkLabelSizes(label: minorLabel)
        }
        //clout label
        cloutLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-aesthetics.mediumGap)
            make.centerX.equalToSuperview()
            make.height.equalTo(cloutLabel.intrinsicContentSize.height)
        }
        //reset button
        resetButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(myInfoLabel.snp.centerY)
            make.width.equalTo(resetButton.intrinsicContentSize.width+20)
            make.height.equalTo(resetButton.intrinsicContentSize.height)
            make.trailing.equalToSuperview().offset(-aesthetics.mediumGap)
        }
        //clear My Schedule button
        clearSchedulesButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(cloutLabel.snp.top).offset(-aesthetics.smallGap)
            make.width.equalTo(clearSchedulesButton.intrinsicContentSize.width+20)
            make.height.equalTo(clearSchedulesButton.intrinsicContentSize.height)
            make.centerX.equalToSuperview()
        }
        //theme label
        themeLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(aesthetics.smallGap)
            make.top.equalTo(minorLabel.snp.bottom).offset(aesthetics.mediumGap)
            make.width.equalTo(themeLabel.intrinsicContentSize.width)
            make.height.equalTo(themeLabel.intrinsicContentSize.height)
        }
        //theme option 1 button
        themeOption1.snp.makeConstraints { (make) in
            make.leading.equalTo(themeLabel.snp.trailing).offset(aesthetics.mediumGap)
            make.centerY.equalTo(themeLabel.snp.centerY)
            make.width.equalTo(themeOption1.intrinsicContentSize.width+20)
            make.height.equalTo(themeOption1.intrinsicContentSize.height)
        }
        //theme option 2 button
        themeOption2.snp.makeConstraints { (make) in
            make.leading.equalTo(themeOption1.snp.trailing).offset(40)
            make.centerY.equalTo(themeLabel.snp.centerY)
            make.width.equalTo(themeOption2.intrinsicContentSize.width+20)
            make.height.equalTo(themeOption2.intrinsicContentSize.height)
        }
    }
    
    func setupButtons() {
        //MajorAddButton
        majorAddButton.snp.makeConstraints { (make) in
            make.leading.equalTo(majorLabel.snp.trailing).offset(aesthetics.smallGap)
            make.centerY.equalTo(majorLabel.snp.centerY)
            make.width.equalTo(majorAddButton.intrinsicContentSize.width)
        }
        //MinorAddButton
        minorAddButton.snp.makeConstraints { (make) in
            make.leading.equalTo(minorLabel.snp.trailing).offset(aesthetics.smallGap)
            make.centerY.equalTo(minorLabel.snp.centerY)
            make.width.equalTo(minorAddButton.intrinsicContentSize.width)
        }
    }
    
    // Resets user's academic information
    @objc func resetButtonPressed() {
        majorAddButton.removeFromSuperview()
        minorAddButton.removeFromSuperview()
        setUpConstraints()
        collegeLabel.text = "College:  None Selected"
        majorLabel.text = "Major:     None Selected"
        minorLabel.text = "Minor:     None Selected"
        userData.resetUserInfo()
        sharedVars.setCategory()
//        view.addSubview(majorAddButton)
//        view.addSubview(minorAddButton)
    }
    
    // Wipes all classes from all Semesters
    @objc func clearButtonPressed() {
        // clear semester info
        userData.resetSemesters()
    }
    
    // Change classes based on filter
    @objc func buttonPressed (sender:UIButton) {
        aesthetics.selectedTheme = (sender.titleLabel?.text)!
        aesthetics.updateTheme()
        viewDidLoad()
        delegate?.themeUpdated()
        themeHighlight()
        userData.setTheme()
    }
    
    // Add another major
    @objc func majorAddButtonPressed() {
        print("add a major")
    }
    
    // Add another minor
    @objc func minorAddButtonPressed() {
        print("add a minor")
    }
    
    // Helper for adding buttons formatting
    func checkLabelSizes(label: UILabel) {
        if label.intrinsicContentSize.width > 330 {
            label.snp.makeConstraints { (make) in
                make.width.equalTo(330)
            }
        } else {
            label.snp.makeConstraints { (make) in
                make.width.equalTo(label.intrinsicContentSize.width + 10)
            }
        }
    }
    
    // Changes Theme buttons' backgrounds
    func themeHighlight() {
        if aesthetics.selectedTheme == themeOption1.titleLabel?.text {
            themeOption1.backgroundColor = aesthetics.middleGray
            themeOption1.setTitleColor(aesthetics.cellTextColor, for: .normal)
            themeOption2.backgroundColor = aesthetics.backgroundColor
        } else if aesthetics.selectedTheme == themeOption2.titleLabel?.text {
            themeOption2.backgroundColor = aesthetics.middleGray
            themeOption2.setTitleColor(aesthetics.cellTextColor, for: .normal)
            themeOption1.backgroundColor = aesthetics.backgroundColor
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

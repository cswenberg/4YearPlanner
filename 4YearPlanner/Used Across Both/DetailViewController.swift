//
//  DetailViewController.swift
//  4YearPlanner
//
//  Created by Omar Rasheed on 4/28/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit
import SnapKit

protocol detailViewDelegate {
    func reloadMyClasses()
    func reloadCredits()
}

class DetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    var delegate: detailViewDelegate?
    var loadedFrom: String!
    
    var tempCredits: Int!
    var creditsPickerView: UIPickerView!
    var detailedClass: Class!
    var courseLabel: UILabel!
    var courseTitle: UILabel!
    var descriptionLabel: UILabel!
    var descriptionTextView: UITextView!
    var prereqLabel: UILabel!
    var prereqCollectionView: UICollectionView!
    var prereqTextView: UITextView!
    var creditsLabel: UITextField!
    var backButton: UIButton!
    var saveButton: UIButton!
    var deleteButton: UIButton!
    var semesterStepper: UIStepper!
    var semesterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = aesthetics.backgroundColor
        
        tempCredits = detailedClass.creditsChosen
        
        if detailedClass.pulledPrereqs != "None" {
            detailedClass.slicePulledPrereqs()
        }
        
        creditsPickerView = UIPickerView()
        creditsPickerView.delegate = self
        
        courseTitle = UILabel()
        courseTitle.text = detailedClass.title
        courseTitle.font = .systemFont(ofSize: 28)
        courseTitle.textColor = aesthetics.textColor
        courseTitle.numberOfLines = 0
        courseTitle.textAlignment = .left
        view.addSubview(courseTitle)
        
        courseLabel = UILabel()
        courseLabel.font = .boldSystemFont(ofSize: 28)
        courseLabel.text = detailedClass.classLabel()
        courseLabel.textColor = aesthetics.textColor
        view.addSubview(courseLabel)
        
        descriptionLabel = UILabel()
        descriptionLabel.text = "Description"
        descriptionLabel.font = .boldSystemFont(ofSize: 20)
        descriptionLabel.textColor = aesthetics.textColor
        view.addSubview(descriptionLabel)
        
        descriptionTextView = UITextView()
        descriptionTextView.font = .systemFont(ofSize: 14)
        descriptionTextView.textColor = aesthetics.textColor
        descriptionTextView.backgroundColor = aesthetics.backgroundColor
        descriptionTextView.text = detailedClass.descriptionn
        descriptionTextView.textAlignment = .left
        descriptionTextView.isEditable = false
        view.addSubview(descriptionTextView)
        
        prereqLabel = UILabel()
        prereqLabel.text = "Pre-Requisites"
        prereqLabel.font = .systemFont(ofSize: 20)
        prereqLabel.textColor = aesthetics.textColor
        view.addSubview(prereqLabel)
        
        prereqTextView = UITextView()
        prereqTextView.font = .systemFont(ofSize: 16)
        prereqTextView.textColor = aesthetics.textColor
        prereqTextView.backgroundColor = aesthetics.backgroundColor
        prereqTextView.text = detailedClass.pulledPrereqs!
        prereqTextView.textAlignment = .center
        prereqTextView.isEditable = false
        view.addSubview(prereqTextView)
        
        creditsLabel = UITextField()
        creditsLabel.delegate = self
        creditsLabel.font = .systemFont(ofSize: 24)
        creditsLabel.backgroundColor = aesthetics.niceOrange
        creditsLabel.textColor = aesthetics.cellTextColor
        creditsLabel.text = String(detailedClass.creditsChosen)
        creditsLabel.textAlignment = .center
        creditsLabel.layer.cornerRadius = 10
        creditsLabel.clipsToBounds = true
        creditsLabel.inputView = creditsPickerView
        creditsLabel.tintColor = .clear
        view.addSubview(creditsLabel)
        
        backButton = UIButton()
        backButton.setTitle("<", for: .normal)
        backButton.setTitleColor(aesthetics.textColor, for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 48)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        view.addSubview(backButton)
        
        saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 32)
        saveButton.setTitleColor(aesthetics.cellTextColor, for: .normal)
        saveButton.backgroundColor = aesthetics.niceGreen
        saveButton.layer.cornerRadius = 16
        saveButton.clipsToBounds = true
        saveButton.titleLabel?.textAlignment = .center
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        
        deleteButton = UIButton()
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.titleLabel?.font = .systemFont(ofSize: 32)
        deleteButton.setTitleColor(aesthetics.cellTextColor, for: .normal)
        deleteButton.backgroundColor = .red
        deleteButton.layer.cornerRadius = 16
        deleteButton.clipsToBounds = true
        deleteButton.titleLabel?.textAlignment = .center
        deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        
        semesterStepper = UIStepper()
        semesterStepper.maximumValue = 8
        semesterStepper.minimumValue = 1
        semesterStepper.stepValue = 1
        semesterStepper.value = 1
        semesterStepper.addTarget(self, action: #selector(stepperHit), for: .valueChanged)
        
        semesterLabel = UILabel()
        semesterLabel.text = "Semester \(sharedVars.selected_semester)"
        semesterLabel.textColor = aesthetics.textColor
        semesterLabel.font = .systemFont(ofSize: 24)
        semesterLabel.textAlignment = .center
        
        
        // Only show save button if not called from My Schedule
        if loadedFrom != "My Schedule" {
            showSaveButton()
            view.addSubview(semesterStepper)
            semesterStepper.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(saveButton.snp.top).offset(-60)
            }
            view.addSubview(semesterLabel)
            semesterLabel.snp.makeConstraints { (make) in
                make.width.equalTo(semesterLabel.intrinsicContentSize.width + 20)
                make.bottom.equalTo(semesterStepper.snp.top).offset(-20)
                make.centerX.equalToSuperview()
                
            }
        }
        else {
            view.addSubview(deleteButton)
            deleteButton.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview().offset(-40)
                make.centerX.equalToSuperview()
                make.width.equalTo(saveButton.intrinsicContentSize.width + 60)
                make.height.equalTo(saveButton.intrinsicContentSize.height)
            }
        }
        
        setupConstraints()
    }
    
    func setupConstraints() {
        // back button
        backButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.width.equalTo(backButton.intrinsicContentSize.width)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(backButton.intrinsicContentSize.height)
        }
        //course label
        courseLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(backButton.snp.centerY)
            make.centerX.equalToSuperview()
            //   make.width.equalTo(courseLabel.intrinsicContentSize.width)
            make.height.equalTo(courseLabel.intrinsicContentSize.height)
        }
        //course title
        courseTitle.snp.makeConstraints{ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(courseLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            adjustHeight(label: courseTitle)
        }
        // description label
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(courseTitle.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(descriptionLabel.intrinsicContentSize.height)
        }
        // description text view
        descriptionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(250)
        }
        // prereq label
        prereqLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(prereqLabel.intrinsicContentSize.height)
        }
        // prereq text view
        prereqTextView.snp.makeConstraints { (make) in
            make.top.equalTo(prereqLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-20)
            if loadedFrom != "My Schedule" {
                make.bottom.equalTo(semesterLabel.snp.top).offset(-10)
            }
            else {
                make.bottom.equalTo(deleteButton.snp.top).offset(-10)
            }
        }
        // credits label
        creditsLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(backButton.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(creditsLabel.intrinsicContentSize.width + 12)
            make.height.equalTo(creditsLabel.intrinsicContentSize.height)
        }
        print(courseTitle.frame.width)
    }
    
    // Returns from modal VC and changes value of stored variable
    @objc func saveButtonPressed(sender: UIButton) {
        if loadedFrom != "My Schedule" {
            saveClass()
            delegate?.reloadMyClasses()
        }
        if tempCredits != detailedClass.creditsChosen {
            updateCredits()
        }
        dismiss(animated: true, completion: nil)
    }
    
    // Returns from modal VC and removes course from schedule
    @objc func deleteButtonPressed(sender: UIButton) {
        deleteClass()
        delegate?.reloadMyClasses()
        dismiss(animated: true, completion: nil)
    }
    
    // ONLY returns from modal VC
    @objc func backButtonPressed(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateCredits() {
        userData.mySemesters[detailedClass.semesterTaken!-1].alterCourseCredits(someclass: detailedClass, new: tempCredits)
        delegate?.reloadCredits()
        delegate?.reloadMyClasses()
    }
    
    // Adds class to schedule
    func saveClass() {
        userData.mySemesters[sharedVars.selected_semester-1].addClass(newclass: detailedClass)
        userData.saveSemesters()
        delegate?.reloadCredits()
        delegate?.reloadMyClasses()
        analyzePreReqs()
    }
    
    // Deletes class from schedule
    func deleteClass() {
        userData.mySemesters[sharedVars.selected_semester-1].removeClass(someclass: detailedClass)
        userData.saveSemesters()
        delegate?.reloadCredits()
    }
    
    // helper for deleting the class
    func getClassIndex(classList: [Class], chosenClass: Class) -> Int {
        for i in 0...classList.count-1 {
            if classList[i].equals(someclass: chosenClass) {return i}
        }
        return -1
    }
    
    // Checks if the course is already in schedule
    func hasClass() -> Bool {
        for eachSemester in userData.mySemesters {
            if eachSemester.contains(someclass: detailedClass) {return true}
        }
        return false
    }
    
    // Function to mess w text wrapping (course title)
    func adjustHeight(label: UILabel) {
        if label.intrinsicContentSize.width > ((self.view.frame.width - 20)*2) {
            label.snp.makeConstraints { (make) in
                make.height.equalTo(label.intrinsicContentSize.height*3)
            }
        }
        else if label.intrinsicContentSize.width > (self.view.frame.width - 20) {
            label.snp.makeConstraints { (make) in
                make.height.equalTo(label.intrinsicContentSize.height*2)
            }
        }
    }
    
    // Stops Users from editing TextField without stopping picker view from appearing
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    //Sets number of columns in picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // Sets the number of rows in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (detailedClass.creditsMax - detailedClass.creditsMin + 1)
    }
    
    // Sets the picker options
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(detailedClass.creditsMin + row) credits"
    }
    
    // Changes the objects credit amount and displays new number
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        creditsLabel.text = "\(detailedClass.creditsMin + row)"
        tempCredits = detailedClass.creditsMin + row
        if tempCredits != detailedClass.creditsChosen && loadedFrom == "My Schedule" {
            deleteButton.isHidden = true
            showSaveButton()
        }
    }
    
    func showSaveButton () {
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.width.equalTo(saveButton.intrinsicContentSize.width + 60)
            make.height.equalTo(saveButton.intrinsicContentSize.height)
        }
    }
    @IBAction func stepperHit(_ sender: UIStepper) {
        semesterLabel.text = "Semester \(Int(sender.value))"
        sharedVars.selected_semester = Int(sender.value)
    }
    
    func analyzePreReqs() {
        if (prereqLabel.text?.contains("None"))! {
            print("No prereqs")
        }
        if (prereqLabel.text?.contains("Prerequisite:"))! {
            print("has clasifiable prereq")
        }
        print("end of analysis")
    }
    
}















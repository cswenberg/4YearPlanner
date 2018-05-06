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
}

class DetailViewController: UIViewController {
    
    var delegate: detailViewDelegate?
    
    var detailedClass: Class!
    var courseLabel: UILabel!
    var descriptionLabel: UILabel!
    var descriptionTextView: UITextView!
    var prereqLabel: UILabel!
    var prereqList = [String]()
    var prereqCollectionView: UICollectionView!
    var prereqTextView: UITextView!
    var creditsLabel: UILabel!
    var backButton: UIButton!
    var saveButton: UIButton!
    var deleteButton: UIButton!
    var courseName: String!
    var creditsNum: String!
    var descriptionText: String!
    var prereqText: String!
    var semesterStepper: UIStepper!
    var semesterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let niceOrange = UIColor(red: 1, green: 0.73, blue: 0.19, alpha: 1)
        let niceGreen = UIColor(red: 0.25, green: 0.85, blue: 0.51, alpha: 1)
        
        view.backgroundColor = .white
        
        courseLabel = UILabel()
        courseLabel.font = .boldSystemFont(ofSize: 28)
        courseLabel.text = courseName
        courseLabel.textColor = .black
        view.addSubview(courseLabel)
        
        descriptionLabel = UILabel()
        descriptionLabel.text = "Description"
        descriptionLabel.font = .boldSystemFont(ofSize: 20)
        view.addSubview(descriptionLabel)
        
        descriptionTextView = UITextView()
        descriptionTextView.font = .systemFont(ofSize: 14)
        descriptionTextView.textColor = .black
        descriptionTextView.text = descriptionText
        descriptionTextView.textAlignment = .center
        descriptionTextView.isEditable = false
        view.addSubview(descriptionTextView)
        
        prereqLabel = UILabel()
        prereqLabel.text = "Pre-Requisites"
        prereqLabel.font = .systemFont(ofSize: 20)
        view.addSubview(prereqLabel)
        
        prereqTextView = UITextView()
        prereqTextView.font = .systemFont(ofSize: 16)
        prereqTextView.textColor = .black
        prereqTextView.text = prereqText
        prereqTextView.textAlignment = .center
        prereqTextView.isEditable = false
        view.addSubview(prereqTextView)
        
        creditsLabel = UILabel()
        creditsLabel.font = .systemFont(ofSize: 20)
        creditsLabel.backgroundColor = niceOrange
        creditsLabel.textColor = .white
        creditsLabel.text = creditsNum+" credits"
        creditsLabel.textAlignment = .center
        creditsLabel.layer.cornerRadius = 10
        creditsLabel.clipsToBounds = true
        view.addSubview(creditsLabel)
        
        backButton = UIButton()
        backButton.setTitle("<", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 48)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        view.addSubview(backButton)
        
        saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 32)
        saveButton.backgroundColor = niceGreen
        saveButton.layer.cornerRadius = 16
        saveButton.clipsToBounds = true
        saveButton.titleLabel?.textAlignment = .center
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        
        deleteButton = UIButton()
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.titleLabel?.font = .systemFont(ofSize: 32)
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
        semesterLabel.textColor = .black
        semesterLabel.font = .systemFont(ofSize: 24)
        semesterLabel.textAlignment = .center
        
        
        // Only show save button if not in list of classes already
        if !hasClass() {
            view.addSubview(saveButton)
            saveButton.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview().offset(-40)
                make.centerX.equalToSuperview()
                make.width.equalTo(saveButton.intrinsicContentSize.width + 60)
                make.height.equalTo(saveButton.intrinsicContentSize.height)
            }
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
        //course label
        courseLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            //   make.width.equalTo(courseLabel.intrinsicContentSize.width)
            make.height.equalTo(courseLabel.intrinsicContentSize.height)
        }
        // description label
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(courseLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(descriptionLabel.intrinsicContentSize.height)
        }
        // description text view
        descriptionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(240)
        }
        // prereq label
        prereqLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(prereqLabel.intrinsicContentSize.height)
        }
        // prereq text view
        prereqTextView.snp.makeConstraints { (make) in
            make.top.equalTo(prereqLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        // credits label
        creditsLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(creditsLabel.intrinsicContentSize.width + 20)
            make.height.equalTo(creditsLabel.intrinsicContentSize.height)
        }
        // back button
        backButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.width.equalTo(backButton.intrinsicContentSize.width)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(backButton.intrinsicContentSize.height)
        }
    }
    
    // Returns from modal VC and changes value of stored variable
    @objc func saveButtonPressed(sender: UIButton) {
        saveClass()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func deleteButtonPressed(sender: UIButton) {
        deleteClass()
        delegate?.reloadMyClasses()
        dismiss(animated: true, completion: nil)
    }
    
    // ONLY returns from modal VC
    @objc func backButtonPressed(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveClass() {
        sharedVars.mySemesters[sharedVars.selected_semester-1].classes.append(detailedClass)
    }
    
    func deleteClass() {
        let classes = sharedVars.mySemesters[sharedVars.selected_semester-1].classes
        let index = getClassIndex(classList: classes, chosenClass: detailedClass)
        sharedVars.mySemesters[sharedVars.selected_semester-1].classes.remove(at: index)
    }
    
    func getClassIndex(classList: [Class], chosenClass: Class) -> Int {
        for i in 0...classList.count-1 {
            if classList[i].equals(someclass: chosenClass) {return i}
        }
        return -1
    }
    
    func hasClass() -> Bool {
        for eachSemester in sharedVars.mySemesters {
            for eachClass in eachSemester.classes {
                if detailedClass.equals(someclass: eachClass) {return true}
            }
        }
        return false
    }
    
    @IBAction func stepperHit(_ sender: UIStepper) {
        semesterLabel.text = "Semester \(Int(sender.value))"
        sharedVars.selected_semester = Int(sender.value)
    }
}

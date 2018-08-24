//
//  OptionsViewController.swift
//  4YearPlanner
//
//  Created by Con Swenberg on 4/28/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit

protocol showCoursesDelegate {
    func showCourses()
    func updateCategoryLabel()
    func showCoursesOptions()
    func showBackButton()
}

class OptionsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var optionsCollectionView: UICollectionView!
    var optionsReuseIdentifier = "optionCell"
    
    var cellsToDisplay = [optionsCollectionViewCell]()
    var delegate: showCoursesDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = aesthetics.backgroundColor
        
        
        // Layout for options collectionView
        let optionLayout = UICollectionViewFlowLayout()
        optionLayout.scrollDirection = .vertical
        
        // CollectionView for Colleges/Majors/etc..
        optionsCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: optionLayout)
        optionsCollectionView.dataSource = self
        optionsCollectionView.delegate = self
        optionsCollectionView.register(optionsCollectionViewCell.self, forCellWithReuseIdentifier: optionsReuseIdentifier)
        optionsCollectionView.backgroundColor = aesthetics.backgroundColor
       
        view.addSubview(optionsCollectionView)
        
        setupDiscoverConstraints()
    }
    
    func setupDiscoverConstraints() {
        // Options CollectionView
        optionsCollectionView.snp.makeConstraints { (make) in
            make.trailing.bottom.equalToSuperview().offset(-aesthetics.smallGap)
            make.top.leading.equalToSuperview().offset(aesthetics.smallGap)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if sharedVars.current_category == "Colleges" {return requirementData.allColleges.count}
        else if sharedVars.current_category == "Majors" {return userData.myCollege.majorOptions.count}
        else {return requirementData.allMinors.count}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = optionsCollectionView.dequeueReusableCell(withReuseIdentifier: optionsReuseIdentifier, for: indexPath) as! optionsCollectionViewCell
        if sharedVars.current_category == "Colleges" {
            cell.cellObject = requirementData.allColleges[indexPath.item]
        } else if sharedVars.current_category == "Majors"{
            print("showing majors")
            cell.cellObject = userData.myCollege.majorOptions[indexPath.item]
        } else {
            print("showing minors")
            cell.cellObject = requirementData.allMinors[indexPath.item]
        }
        
        cell.gradientNum = Int(indexPath.item)+aesthetics.gradientRandomizer
        cell.gradient.colors = [aesthetics.gradientList[cell.gradientNum % 4][0], aesthetics.gradientList[cell.gradientNum % 4][1]]
        cell.titleLabel.text = cell.cellObject.title
        cell.layer.cornerRadius = 10
        
        cell.setNeedsUpdateConstraints()
        cellsToDisplay.append(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/2)-16, height: 200)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Change page based on position in the order
    @objc func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if sharedVars.current_category == "Colleges" {
            if let selectedCollege = cellsToDisplay[indexPath.item].cellObject as! College? {
                cellsToDisplay = []
                userData.setCollege(college: selectedCollege)            }
        } else if sharedVars.current_category == "Majors" {
            if let selectedMajor = cellsToDisplay[indexPath.item].cellObject as! Major? {
                cellsToDisplay = []
                userData.setMajor(major: selectedMajor)
            }
        } else if sharedVars.current_category == "Minors" {
            if let selectedMinor = cellsToDisplay[indexPath.item].cellObject as! Minor? {
                cellsToDisplay = []
                userData.setMinor(minor: selectedMinor)
            }
        }
        switchCollection()
        if sharedVars.current_category != "Courses" {
            print("reload called")
            optionsCollectionView.reloadData()
            print(userData.myCollege.majorOptions)
        }
    }
    
    // Switches collection when selected (forward)
    func switchCollection() {
        if sharedVars.current_category == "Colleges" {
            sharedVars.current_category = "Majors"
            delegate?.showBackButton()
        } else if sharedVars.current_category == "Majors" {
            sharedVars.current_category = "Minors"
        } else if sharedVars.current_category == "Minors" {
            sharedVars.current_category = "Courses"
            delegate?.showCourses()
            delegate?.showCoursesOptions()
        }
        delegate?.updateCategoryLabel()
        aesthetics.gradientRandomizer = Int(arc4random_uniform(4))
    }
}


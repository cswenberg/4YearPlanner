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
}

class OptionsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var optionsCollectionView: UICollectionView!
    var optionsReuseIdentifier = "optionCell"
    
    var majorOptions = [majors]()
    var minorOptions = [minors]()
    var cellsToDisplay = [optionsCollectionViewCell]()
    var delegate: showCoursesDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Layout for options collectionView
        let optionLayout = UICollectionViewFlowLayout()
        optionLayout.scrollDirection = .vertical
        
        // CollectionView for Colleges/Majors/etc..
        optionsCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: optionLayout)
        optionsCollectionView.dataSource = self
        optionsCollectionView.delegate = self
        optionsCollectionView.register(optionsCollectionViewCell.self, forCellWithReuseIdentifier: optionsReuseIdentifier)
        optionsCollectionView.backgroundColor = .white
       
        view.addSubview(optionsCollectionView)
        
        setupDiscoverConstraints()
    }
    
    func setupDiscoverConstraints() {
        // Options CollectionView
        optionsCollectionView.snp.makeConstraints { (make) in
            make.trailing.bottom.equalToSuperview().offset(-10)
            make.top.leading.equalToSuperview().offset(10)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if sharedVars.current_category == "Colleges" {return allColleges.count}
        else if sharedVars.current_category == "Majors" {return userData.myCollege.majorOptions.count}
        else {return userData.myMajor.minorOptions.count}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = optionsCollectionView.dequeueReusableCell(withReuseIdentifier: optionsReuseIdentifier, for: indexPath) as! optionsCollectionViewCell
        if sharedVars.current_category == "Colleges" {
            cell.cellObject = College(title: allColleges[indexPath.item],requirements: [])
        } else if sharedVars.current_category == "Majors"{
            majorOptions = userData.myCollege.majorOptions
            cell.cellObject = Major(title: majorOptions[indexPath.item], requirements: [])
        } else {
            cell.cellObject = Minor(title: userData.myMajor.minorOptions[indexPath.item], requirements: [])
        }
        
        cell.gradientNum = Int(indexPath.item)+sharedVars.gradientRandomizer
        cell.gradient.colors = [sharedVars.gradientList[cell.gradientNum % 4][0], sharedVars.gradientList[cell.gradientNum % 4][1]]
        cell.titleLabel.text = cell.cellObject.friendlyTitle()
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
                userData.setCollege(college: selectedCollege)
                majorOptions = userData.myCollege.majorOptions
            }
        } else if sharedVars.current_category == "Majors" {
            if let selectedMajor = cellsToDisplay[indexPath.item].cellObject as! Major? {
                cellsToDisplay = []
                userData.setMajor(major: selectedMajor)
                minorOptions = userData.myMajor.minorOptions
            }
        } else if sharedVars.current_category == "Minors" {
            if let selectedMinor = cellsToDisplay[indexPath.item].cellObject as! Minor? {
                cellsToDisplay = []
                userData.setMinor(minor: selectedMinor)
            }
        }
        switchCollection()
        if sharedVars.current_category != "Courses" {optionsCollectionView.reloadData()}
    }
    
    // Switches collection when selected (forward)
    func switchCollection() {
        if sharedVars.current_category == "Colleges" {
            sharedVars.current_category = "Majors"
        } else if sharedVars.current_category == "Majors" {
            sharedVars.current_category = "Minors"
        } else if sharedVars.current_category == "Minors" {
            sharedVars.current_category = "Courses"
            delegate?.showCourses()
        }
        sharedVars.gradientRandomizer = Int(arc4random_uniform(4))
    }
}


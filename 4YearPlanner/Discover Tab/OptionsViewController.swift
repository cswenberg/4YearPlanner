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
        else if sharedVars.current_category == "Majors" {return majorOptions.count}
        else {return allMinors.count}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = optionsCollectionView.dequeueReusableCell(withReuseIdentifier: optionsReuseIdentifier, for: indexPath) as! optionsCollectionViewCell
        if sharedVars.current_category == "Colleges" {
            cell.cellObject = College(title: allColleges[indexPath.item],requirements: [])
        } else if sharedVars.current_category == "Majors"{
            majorOptions = sharedVars.myCollege.majorOptions
            cell.cellObject = Major(title: majorOptions[indexPath.item], requirements: [])
        } else {
            cell.cellObject = Minors(title: allMinors[indexPath.item], requirements: [])
        }
        print(cell.cellObject.title + " loaded")
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(sharedVars.current_category+" was hit")
        if sharedVars.current_category == "Colleges" {
            print(cellsToDisplay[indexPath.item].cellObject)
            if let selectedCollege = cellsToDisplay[indexPath.item].cellObject as! College? {
                cellsToDisplay = []
                print(selectedCollege.title+" was selected")
                sharedVars.myCollege = selectedCollege
                majorOptions = sharedVars.myCollege.majorOptions
            }
        } else if sharedVars.current_category == "Majors" {
            if (cellsToDisplay[indexPath.item].cellObject as! Major?) != nil {
                let selectedMajor = cellsToDisplay[indexPath.item].cellObject as! Major?
                cellsToDisplay = []
                print(selectedMajor?.title)
            }
        } else if sharedVars.current_category == "Minors" {
            if (cellsToDisplay[indexPath.item].cellObject as! Minors?) != nil {
                cellsToDisplay = []
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
    }
}


//
//  OptionsViewController.swift
//  4YearPlanner
//
//  Created by Con Swenberg on 4/28/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit

protocol optionsViewDelegate {
    func switchCollection(newcollection: String)
    func passChosenOps(chosenitem: Requirements, name: String)
}

class OptionsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var delegate: optionsViewDelegate?
    
    var optionsCollectionView: UICollectionView!
    var optionsReuseIdentifier = "optionCell"
    
    var selectedCollection = "Colleges"
    
    var majorOptions = [majors]()
    var minorOptions = [minors]()
    var cellsToDisplay = [optionsCollectionViewCell]()
    
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
        if selectedCollection == "Colleges" {return allColleges.count}
        else if selectedCollection == "Majors" {return majorOptions.count}
        else {return allMinors.count}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = optionsCollectionView.dequeueReusableCell(withReuseIdentifier: optionsReuseIdentifier, for: indexPath) as! optionsCollectionViewCell
        if selectedCollection == "Colleges" {
            cell.cellObject = College(title: allColleges[indexPath.item],requirements: [])
        } else if selectedCollection == "Majors"{
            cell.cellObject = Major(title: majorOptions[indexPath.item], requirements: [])
        } else {
            cell.cellObject = Minors(title: allMinors[indexPath.item], requirements: [])
        }
        cell.titleLabel.text = cell.cellObject.friendlyTitle()
        cell.layer.cornerRadius = 10
        cell.setNeedsUpdateConstraints()
        cellsToDisplay.append(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 200)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(selectedCollection+" was hit")
        if selectedCollection == "Colleges" {
            if let selectedCollege = cellsToDisplay[indexPath.item].cellObject as! College? {
                cellsToDisplay = []
                majorOptions = selectedCollege.majorOptions
                delegate?.passChosenOps(chosenitem: selectedCollege, name: "College")
            }
        } else if selectedCollection == "Majors" {
            if let selectedMajor = cellsToDisplay[indexPath.item].cellObject as! Major?{
                delegate?.passChosenOps(chosenitem: selectedMajor, name: "Major")
                cellsToDisplay = []
            }
        } else {
            if let selectedMinor = cellsToDisplay[indexPath.item].cellObject as! Minors? {
                delegate?.passChosenOps(chosenitem: selectedMinor, name: "Minor")
                cellsToDisplay = []
            }
        }
        switchCollection()
        optionsCollectionView.reloadData()
    }
    
    func switchCollection(){
        if selectedCollection == "Colleges" {
            selectedCollection = "Majors"
        } else if selectedCollection == "Majors" {
            selectedCollection = "Minors"
        } else if selectedCollection == "Minors" {
            selectedCollection = "Courses"
        }
        delegate?.switchCollection(newcollection: selectedCollection)
    }
    
    func reverseSwitchCollection() {
        if selectedCollection == "Majors" {
            selectedCollection = "Colleges"
        } else if selectedCollection == "Minors" {
            selectedCollection = "Majors"
        }
        delegate?.switchCollection(newcollection: selectedCollection)
    }

    
    
}


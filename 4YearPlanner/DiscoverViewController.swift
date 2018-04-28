//
//  DiscoverViewController.swift
//  4YearPlanner
//
//  Created by Con Swenberg on 4/27/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    var discoverButton: UIButton!
    var myScheduleButton: UIButton!
    var settingsButton: UIButton!
    
    var optionsCollectionView: UICollectionView!
    var optionsReuseIdentifier = "optionCell"
    
    var searchBar: UISearchBar!
    
    var selectedCollection = "Colleges"
    var selectedCollege: College!
    var selectedMajor: Major!
    var selectedMinor: Requirements!
    var majorOptions = [majors]()
    var cellsToDisplay = [optionsCollectionViewCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Search Bar for Colleges/Majors/etc..
        searchBar = UISearchBar()
        definesPresentationContext = true
        
        // Layout for options collectionView
        let optionLayout = UICollectionViewFlowLayout()
        optionLayout.scrollDirection = .vertical
        // CollectionView for Colleges/Majors/etc..
        optionsCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: optionLayout)
        optionsCollectionView.dataSource = self
        optionsCollectionView.delegate = self
        optionsCollectionView.register(optionsCollectionViewCell.self, forCellWithReuseIdentifier: optionsReuseIdentifier)
        optionsCollectionView.backgroundColor = .white

        view.addSubview(searchBar)
        view.addSubview(optionsCollectionView)
        
        setupDiscoverConstraints()
    }
    
    func setupDiscoverConstraints() {
        
        // SearchBar
        searchBar.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(40)
        }
        
        // Options CollectionView
        optionsCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.trailing.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedCollection == "Colleges" {return allColleges.count}
        else if selectedCollection == "Majors" {return majorOptions.count}
        else {return 69}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = optionsCollectionView.dequeueReusableCell(withReuseIdentifier: optionsReuseIdentifier, for: indexPath) as! optionsCollectionViewCell
        if selectedCollection == "Colleges" {
            cell.cellObject = College(title: allColleges[indexPath.item],requirements: [])
        } else if selectedCollection == "Majors"{
            cell.cellObject = Major(title: majorOptions[indexPath.item], requirements: [])
        } else {
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
        if selectedCollection == "Colleges" {
            selectedCollege = cellsToDisplay[indexPath.item].cellObject as! College!
            cellsToDisplay = []
            majorOptions = selectedCollege.majorOptions
        } else if selectedCollection == "Majors" {
            selectedMajor = cellsToDisplay[indexPath.item].cellObject as! Major!
            cellsToDisplay = []
        }
        switchCollection()
        optionsCollectionView.reloadData()
    }
    
    func switchCollection() {
        if selectedCollection == "Colleges" {
            selectedCollection = "Majors"
        } else if selectedCollection == "Majors" {
            selectedCollection = "Minors"
        } else if selectedCollection == "Minors" {
            selectedCollection = ""
        }
    }
    

}

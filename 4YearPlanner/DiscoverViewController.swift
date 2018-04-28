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
    var tabsStackView: UIStackView!
    
    var selectedCollection = "Colleges"
    var selectedCollege: College!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Nice Color of Gray
        let niceGray = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        
        // Font for Tabs
        let tabsFont = UIFont.systemFont(ofSize: 20)

        // Layout for options collectionView
        let optionLayout = UICollectionViewFlowLayout()
        optionLayout.scrollDirection = .vertical
        // Search Bar for Colleges/Majors/etc..
        searchBar = UISearchBar()
        definesPresentationContext = true
        
        // CollectionView for Colleges/Majors/etc..
        optionsCollectionView = UICollectionView()
        optionsCollectionView.collectionViewLayout = optionLayout
        optionsCollectionView.dataSource = self
        optionsCollectionView.delegate = self
        optionsCollectionView.register(optionsCollectionViewCell.self, forCellWithReuseIdentifier: optionsReuseIdentifier)

        
        setupDiscoverConstraints()
    }
    
    func setupDiscoverConstraints() {
        // Tabs StackView
        tabsStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(32)
        }
        
        // SearchBar
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(tabsStackView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        // Options CollectionView
        optionsCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = optionsCollectionView.dequeueReusableCell(withReuseIdentifier: optionsReuseIdentifier, for: indexPath) as! optionsCollectionViewCell
        
        if selectedCollection == "Colleges" {
            cell.collegeName = allColleges[indexPath.item]
            cell.optionLabel.text = cell.collegeName.rawValue
        } else if selectedCollection == "Majors"{
            cell.majorName = allMajors[indexPath.item]
            cell.optionLabel.text = cell.collegeName.rawValue
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    

}

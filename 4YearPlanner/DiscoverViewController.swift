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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Nice Color of Gray
        let niceGray = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        
        // Font for Tabs
        let rabsFont = UIFont.systemFont(ofSize: 20)

        // Layout for options collectionView
        let optionLayout = UICollectionViewFlowLayout()
        optionLayout.scrollDirection = .vertical
        
        // Search Bar for Colleges/Majors/etc..
        searchBar = UISearchBar()
        definesPresentationContext = true
        
        // CollectionView for Colleges/Majors/etc..
        optionsCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: optionLayout)
        optionsCollectionView.dataSource = self
        optionsCollectionView.delegate = self
        optionsCollectionView.register(optionsCollectionViewCell.self, forCellWithReuseIdentifier: optionsReuseIdentifier)

        view.addSubview(searchBar)
        view.addSubview(optionsCollectionView)
        
        setupDiscoverConstraints()
    }
    
    func setupDiscoverConstraints() {
        
        // SearchBar
        print(2)
        searchBar.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(40)
        }
        
        // Options CollectionView
        print(1)
        optionsCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
        print(0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("ran")
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = optionsCollectionView.dequeueReusableCell(withReuseIdentifier: optionsReuseIdentifier, for: indexPath) as! optionsCollectionViewCell
        
        if selectedCollection == "Colleges" {
            print("showing all colleges")
            cell.collegeName = allColleges[indexPath.item]
            print(cell.collegeName.rawValue)
            cell.optionLabel.text = cell.collegeName.rawValue
        } else if selectedCollection == "Majors"{
            print("showing all majors")
            cell.majorName = allMajors[indexPath.item]
            cell.optionLabel.text = cell.collegeName.rawValue
        } else {
            print("showing the wrong things")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 200)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
    
    

}

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
    var homeScrollView: UIScrollView!
    var scrollStackView: UIStackView!
    var tabsStackView: UIStackView!
    var mainStackView: UIStackView!
    var hugeView: UIView!
    
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
        optionsCollectionView.register(optionCollectionViewCell.self, forCellWithReuseIdentifier: optionsReuseIdentifier)

        
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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    

}

//
//  SemesterCollectionViewCell.swift
//  4YearPlanner
//
//  Created by Conner Swenberg on 8/24/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit

class SemesterCollectionViewCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout {
    
    var semester: Semester!
    var myCoursesCollectionView: UICollectionView!
    var courseReuseIdentifier = "myCourseReuseIdentifier"
    var coursesToDisplay = [Class]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //my courses collection view
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        myCoursesCollectionView = UICollectionView(frame: contentView.frame, collectionViewLayout: layout)
        myCoursesCollectionView.register(MyCoursesCollectionViewCell.self, forCellWithReuseIdentifier: courseReuseIdentifier)
        myCoursesCollectionView.backgroundColor = aesthetics.backgroundColor
        myCoursesCollectionView.bounces = true
        contentView.addSubview(myCoursesCollectionView)
        
        myCoursesCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate:MyScheduleViewController, indexPath:IndexPath) {
        myCoursesCollectionView.dataSource = dataSourceDelegate
        myCoursesCollectionView.delegate = dataSourceDelegate
        myCoursesCollectionView.setContentOffset(myCoursesCollectionView.contentOffset, animated: false)
        myCoursesCollectionView.reloadData()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

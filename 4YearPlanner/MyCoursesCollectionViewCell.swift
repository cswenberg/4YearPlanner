//
//  MyCoursesCollectionViewCell.swift
//  4YearPlanner
//
//  Created by Con Swenberg on 4/27/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit

import SnapKit

class MyCoursesCollectionViewCell: UICollectionViewCell {
    
    var cellClass: Class!
    var classLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .lightGray
        
        classLabel = UILabel()
        classLabel.textColor = .white
        classLabel.font = .systemFont(ofSize:36)
        
        contentView.addSubview(classLabel)
        
    }
    
    override func updateConstraints() {
        //class label
        classLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


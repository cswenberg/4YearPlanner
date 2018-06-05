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
    var titleLabel: UILabel!
    var gradient: CAGradientLayer!
    var gradientNum = sharedVars.gradientRandomizer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 20
        
        gradient = CAGradientLayer()
        gradient.frame = contentView.frame
        gradient.colors = [[sharedVars.gradientList[gradientNum % 4][0], sharedVars.gradientList[gradientNum % 4][1]]]
        gradient.locations = [0,1]
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.cornerRadius = contentView.layer.cornerRadius
        contentView.layer.insertSublayer(gradient, at: 0)
        
        classLabel = UILabel()
        classLabel.textColor = .white
        classLabel.font = .systemFont(ofSize:24)
        classLabel.numberOfLines = 0
        
        titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.numberOfLines = 0
        
        contentView.addSubview(classLabel)
        contentView.addSubview(titleLabel)
    }
    
    override func updateConstraints() {
        //class label
        classLabel.snp.makeConstraints { (make) in
            make.top.trailing.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalTo(contentView.snp.centerY)
        }
        //title label
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.centerY)
            make.leading.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview()
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


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
    var gradientNum = aesthetics.gradientRandomizer
    var creditLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 20
        
        gradient = CAGradientLayer()
        gradient.frame = contentView.frame
        gradient.colors = [[aesthetics.gradientList[gradientNum % 4][0], aesthetics.gradientList[gradientNum % 4][1]]]
        gradient.locations = [0,1]
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.cornerRadius = contentView.layer.cornerRadius
        contentView.layer.insertSublayer(gradient, at: 0)
        
        classLabel = UILabel()
        classLabel.textColor = aesthetics.cellTextColor
        classLabel.font = aesthetics.mediumFont
        classLabel.numberOfLines = 0
        
        titleLabel = UILabel()
        titleLabel.textColor = aesthetics.cellTextColor
        titleLabel.font = aesthetics.smallFont
        titleLabel.numberOfLines = 0
        
        creditLabel = UILabel()
        creditLabel.textColor = aesthetics.cellTextColor
        creditLabel.font = aesthetics.mediumFont
        creditLabel.layer.borderWidth = 1
        creditLabel.layer.cornerRadius = 10
        creditLabel.textAlignment = .center
        creditLabel.layer.borderColor = aesthetics.cellTextColor.cgColor
        
        contentView.addSubview(classLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(creditLabel)
    }
    
    override func updateConstraints() {
        //class label
        classLabel.snp.makeConstraints { (make) in
            make.top.trailing.equalToSuperview()
            make.leading.equalToSuperview().offset(aesthetics.smallGap)
            make.bottom.equalTo(contentView.snp.centerY)
        }
        //title label
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.centerY)
            make.leading.equalToSuperview().offset(aesthetics.smallGap)
            make.trailing.bottom.equalToSuperview()
        }
        //credits label
        creditLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(classLabel.snp.centerY)
            make.centerX.equalTo(contentView.snp.trailing).offset(-aesthetics.creditWidth)
            make.width.equalTo(aesthetics.creditWidth)
        }
        super.updateConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gradient.removeFromSuperlayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


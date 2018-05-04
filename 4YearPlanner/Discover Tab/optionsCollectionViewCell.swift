//
//  optionsCollectionViewCell.swift
//  4YearPlanner
//
//  Created by Omar Rasheed on 4/27/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit
import SnapKit

class optionsCollectionViewCell: UICollectionViewCell {
    
    var cellObject: Requirements!
    var titleLabel: UILabel!
    var gradient: CAGradientLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let niceGray = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        contentView.backgroundColor = niceGray
        
        contentView.layer.cornerRadius = 20
        
        let gradient = CAGradientLayer()
        gradient.frame = contentView.frame
        gradient.colors = [UIColor.red.cgColor,
        UIColor.blue.cgColor]
        gradient.locations = [0,1]
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.cornerRadius = contentView.layer.cornerRadius
        contentView.layer.addSublayer(gradient)
        

        
        titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 30)
        
        contentView.addSubview(titleLabel)
    }
    
    override func updateConstraints() {
        //title label
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
          //  make.bottom.equalTo(contentView.snp.centerY)
        }
        super.updateConstraints()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

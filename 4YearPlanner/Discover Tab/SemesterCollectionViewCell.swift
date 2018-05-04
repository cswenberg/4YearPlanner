//
//  SemesterCollectionViewCell.swift
//  4YearPlanner
//
//  Created by Con Swenberg on 4/28/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit

class SemesterCollectionViewCell: UICollectionViewCell {
    
    var number = 0
    var semesterLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let niceGray = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        
        semesterLabel = UILabel()
        semesterLabel.textColor = .white
        semesterLabel.textAlignment = .center
        semesterLabel.backgroundColor = niceGray
        semesterLabel.clipsToBounds = true
        semesterLabel.layer.cornerRadius = 10
        
        contentView.addSubview(semesterLabel)
    }
    
    override func updateConstraints() {
        //semester label
        semesterLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-30)
            make.leading.equalToSuperview().offset(30)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

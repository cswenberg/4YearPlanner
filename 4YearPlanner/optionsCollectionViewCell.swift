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
    
    var optionLabel: UILabel!
    var collegeName: colleges!
    var majorName: majors!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        
        optionLabel = UILabel()
        optionLabel.textColor = .orange
        
        contentView.addSubview(optionLabel)
    }
    
    override func updateConstraints() {
        optionLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        super.updateConstraints()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

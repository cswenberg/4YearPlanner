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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let niceGray = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        contentView.backgroundColor = niceGray
        
        titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 48)
        
        contentView.addSubview(titleLabel)
    }
    
    override func updateConstraints() {
        //title label
        titleLabel.snp.makeConstraints { (make) in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
          //  make.bottom.equalTo(contentView.snp.centerY)
        }
        super.updateConstraints()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

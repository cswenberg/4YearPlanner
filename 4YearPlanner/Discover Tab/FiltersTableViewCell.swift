//
//  FiltersTableViewCell.swift
//  4YearPlanner
//
//  Created by Conner Swenberg on 8/24/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit
class FiltersTableViewCell: UITableViewCell {
    
    var filterTitle: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        
        filterTitle = UILabel()
        filterTitle.text = "Filter"
        filterTitle.font = aesthetics.middieFont
        filterTitle.textColor = .white
        
        filterTitle.alpha = 0
    
        contentView.addSubview(filterTitle)
    }
    
    override func updateConstraints() {
        
        filterTitle.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(aesthetics.smallGap)
            make.width.equalTo(filterTitle.intrinsicContentSize.width)
        }
        
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

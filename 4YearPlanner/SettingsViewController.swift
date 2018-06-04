//
//  SettingsViewController.swift
//  4YearPlanner
//
//  Created by Conner Swenberg on 6/4/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var myInfoLabel: UILabel!
    var collegeLabel: UILabel!
    var majorLabel: UILabel!
    var minorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //myInfoLabel
        myInfoLabel = UILabel()
        myInfoLabel.text = "My Info"
        myInfoLabel.font = .systemFont(ofSize: 36)
        
        //collegeLabel
        collegeLabel = UILabel()
        collegeLabel.text = "College:  None Selected"
        if let collegeText = sharedVars.myCollege?.getTitle() {
            collegeLabel.text = "College:  \(collegeText)"
        }
        //majorLabel
        majorLabel = UILabel()
        majorLabel.text = "Major:     None Selected"
        if let majorText = sharedVars.myMajor?.getTitle() {
            majorLabel.text = "Major:     \(majorText)"
        }
        //minorLabel
        minorLabel = UILabel()
        minorLabel.text = "Minor:     None Selected"
        if let minorText = sharedVars.myMinor?.getTitle() {
            minorLabel.text = "Minor:     \(minorText)"
        }
        
        view.addSubview(myInfoLabel)
        view.addSubview(collegeLabel)
        view.addSubview(majorLabel)
        view.addSubview(minorLabel)
        
        setUpConstraints()
    }

    func setUpConstraints() {
        //my info label
        myInfoLabel.snp.makeConstraints{ (make) in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(myInfoLabel.intrinsicContentSize.width)
        }
        //college label
        collegeLabel.snp.makeConstraints{ (make) in
            make.leading.equalTo(myInfoLabel.snp.leading)
            make.top.equalTo(myInfoLabel.snp.bottom).offset(20)
            make.width.equalTo(collegeLabel.intrinsicContentSize.width)
        }
        //major label
        majorLabel.snp.makeConstraints{ (make) in
            make.leading.equalTo(myInfoLabel.snp.leading)
            make.top.equalTo(collegeLabel.snp.bottom).offset(20)
            make.width.equalTo(majorLabel.intrinsicContentSize.width)
        }
        //minor label
        minorLabel.snp.makeConstraints{ (make) in
            make.leading.equalTo(myInfoLabel.snp.leading)
            make.top.equalTo(majorLabel.snp.bottom).offset(20)
            make.width.equalTo(minorLabel.intrinsicContentSize.width)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

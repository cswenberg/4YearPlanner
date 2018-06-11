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
    var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //myInfoLabel
        myInfoLabel = UILabel()
        myInfoLabel.text = "My Info"
        myInfoLabel.font = .systemFont(ofSize: 36)
        
        //collegeLabel
        collegeLabel = UILabel()
        collegeLabel.text = "College:  None Selected"
        if let collegeText = userData.myCollege?.getTitle() {
            collegeLabel.text = "College:  \(collegeText)"
        }
        //majorLabel
        majorLabel = UILabel()
        majorLabel.text = "Major:     None Selected"
        if let majorText = userData.myMajor?.getTitle() {
            majorLabel.text = "Major:     \(majorText)"
        }
        //minorLabel
        minorLabel = UILabel()
        minorLabel.text = "Minor:     None Selected"
        if let minorText = userData.myMinor?.getTitle() {
            minorLabel.text = "Minor:     \(minorText)"
        }
        //resetButton
        resetButton = UIButton()
        resetButton.setTitle("Reset My Information", for: .normal)
        resetButton.titleLabel?.font = .systemFont(ofSize: 24)
        resetButton.backgroundColor = .red
        resetButton.layer.cornerRadius = 16
        resetButton.clipsToBounds = true
        resetButton.titleLabel?.textAlignment = .center
        resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        
        
        view.addSubview(myInfoLabel)
        view.addSubview(collegeLabel)
        view.addSubview(majorLabel)
        view.addSubview(minorLabel)
        view.addSubview(resetButton)
        
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
            make.trailing.equalToSuperview()
        }
        //major label
        majorLabel.snp.makeConstraints{ (make) in
            make.leading.equalTo(myInfoLabel.snp.leading)
            make.top.equalTo(collegeLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview()
        }
        //minor label
        minorLabel.snp.makeConstraints{ (make) in
            make.leading.equalTo(myInfoLabel.snp.leading)
            make.top.equalTo(majorLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview()
        }
        //reset button
        resetButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-40)
            make.width.equalTo(resetButton.intrinsicContentSize.width+20)
            make.height.equalTo(resetButton.intrinsicContentSize.height)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func resetButtonPressed() {
        collegeLabel.text = "College:  None Selected"
        majorLabel.text = "Major:     None Selected"
        minorLabel.text = "Minor:     None Selected"
        userData.resetUserInfo()
        sharedVars.setCategory()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

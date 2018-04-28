//
//  DetailViewController.swift
//  4YearPlanner
//
//  Created by Omar Rasheed on 4/28/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit
import SnapKit

protocol detailViewDelegate {
    func saveClass(newclass: Class)
}

class DetailViewController: UIViewController {
    
    var delegate: detailViewDelegate?
    
    var detailedClass: Class!
    var courseLabel: UILabel!
    var descriptionLabel: UILabel!
    var descriptionTextView: UITextView!
    var prereqLabel: UILabel!
    var prereqList = [Class]()
    var prereqCollectionView: UICollectionView!
    var creditsLabel: UILabel!
    var backButton: UIButton!
    var saveButton: UIButton!
    var showButton = true
    var courseName: String!
    var creditsNum: String!
    var descriptionText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let niceOrange = UIColor(red: 1, green: 0.73, blue: 0.19, alpha: 1)
        let niceGreen = UIColor(red: 0.25, green: 0.85, blue: 0.51, alpha: 1)
        
        view.backgroundColor = .white
        
        courseLabel = UILabel()
        courseLabel.font = .boldSystemFont(ofSize: 24)
        courseLabel.text = courseName
        courseLabel.textColor = .black
        view.addSubview(courseLabel)
        
        descriptionLabel = UILabel()
        descriptionLabel.text = "Description"
        descriptionLabel.font = .systemFont(ofSize: 20)
        view.addSubview(descriptionLabel)
        
        descriptionTextView = UITextView()
        descriptionTextView.font = .systemFont(ofSize: 16)
        descriptionTextView.textColor = .black
        descriptionTextView.text = descriptionText
        view.addSubview(descriptionTextView)
        
        prereqLabel = UILabel()
        prereqLabel.text = "Pre-Requisites"
        prereqLabel.font = .systemFont(ofSize: 20)
        view.addSubview(prereqLabel)
        
        creditsLabel = UILabel()
        creditsLabel.font = .systemFont(ofSize: 20)
        creditsLabel.backgroundColor = niceOrange
        creditsLabel.textColor = .white
        creditsLabel.text = creditsNum+" credits"
        creditsLabel.textAlignment = .center
        creditsLabel.layer.cornerRadius = 10
        creditsLabel.clipsToBounds = true
        view.addSubview(creditsLabel)
        
        backButton = UIButton()
        backButton.setTitle("<", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 48)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        view.addSubview(backButton)
        
        saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 32)
        saveButton.backgroundColor = niceGreen
        saveButton.layer.cornerRadius = 16
        saveButton.clipsToBounds = true
        saveButton.titleLabel?.textAlignment = .center
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        
        if showButton {
            view.addSubview(saveButton)
            saveButton.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview().offset(-40)
                make.centerX.equalToSuperview()
                make.width.equalTo(saveButton.intrinsicContentSize.width + 60)
                make.height.equalTo(saveButton.intrinsicContentSize.height)
            }
        }
        
        setupConstraints()
    }
    
    func setupConstraints() {
        //course label
        courseLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            //   make.width.equalTo(courseLabel.intrinsicContentSize.width)
            make.height.equalTo(courseLabel.intrinsicContentSize.height)
        }
        // description label
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(courseLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(descriptionLabel.intrinsicContentSize.height)
        }
        // description text view
        descriptionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(80)
            
        }
        // prerequisited label
        prereqLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(prereqLabel.intrinsicContentSize.height)
        }
        // credits label
        creditsLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(creditsLabel.intrinsicContentSize.width + 20)
            make.height.equalTo(creditsLabel.intrinsicContentSize.height)
        }
        // back button
        backButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.width.equalTo(backButton.intrinsicContentSize.width)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(backButton.intrinsicContentSize.height)
        }
    }
    
    @objc func saveButtonPressed(sender: UIButton) {
        print("Save Button Pressed")
        delegate?.saveClass(newclass: detailedClass)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func backButtonPressed(sender: UIButton) {
        print("Back Button Pressed")
        dismiss(animated: true, completion: nil)
    }

}

//
//  DetailViewController.swift
//  4YearPlanner
//
//  Created by Omar Rasheed on 4/28/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    var courseLabel: UILabel!
    var descriptionLabel: UILabel!
    var descriptionTextView: UITextView!
    var prereqLabel: UILabel!
    var creditsLabel: UILabel!
    var backButton: UIButton!
    var saveButton: UIButton!
    var showButton = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let niceOrange = UIColor(red: 1, green: 0.73, blue: 0.19, alpha: 1)
        
        let niceGreen = UIColor(red: 0.25, green: 0.85, blue: 0.51, alpha: 1)
        
        view.backgroundColor = .white
        
        courseLabel = UILabel()
        courseLabel.text = "Microeconomics 1101"
        courseLabel.font = .boldSystemFont(ofSize: 24)
        view.addSubview(courseLabel)
        
        descriptionLabel = UILabel()
        descriptionLabel.text = "Description"
        descriptionLabel.font = .systemFont(ofSize: 20)
        view.addSubview(descriptionLabel)
        
        descriptionTextView = UITextView()
        descriptionTextView.text = "I'm writing stuff that is really random so i can test this bullshit. This shits wack as fuck and i dont know why theyre still cup stacking"
        descriptionTextView.font = .systemFont(ofSize: 16)
        descriptionTextView.textColor = .black
        view.addSubview(descriptionTextView)
        
        prereqLabel = UILabel()
        prereqLabel.text = "Pre-Requisites"
        prereqLabel.font = .systemFont(ofSize: 20)
        view.addSubview(prereqLabel)
        
        creditsLabel = UILabel()
        creditsLabel.text = "3 credits"
        creditsLabel.font = .systemFont(ofSize: 20)
        creditsLabel.backgroundColor = niceOrange
        creditsLabel.textColor = .white
        creditsLabel.textAlignment = .center
        creditsLabel.layer.cornerRadius = 10
        creditsLabel.clipsToBounds = true
        view.addSubview(creditsLabel)
        
        backButton = UIButton()
        backButton.setTitle("<", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 24)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        view.addSubview(backButton)
        
        saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 18)
        saveButton.backgroundColor = niceGreen
        saveButton.layer.cornerRadius = 10
        saveButton.clipsToBounds = true
        saveButton.titleLabel?.textAlignment = .center
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        
        if showButton == true{
            view.addSubview(saveButton)
            saveButton.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview().offset(-20)
                make.centerX.equalToSuperview()
                make.width.equalTo(saveButton.intrinsicContentSize.width + 20)
                make.height.equalTo(saveButton.intrinsicContentSize.height)
            }
        }
        
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    func setupConstraints() {
        print(1)
        courseLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(courseLabel.intrinsicContentSize.height)
        }
        print(2)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(courseLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(descriptionLabel.intrinsicContentSize.height)
        }
        print(3)
        descriptionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(80)
            
        }
        print(4)
        prereqLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(prereqLabel.intrinsicContentSize.height)
        }
        print(4)
        creditsLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(creditsLabel.intrinsicContentSize.width + 20)
            make.height.equalTo(creditsLabel.intrinsicContentSize.height)
        }
        
        backButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.width.equalTo(backButton.intrinsicContentSize.width)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(backButton.intrinsicContentSize.height)
        }
    }
    
    @objc func saveButtonPressed(sender: UIButton) {
        print("Save Button Pressed")
        dismiss(animated: true, completion: nil)
    }
    
    @objc func backButtonPressed(sender: UIButton) {
        print("Back Button Pressed")
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//
//  MyScheduleViewController.swift
//  4YearPlanner
//
//  Created by Con Swenberg on 4/27/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit

class MyScheduleViewController: UIViewController {
    
    //Shared with main view controller
    var selectedSemester = 1
    
    
    var scheduleButtonsStackView: UIStackView!
    var selectedSemesterLabel: UILabel!
    var addCourseButton: UIButton!
    var goLeftButton: UIButton!
    var goRightButton: UIButton!
    var myCoursesCollectionView: UICollectionView!
    var myCoursesCollectionViewCell: UICollectionViewCell!
    
    var myScheduleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myScheduleView = UIView()
        
        //current selected semester label
        selectedSemesterLabel = UILabel()
        selectedSemesterLabel.backgroundColor = .green
        selectedSemesterLabel.layer.cornerRadius = 32
        selectedSemesterLabel.font = .systemFont(ofSize: 48)
        selectedSemesterLabel.text = "Semester \(selectedSemester)"
        selectedSemesterLabel.textAlignment = .center
        
        //add course button
        addCourseButton = UIButton()
        addCourseButton.setTitle("+", for: .normal)
        //addCourseButton.layer.borderWidth = 4
        addCourseButton.addTarget(self, action: #selector(addCourseButtonPress), for: .touchUpInside)
        
        //go left button
        goLeftButton = UIButton()
        goLeftButton.setTitle("<", for: .normal)
        goLeftButton.addTarget(self, action: #selector(goLeftButtonPress), for: .touchUpInside)
        
        //go right button
        goRightButton = UIButton()
        goRightButton.setTitle(">", for: .normal)
        goRightButton.addTarget(self, action: #selector(goRightButtonPress), for: .touchUpInside)
        
        // StackView for buttons within 'My Schedule' tab
        scheduleButtonsStackView = UIStackView(arrangedSubviews: [goLeftButton, addCourseButton, goRightButton])
        scheduleButtonsStackView.axis = .horizontal
        scheduleButtonsStackView.distribution = .equalCentering
        scheduleButtonsStackView.backgroundColor = .blue
        
        setupMyScheduleConstraints()
    }

    
    func setupMyScheduleConstraints() {
        // selected semester label
        selectedSemesterLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(selectedSemesterLabel.intrinsicContentSize.height)
            make.leading.equalTo(myScheduleView.snp.leading).offset(20)
            make.trailing.equalTo(myScheduleView.snp.trailing).offset(-20)
        }
        // 'My Schedule' buttons stack view
        scheduleButtonsStackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(selectedSemesterLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
        // add course button
        addCourseButton.snp.makeConstraints { (make) in
            make.height.equalTo(addCourseButton.intrinsicContentSize.height + 10)
            make.width.equalTo(addCourseButton.intrinsicContentSize.width + 10)
        }
        // go left button
        goLeftButton.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalTo(goLeftButton.intrinsicContentSize.width + 10)
        }
        // go right button
        goRightButton.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalTo(goRightButton.intrinsicContentSize.width + 10)
        }
    }
    
    @objc func addCourseButtonPress() {
        print("add course button pressed")
    }
    
    @objc func goLeftButtonPress() {
        print("go left button pressed")
    }
    
    @objc func goRightButtonPress() {
        print("go right button pressed")
    }

}

//
//  MyScheduleViewController.swift
//  4YearPlanner
//
//  Created by Con Swenberg on 4/27/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit

class MyScheduleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Shared with main view controller
    var selectedSemester = 1
    var allSemesters = [Semester]()
    
    var scheduleButtonsStackView: UIStackView!
    var selectedSemesterLabel: UILabel!
    var addCourseButton: UIButton!
    var goLeftButton: UIButton!
    var goRightButton: UIButton!
    var myCoursesCollectionView: UICollectionView!
    var courseReuseIdentifier = "myCourseReuseIdentifier"
    var coursesToDisplay: [Class] = [Class(subject: "CS", number: "2110", title: "I eat Ass", description: "no really", term: ["Fall"], credits: 69, prerequisites: [])]
    
    var myScheduleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myScheduleView = UIView()
        
        for i in 1...8 {
            let newSemester = Semester(number: i)
            let newClass = Class(subject: "CS", number: "2110", title: "I eat Ass", description: "no really", term: ["Fall"], credits: 69, prerequisites: [])
            newSemester.addClass(newclass: newClass)
            allSemesters.append(newSemester)
        }
        
        coursesToDisplay = allSemesters[selectedSemester-1].classes
        
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
        
        //my courses collection view
        let layout = UICollectionViewFlowLayout()
        myCoursesCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        myCoursesCollectionView.collectionViewLayout = layout
        myCoursesCollectionView.dataSource = self
        myCoursesCollectionView.delegate = self
        myCoursesCollectionView.register(MyCoursesCollectionViewCell.self, forCellWithReuseIdentifier: courseReuseIdentifier)

        view.addSubview(myCoursesCollectionView)
        view.addSubview(selectedSemesterLabel)
        view.addSubview(scheduleButtonsStackView)
        
        setupMyScheduleConstraints()
    }
    
    func setupMyScheduleConstraints() {
        // selected semester label
        selectedSemesterLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(selectedSemesterLabel.intrinsicContentSize.height)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
        }
        // 'My Schedule' buttons stack view
        scheduleButtonsStackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(selectedSemesterLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
        // add course button
        addCourseButton.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalTo(addCourseButton.intrinsicContentSize.width)
        }
        // go left button
        goLeftButton.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalTo(goLeftButton.intrinsicContentSize.width)
        }
        // go right button
        goRightButton.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalTo(goRightButton.intrinsicContentSize.width)
        }
        // my courses collection view
        myCoursesCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(scheduleButtonsStackView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc func addCourseButtonPress() {
        print("add course button pressed")
    }
    
    @objc func goLeftButtonPress() {
        if selectedSemester != 1 {
            selectedSemester-=1
            coursesToDisplay = allSemesters[selectedSemester-1].classes
            myCoursesCollectionView.reloadData()
        }
    }
    
    @objc func goRightButtonPress() {
        if selectedSemester != 8 {
            selectedSemester+=1
            coursesToDisplay = allSemesters[selectedSemester-1].classes
            myCoursesCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
        //return coursesToDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCoursesCollectionView.dequeueReusableCell(withReuseIdentifier: courseReuseIdentifier, for: indexPath) as! MyCoursesCollectionViewCell
        cell.cellClass = coursesToDisplay[indexPath.item]
        cell.classLabel.text = cell.cellClass.classLabel()
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        cell.setNeedsUpdateConstraints()
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        return
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 60)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}


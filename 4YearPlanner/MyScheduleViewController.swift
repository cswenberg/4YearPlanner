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
    var coursesToDisplay = [Class]()
    var cellsToDisplay = [MyCoursesCollectionViewCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let niceGray = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        
        for i in 1...8 {
            let newSemester = Semester(number: i)
            let newClass = Class(subject: "CS", number: "211"+"\(i)", title: "Object-Oriented Programming", description: "1,2,3,4 take more xannies and pour some more", term: ["Fall"], credits: 69, prerequisites: [])
            if i%2 == 0 {
                let anothaClass = Class(subject: "PHYS", number: "1116", title: "Physics: Introduction to Mechanics", description: "", term: ["Fall", "Spring"], credits: 4, prerequisites: [])
                newSemester.addClass(newclass: anothaClass)
            }
            newSemester.addClass(newclass: newClass)
            allSemesters.append(newSemester)
        }
        
        coursesToDisplay = allSemesters[selectedSemester-1].classes
        
        //current selected semester label
        selectedSemesterLabel = UILabel()
        selectedSemesterLabel.backgroundColor = niceGray
        selectedSemesterLabel.textColor = .white
        selectedSemesterLabel.layer.cornerRadius = 24
        selectedSemesterLabel.font = .systemFont(ofSize: 48)
        selectedSemesterLabel.text = "Semester \(selectedSemester)"
        selectedSemesterLabel.textAlignment = .center
        
        //add course button
        addCourseButton = UIButton()
        addCourseButton.setTitle("+", for: .normal)
        addCourseButton.setTitleColor(.black , for: .normal)
        addCourseButton.titleLabel!.font = .systemFont(ofSize: 36)
        addCourseButton.layer.cornerRadius = 20
        addCourseButton.layer.borderWidth = 4
        addCourseButton.addTarget(self, action: #selector(addCourseButtonPress), for: .touchUpInside)
        
        //go left button
        goLeftButton = UIButton()
        goLeftButton.setTitle("<", for: .normal)
        goLeftButton.setTitleColor(.black, for: .normal)
        goLeftButton.titleLabel!.font = .systemFont(ofSize: 36)
        goLeftButton.addTarget(self, action: #selector(goLeftButtonPress), for: .touchUpInside)
        
        //go right button
        goRightButton = UIButton()
        goRightButton.setTitle(">", for: .normal)
        goRightButton.setTitleColor(.black, for: .normal)
        goRightButton.titleLabel!.font = .systemFont(ofSize: 36)
        goRightButton.addTarget(self, action: #selector(goRightButtonPress), for: .touchUpInside)
        
        // StackView for buttons within 'My Schedule' tab
        scheduleButtonsStackView = UIStackView(arrangedSubviews: [goLeftButton, addCourseButton, goRightButton])
        scheduleButtonsStackView.axis = .horizontal
        scheduleButtonsStackView.distribution = .equalCentering
        scheduleButtonsStackView.backgroundColor = .blue
        
        //my courses collection view
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        myCoursesCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        myCoursesCollectionView.collectionViewLayout = layout
        myCoursesCollectionView.dataSource = self
        myCoursesCollectionView.delegate = self
        myCoursesCollectionView.register(MyCoursesCollectionViewCell.self, forCellWithReuseIdentifier: courseReuseIdentifier)
        myCoursesCollectionView.backgroundColor = .white
        myCoursesCollectionView.bounces = true
        
        view.addSubview(myCoursesCollectionView)
        view.addSubview(selectedSemesterLabel)
        view.addSubview(scheduleButtonsStackView)
        
        setupMyScheduleConstraints()
    }
    
    func setupMyScheduleConstraints() {
        // selected semester label
        selectedSemesterLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.height.equalTo(selectedSemesterLabel.intrinsicContentSize.height)
            make.width.equalTo(selectedSemesterLabel.intrinsicContentSize.width + 10)
            make.centerX.equalToSuperview()
            //make.leading.equalTo(view.snp.leading).offset(20)
            //make.trailing.equalTo(view.snp.trailing).offset(-20)
        }
        // 'My Schedule' buttons stack view
        scheduleButtonsStackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(selectedSemesterLabel.snp.bottom).offset(10)
            make.height.equalTo(80)
        }
        // add course button
        addCourseButton.snp.makeConstraints { (make) in
            make.height.equalTo(addCourseButton.intrinsicContentSize.height)
            make.width.equalTo(60)
        }
        // go left button
        goLeftButton.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalTo(goLeftButton.intrinsicContentSize.width*4)
        }
        // go right button
        goRightButton.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalTo(goRightButton.intrinsicContentSize.width*4)
        }
        // my courses collection view
        myCoursesCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(scheduleButtonsStackView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc func addCourseButtonPress(sender: UIButton) {
        print("add course button pressed")
    }
    
    @objc func goLeftButtonPress(sender: UIButton) {
        print("go left button press")
        if selectedSemester != 1 {
            selectedSemester-=1
            selectedSemesterLabel.text = "Semester \(selectedSemester)"
            coursesToDisplay = allSemesters[selectedSemester-1].classes
            myCoursesCollectionView.reloadData()
        }
    }
    
    @objc func goRightButtonPress(sender: UIButton) {
        print("go right button press")
        if selectedSemester != 8 {
            selectedSemester+=1
            selectedSemesterLabel.text = "Semester \(selectedSemester)"
            coursesToDisplay = allSemesters[selectedSemester-1].classes
            myCoursesCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coursesToDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCoursesCollectionView.dequeueReusableCell(withReuseIdentifier: courseReuseIdentifier, for: indexPath) as! MyCoursesCollectionViewCell
        cell.cellClass = coursesToDisplay[indexPath.item]
        cell.classLabel.text = cell.cellClass.classLabel()
        cell.titleLabel.text = cell.cellClass.title
        cell.layer.cornerRadius = 24
        cell.setNeedsUpdateConstraints()
        cellsToDisplay.append(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dVC = DetailViewController()
        //   dVC.delegate = self
        present(dVC, animated: true, completion: nil)
        let selectedCell = cellsToDisplay[indexPath.item]
        if let cellClass = selectedCell.cellClass {
            dVC.courseLabel.text = cellClass.classLabel()
            dVC.creditsLabel.text = String(describing: cellClass.credits)
            dVC.prereqList = cellClass.prerequisites
            dVC.descriptionTextView.text = cellClass.description
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 120)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}


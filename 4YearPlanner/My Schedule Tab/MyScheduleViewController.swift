//
//  MyScheduleViewController.swift
//  4YearPlanner
//
//  Created by Con Swenberg on 4/27/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit


class MyScheduleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, detailViewDelegate {
    
    func reloadMyClasses() {
        myCoursesCollectionView.reloadData()
    }
    
    var niceBlue = UIColor(displayP3Red: 69, green: 69, blue: 255, alpha: 1)
    
    //Shared with main view controller
    var scheduleButtonsStackView: UIStackView!
    var selectedSemesterLabel: UILabel!
    var addCourseButton: UIButton!
    var goLeftButton: UIButton!
    var goRightButton: UIButton!
    var myCoursesCollectionView: UICollectionView!
    var courseReuseIdentifier = "myCourseReuseIdentifier"
    var coursesToDisplay = [Class]()
    var cellsInCollection = [MyCoursesCollectionViewCell]()
    var labelGradient: CAGradientLayer!
    var creditsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //if sharedVars.mySemesters[0].classes.count == 0 {initSemesters()}
        coursesToDisplay = sharedVars.mySemesters[sharedVars.selected_semester-1].classes
        
        //current selected semester label
        selectedSemesterLabel = UILabel()
        selectedSemesterLabel.textColor = .black
        selectedSemesterLabel.backgroundColor = niceBlue
        selectedSemesterLabel.layer.cornerRadius = 24
        selectedSemesterLabel.font = .systemFont(ofSize: 36)
        selectedSemesterLabel.text = "Semester \(sharedVars.selected_semester)"
        selectedSemesterLabel.textAlignment = .center
        
        //add course button
        addCourseButton = UIButton()
        addCourseButton.setTitle("+", for: .normal)
        addCourseButton.setTitleColor(.black , for: .normal)
        addCourseButton.titleLabel!.font = .systemFont(ofSize: 30)
        addCourseButton.layer.cornerRadius = 30
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
        myCoursesCollectionView.dataSource = self
        myCoursesCollectionView.delegate = self
        myCoursesCollectionView.register(MyCoursesCollectionViewCell.self, forCellWithReuseIdentifier: courseReuseIdentifier)
        myCoursesCollectionView.backgroundColor = .white
        myCoursesCollectionView.bounces = true
        
        //credits label
        creditsLabel = UILabel()
        creditsLabel.text = "\(sharedVars.mySemesters[sharedVars.selected_semester-1].credits) credits"
        creditsLabel.font = .systemFont(ofSize: 20)
        creditsLabel.backgroundColor = sharedVars.niceOrange
        creditsLabel.textColor = .white
        creditsLabel.textAlignment = .center
        creditsLabel.layer.cornerRadius = 10
        creditsLabel.clipsToBounds = true
        
        view.addSubview(creditsLabel)
        view.addSubview(myCoursesCollectionView)
        view.addSubview(selectedSemesterLabel)
        view.addSubview(scheduleButtonsStackView)
        setupMyScheduleConstraints()
    }
    
    func setupMyScheduleConstraints() {
        // selected semester label
        selectedSemesterLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(20)
            make.height.equalTo(selectedSemesterLabel.intrinsicContentSize.height)
            make.width.equalTo(selectedSemesterLabel.intrinsicContentSize.width + 10)
        }
        // credits label
        creditsLabel.snp.makeConstraints{ (make) in
            make.centerY.equalTo(selectedSemesterLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-10)
            make.width.equalTo(creditsLabel.intrinsicContentSize.width + 20)
            make.height.equalTo(creditsLabel.intrinsicContentSize.height)
        }
        // 'My Schedule' buttons stack view
        scheduleButtonsStackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(selectedSemesterLabel.snp.bottom).offset(30)
            make.height.equalTo(60)
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
            make.top.equalTo(scheduleButtonsStackView.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // Presents the courses tab as a view controller
    @objc func addCourseButtonPress(sender: UIButton) {
        let navVC = Schedule_addViewController()
        //navVC.delegate = self
        present(navVC, animated: true, completion: nil)
    }
    
    // Changes Semester label/ Stores new semester number
    @objc func goLeftButtonPress(sender: UIButton) {
        if sharedVars.selected_semester != 1 {
            sharedVars.selected_semester-=1
            selectedSemesterLabel.text = "Semester \(sharedVars.selected_semester)"
            updateCredits()
            coursesToDisplay = sharedVars.mySemesters[sharedVars.selected_semester-1].classes
            myCoursesCollectionView.reloadData()
        }
    }
    
    // Changes Semester Label/ Stores new semester number
    @objc func goRightButtonPress(sender: UIButton) {
        if sharedVars.selected_semester != 8 {
            sharedVars.selected_semester+=1
            selectedSemesterLabel.text = "Semester \(sharedVars.selected_semester)"
            updateCredits()
            coursesToDisplay = sharedVars.mySemesters[sharedVars.selected_semester-1].classes
            myCoursesCollectionView.reloadData()
        }
    }
    
    // Refreshes credit total for new selected semester
    func updateCredits() {
        creditsLabel.text = "\(sharedVars.mySemesters[sharedVars.selected_semester-1].credits) credits"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        coursesToDisplay = sharedVars.mySemesters[sharedVars.selected_semester-1].classes
        return coursesToDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCoursesCollectionView.dequeueReusableCell(withReuseIdentifier: courseReuseIdentifier, for: indexPath) as! MyCoursesCollectionViewCell
        cell.cellClass = coursesToDisplay[indexPath.item]
        cell.classLabel.text = cell.cellClass.classLabel()
        cell.titleLabel.text = cell.cellClass.title
        cell.gradientNum = indexPath.item
        cell.gradient.colors = [sharedVars.gradientList[indexPath.item % 4][0], sharedVars.gradientList[indexPath.item % 4][1]]
        cell.layer.insertSublayer(cell.gradient, at: 0)
        cell.layer.cornerRadius = 20
        cell.backgroundColor = .black
        cell.setNeedsUpdateConstraints()
        cellsInCollection.append(cell)
        return cell
    }
    
    // Present Modal VC for detail view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dVC = DetailViewController()
        dVC.delegate = self
        let selectedCell = cellsInCollection[indexPath.item]
        if let cellClass = selectedCell.cellClass {
            dVC.detailedClass = cellClass
            dVC.courseName = cellClass.classLabel()
            dVC.creditsNum = String(describing: cellClass.credits)
          //  dVC.prereqList = cellClass.prerequisites
            dVC.descriptionText = cellClass.description
            present(dVC, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 360
        return CGSize(width: width, height: 120)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}


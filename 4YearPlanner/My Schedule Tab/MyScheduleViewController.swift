//
//  MyScheduleViewController.swift
//  4YearPlanner
//
//  Created by Con Swenberg on 4/27/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//
// testing simulataneous commits
//testing something new

import UIKit


class MyScheduleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, detailViewDelegate, scheduleAddDelegate {
   
    // Delegate func for reloading Schedule (From Schedule-add VC)
    func reloadSchedule() {
        myCoursesCollectionView.reloadData()
        updateCredits()
    }
    
    // Delegate func for reloading class information (From Detail VC)
    func reloadMyClasses() {
        myCoursesCollectionView.reloadData()
    }
    
    // Delegate func for reloading credit count (From Detail VC)
    func reloadCredits() {
        updateCredits()
    }
    
    var niceBlue = UIColor(displayP3Red: 69, green: 69, blue: 255, alpha: 1)
    
    //Shared with main view controller
    var selectedSemesterLabel: UILabel!
    var addCourseButton: UIButton!
    var myCoursesCollectionView: UICollectionView!
    var mySemestersCollectionView: UICollectionView!
    var semesterReuseIdentifier = "mySemesterReuseIdentifier"
    var courseReuseIdentifier = "myCourseReuseIdentifier"
    var coursesToDisplay = [Class]()
    var labelGradient: CAGradientLayer!
    var creditsLabel: UILabel!
    var swipeRight: UISwipeGestureRecognizer!
    var swipeLeft: UISwipeGestureRecognizer!
    var receivedCreditAlert = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = aesthetics.backgroundColor
        
        //if sharedVars.mySemesters[0].classes.count == 0 {initSemesters()}
        coursesToDisplay = userData.mySemesters[sharedVars.selected_semester-1].classes
        
        //current selected semester label
        selectedSemesterLabel = UILabel()
        selectedSemesterLabel.textColor = aesthetics.textColor
        selectedSemesterLabel.backgroundColor = aesthetics.backgroundColor
        selectedSemesterLabel.layer.cornerRadius = 24
        selectedSemesterLabel.font = .boldSystemFont(ofSize: 36)
        selectedSemesterLabel.text = sharedVars.yearTerm()
        selectedSemesterLabel.textAlignment = .left
        
        //add course button
        addCourseButton = UIButton()
        addCourseButton.setTitle("Add Course", for: .normal)
        addCourseButton.setTitleColor(aesthetics.cellTextColor , for: .normal)
        addCourseButton.titleLabel!.font = aesthetics.mediumFont
        addCourseButton.backgroundColor = aesthetics.niceGreen
        addCourseButton.layer.cornerRadius = 16
        addCourseButton.addTarget(self, action: #selector(addCourseButtonPress), for: .touchUpInside)
        
        //my courses collection view
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        myCoursesCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        myCoursesCollectionView.dataSource = self
        myCoursesCollectionView.delegate = self
        myCoursesCollectionView.register(MyCoursesCollectionViewCell.self, forCellWithReuseIdentifier: courseReuseIdentifier)
        myCoursesCollectionView.backgroundColor = aesthetics.backgroundColor
        myCoursesCollectionView.bounces = true
        
        //semesters collection view
//        let semesterLayout = UICollectionViewFlowLayout()
//        semesterLayout.scrollDirection = .horizontal
//        mySemestersCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: semesterLayout)
//        mySemestersCollectionView.dataSource = self
//        mySemestersCollectionView.delegate = self
//        mySemestersCollectionView.register(SemesterCollectionViewCell.self, forCellWithReuseIdentifier: semesterReuseIdentifier)
//        mySemestersCollectionView.backgroundColor = aesthetics.backgroundColor
//        mySemestersCollectionView.bounces = true
//        mySemestersCollectionView.isPagingEnabled = true
//        mySemestersCollectionView.allowsSelection = false
        
        //credits label
        creditsLabel = UILabel()
        creditsLabel.font = aesthetics.mediumFont
        creditsLabel.textColor = aesthetics.cellTextColor
        creditsLabel.textAlignment = .center
        creditsLabel.layer.cornerRadius = 10
        creditsLabel.clipsToBounds = true
        updateCredits()
        
        //swipeRight gesture
        swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        //swipeLeft gesture
        swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        view.addSubview(creditsLabel)
        view.addSubview(myCoursesCollectionView)
        view.addSubview(selectedSemesterLabel)
        view.addSubview(addCourseButton)
        setupMyScheduleConstraints()
        checkCredits()
    }
    
    func setupMyScheduleConstraints() {
        // selected semester label
        selectedSemesterLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(aesthetics.smallGap)
            make.height.equalTo(selectedSemesterLabel.intrinsicContentSize.height)
            make.trailing.equalTo(creditsLabel.snp.leading)
        }
        // credits label
        creditsLabel.snp.makeConstraints{ (make) in
            make.centerY.equalTo(selectedSemesterLabel.snp.centerY)
            make.centerX.equalTo(view.snp.trailing).offset(-33)
            make.width.equalTo(creditsLabel.intrinsicContentSize.width + 16)
            make.height.equalTo(creditsLabel.intrinsicContentSize.height)
        }
       
        // add course button
        addCourseButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-aesthetics.mediumGap)
            make.height.equalTo(addCourseButton.intrinsicContentSize.height)
            make.width.equalTo(addCourseButton.intrinsicContentSize.width+20)
        }
        // my courses collection view
        myCoursesCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(selectedSemesterLabel.snp.bottom).offset(aesthetics.smallGap)
            make.bottom.equalTo(addCourseButton.snp.top).offset(-aesthetics.smallGap)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    // Presents the courses tab as a view controller
    @objc func addCourseButtonPress(sender: UIButton) {
        let navVC = Schedule_addViewController()
        navVC.delegate = self
        present(navVC, animated: true, completion: nil)
    }
    
    func testObjectifyClass() {
        sharedVars.searchCourse = "ECE 3410"
        Network.getClassObject { (courses) in
            print(courses)
        }
    }
    
    // changes semester information through swiping gestures
    @objc func respondToSwipe(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                if sharedVars.selected_semester != 1 {
                    sharedVars.selected_semester-=1
                    selectedSemesterLabel.text = sharedVars.yearTerm()
                    updateCredits()
                    coursesToDisplay = userData.mySemesters[sharedVars.selected_semester-1].classes
                    myCoursesCollectionView.reloadData()
                    if !receivedCreditAlert {checkCredits()}
                }
            case UISwipeGestureRecognizerDirection.left:
                if sharedVars.selected_semester != 8 {
                    sharedVars.selected_semester+=1
                    selectedSemesterLabel.text = sharedVars.yearTerm()
                    updateCredits()
                    coursesToDisplay = userData.mySemesters[sharedVars.selected_semester-1].classes
                    myCoursesCollectionView.reloadData()
                    if !receivedCreditAlert {checkCredits()}
                }
            default:
                break
            }
        }
    }
    
    // Refreshes credit total for new selected semester
    func updateCredits() {
        creditsLabel.text = "\(userData.mySemesters[sharedVars.selected_semester-1].credits)"
        if userData.mySemesters[sharedVars.selected_semester-1].credits<12 {
            creditsLabel.backgroundColor = aesthetics.niceOrange
        } else {
            creditsLabel.backgroundColor = aesthetics.niceGreen
        }
    }
    
    // Triggers credit Alerts
    func checkCredits() {
        if (userData.mySemesters[sharedVars.selected_semester-1].credits)>23 {
            let alert = UIAlertController(title: "Reminder", message: "credits > 23; you may need to petition", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
            self.present(alert, animated: true, completion: nil)
            receivedCreditAlert = true
        } else if (userData.mySemesters[sharedVars.selected_semester-1].credits)<12 {
            let alert = UIAlertController(title: "Reminder", message: "credits < 12; you won't be in good academic standing", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
            self.present(alert, animated: true, completion: nil)
            receivedCreditAlert = true
        }
    }
    
    //1st in reloadData()
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //2nd in reloadData()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == mySemestersCollectionView) {
            return userData.mySemesters.count
        } else {
            coursesToDisplay = userData.mySemesters[sharedVars.selected_semester-1].classes
//            userData.printSemester(number: 0)
//            print("data reloaded")
            return coursesToDisplay.count
        }
    }
    //3rd in reloadData()
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == mySemestersCollectionView) {
            return CGSize(width: view.frame.size.width, height: view.frame.size.height)
        } else {
            let width = view.frame.size.width-20
            return CGSize(width: width, height: 120)
        }
    }
    //4th in reloadData()
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !(collectionView == mySemestersCollectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: courseReuseIdentifier, for: indexPath) as! MyCoursesCollectionViewCell
            cell.cellClass = coursesToDisplay[indexPath.item]
            cell.classLabel.text = cell.cellClass.classLabel()
            cell.creditLabel.text = String(cell.cellClass.creditsChosen)
            cell.titleLabel.text = cell.cellClass.title
            cell.gradientNum = indexPath.item
            cell.gradient.colors = [aesthetics.gradientList[indexPath.item % 4][0], aesthetics.gradientList[indexPath.item % 4][1]]
            cell.layer.insertSublayer(cell.gradient, at: 0)
            cell.layer.cornerRadius = 20
            cell.backgroundColor = .black
            cell.setNeedsUpdateConstraints()
            return cell
        } else {
            let cell = mySemestersCollectionView.dequeueReusableCell(withReuseIdentifier: semesterReuseIdentifier, for: indexPath) as! SemesterCollectionViewCell
            cell.semester = userData.mySemesters[indexPath.item]
            cell.setNeedsUpdateConstraints()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? SemesterCollectionViewCell {
            cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, indexPath: indexPath)
        }
    }
    
    // Present Modal VC for detail view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dVC = DetailViewController()
        dVC.delegate = self
        let cellClass = coursesToDisplay[indexPath.item]
        dVC.detailedClass = cellClass
        dVC.loadedFrom = "My Schedule"
        //dVC.prereqList = cellClass.prerequisites
        present(dVC, animated: true, completion: nil)
    }
}


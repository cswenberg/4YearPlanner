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
    func reloadCredits() {
        updateCredits()
    }
    
    var niceBlue = UIColor(displayP3Red: 69, green: 69, blue: 255, alpha: 1)
    
    //Shared with main view controller
    var selectedSemesterLabel: UILabel!
    var addCourseButton: UIButton!
    var myCoursesCollectionView: UICollectionView!
    var courseReuseIdentifier = "myCourseReuseIdentifier"
    var coursesToDisplay = [Class]()
    var cellsInCollection = [MyCoursesCollectionViewCell]()
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
        addCourseButton.titleLabel!.font = .systemFont(ofSize: 24)
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
        
        //credits label
        creditsLabel = UILabel()
        creditsLabel.font = .systemFont(ofSize: 24)
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
            make.top.leading.equalToSuperview().offset(10)
            make.height.equalTo(selectedSemesterLabel.intrinsicContentSize.height)
            make.trailing.equalTo(creditsLabel.snp.leading)
        }
        // credits label
        creditsLabel.snp.makeConstraints{ (make) in
            make.centerY.equalTo(selectedSemesterLabel.snp.centerY)
            make.centerX.equalTo(view.snp.trailing).offset(-33)
            make.width.equalTo(creditsLabel.intrinsicContentSize.width + 12)
            make.height.equalTo(creditsLabel.intrinsicContentSize.height)
        }
       
        // add course button
        addCourseButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(addCourseButton.intrinsicContentSize.height)
            make.width.equalTo(addCourseButton.intrinsicContentSize.width+20)
        }
        // my courses collection view
        myCoursesCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(selectedSemesterLabel.snp.bottom).offset(10)
            make.bottom.equalTo(addCourseButton.snp.top).offset(-10)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    // Presents the courses tab as a view controller
    @objc func addCourseButtonPress(sender: UIButton) {
        let navVC = Schedule_addViewController()
        //navVC.delegate = self
        present(navVC, animated: true, completion: nil)
    }
    
    func testObjectifyClass() {
        Network.getClassObject { (courses) in
            print(courses)
        }
        userData.mySemesters[sharedVars.selected_semester-1].addClass(newclass: userData.tmpClass)
        myCoursesCollectionView.reloadData()
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
    
    func checkCredits() {
        if (userData.mySemesters[sharedVars.selected_semester-1].credits)>23 {
            let alert = UIAlertController(title: "Reminder", message: "credits > 23; you may need to petition", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default Action"), style: .default, handler: { _ in NSLog("The \"Ok\" alert occured.")}))
            self.present(alert, animated: true, completion: nil)
            receivedCreditAlert = true
        } else if (userData.mySemesters[sharedVars.selected_semester-1].credits)<12 {
            let alert = UIAlertController(title: "Reminder", message: "credits < 12; you won't be in good academic standing", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default Action"), style: .default, handler: { _ in NSLog("The \"Ok\" alert occured.")}))
            self.present(alert, animated: true, completion: nil)
            receivedCreditAlert = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        coursesToDisplay = userData.mySemesters[sharedVars.selected_semester-1].classes
        return coursesToDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCoursesCollectionView.dequeueReusableCell(withReuseIdentifier: courseReuseIdentifier, for: indexPath) as! MyCoursesCollectionViewCell
        cell.cellClass = coursesToDisplay[indexPath.item]
        cell.classLabel.text = cell.cellClass.classLabel()
        cell.titleLabel.text = cell.cellClass.title
        cell.creditLabel.text = String(cell.cellClass.creditsChosen)
        cell.gradientNum = indexPath.item
        cell.gradient.colors = [aesthetics.gradientList[indexPath.item % 4][0], aesthetics.gradientList[indexPath.item % 4][1]]
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
            dVC.creditsNum = String(describing: cellClass.creditsChosen)
          //  dVC.prereqList = cellClass.prerequisites
            dVC.descriptionText = cellClass.descriptionn
            present(dVC, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width-20
        return CGSize(width: width, height: 120)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}


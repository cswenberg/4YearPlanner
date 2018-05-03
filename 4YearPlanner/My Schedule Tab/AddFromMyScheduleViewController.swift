//
//  AddFromMyScheduleViewController.swift
//  4YearPlanner
//
//  Created by Omar Rasheed on 4/29/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit

protocol navClassesDelegate {
    func semesterChosen() -> String
    
}

class AddFromMyScheduleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var semestersCollectionView: UICollectionView!
    var semesterAddReuseIdentifier = "semesterAddReuseIdentifier"
    var addCoursesCollectionView: UICollectionView!
    var addcourse2ReuseIdentifier = "addcourse2ReuseIdentiyer"
    
    var coursesToDisplay = [Class]()
    var cellsInCollection = [MyCoursesCollectionViewCell]()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        let newclass = Class(subject: "MATH", number: "6969", title: "Infinite foils & connected surfaces", description: "1,2,3,4 take more xannies and pour some more", term: ["Fall"], credits: 69, prerequisites: [])
        coursesToDisplay.append(newclass)
        coursesToDisplay.append(newclass)
        coursesToDisplay.append(newclass)
        coursesToDisplay.append(newclass)
        coursesToDisplay.append(newclass)
        coursesToDisplay.append(newclass)
        
        
        //semester collection view
        let semesterLayout = UICollectionViewFlowLayout()
        semesterLayout.scrollDirection = .horizontal
        semestersCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: semesterLayout)
        semestersCollectionView.dataSource = self
        semestersCollectionView.delegate = self
        semestersCollectionView.register(SemesterCollectionViewCell.self, forCellWithReuseIdentifier: semesterAddReuseIdentifier)
        semestersCollectionView.backgroundColor = .white
        
        //add courses collection view
        let addCourseLayout = UICollectionViewFlowLayout()
        addCourseLayout.scrollDirection = .vertical
        addCoursesCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: addCourseLayout)
        addCoursesCollectionView.dataSource = self
        addCoursesCollectionView.delegate = self
        addCoursesCollectionView.register(MyCoursesCollectionViewCell.self, forCellWithReuseIdentifier: addcourse2ReuseIdentifier)
        addCoursesCollectionView.backgroundColor = .white
        
        view.addSubview(semestersCollectionView)
        view.addSubview(addCoursesCollectionView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        //semester collection view
        semestersCollectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        //add courses collection view
        addCoursesCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(semestersCollectionView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == semestersCollectionView {
            return 8
        } else{
            return coursesToDisplay.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == semestersCollectionView {
            let cell = semestersCollectionView.dequeueReusableCell(withReuseIdentifier: semesterAddReuseIdentifier, for: indexPath) as! SemesterCollectionViewCell
            cell.number = indexPath.item+1
            cell.semesterLabel.text = "Semester \(cell.number)"
            cell.setNeedsUpdateConstraints()
            return cell
        } else {
            let cell = addCoursesCollectionView.dequeueReusableCell(withReuseIdentifier: addcourse2ReuseIdentifier, for: indexPath) as! MyCoursesCollectionViewCell
            cell.cellClass = coursesToDisplay[indexPath.item]
            cell.classLabel.text = cell.cellClass.classLabel()
            cell.titleLabel.text = cell.cellClass.title
            cellsInCollection.append(cell)
            print(cell.cellClass.classLabel())
            cell.setNeedsUpdateConstraints()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == semestersCollectionView {
            return CGSize(width: 300, height: 100)
        } else {
            return CGSize(width: 350, height: 120)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == semestersCollectionView {
            //delegate?.selectedNewSemester(number: indexPath.item)
            print("ran if")
        } else {
            let dVC = DetailViewController()
            //   dVC.delegate = self
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
    }
}

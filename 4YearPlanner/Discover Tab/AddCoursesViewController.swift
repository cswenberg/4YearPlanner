//
//  AddCoursesViewController.swift
//  4YearPlanner
//
//  Created by Con Swenberg on 4/28/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit

class AddCoursesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var semestersCollectionView: UICollectionView!
    var semesterReuseIdentifier = "semesterReuseIdentifier"
    var addCoursesCollectionView: UICollectionView!
    var addcourseReuseIdentifier = "addcourseReuseIdentiyer"
    
    var coursesToDisplay = [Class]()
    var cellsInCollection = [MyCoursesCollectionViewCell]()
    var buttonGradient: CAGradientLayer!
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        let newclass = Class(subject: "MATH", number: "6969", title: "Infinite foils & connected surfaces", description: "1,2,3,4 take more xannies and pour some more", term: ["Fall"], credits: 69, prerequisites: [])
        coursesToDisplay.append(newclass)
        coursesToDisplay.append(newclass)
        coursesToDisplay.append(newclass)
        
        // button gradient
        buttonGradient = CAGradientLayer()
        buttonGradient.colors = [UIColor.red.cgColor,
                                 UIColor.blue.cgColor]
        buttonGradient.startPoint = CGPoint(x: 1, y: 0.5)
        buttonGradient.endPoint = CGPoint(x: 0, y: 0.5)
        buttonGradient.cornerRadius = 16
        buttonGradient.frame = CGRect(x: 0, y: 0, width: 96, height: 36)
        
        //semester collection view
        let semesterLayout = UICollectionViewFlowLayout()
        semesterLayout.scrollDirection = .horizontal
        semesterLayout.minimumInteritemSpacing = 0
        semesterLayout.minimumLineSpacing = 0
        semestersCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: semesterLayout)
        semestersCollectionView.dataSource = self
        semestersCollectionView.delegate = self
        semestersCollectionView.register(SemesterCollectionViewCell.self, forCellWithReuseIdentifier: semesterReuseIdentifier)
        semestersCollectionView.backgroundColor = .white
        semestersCollectionView.isPagingEnabled = true
        
        //add courses collection view
        let addCourseLayout = UICollectionViewFlowLayout()
        addCourseLayout.scrollDirection = .vertical
        addCoursesCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: addCourseLayout)
        addCoursesCollectionView.dataSource = self
        addCoursesCollectionView.delegate = self
        addCoursesCollectionView.register(MyCoursesCollectionViewCell.self, forCellWithReuseIdentifier: addcourseReuseIdentifier)
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
            let cell = semestersCollectionView.dequeueReusableCell(withReuseIdentifier: semesterReuseIdentifier, for: indexPath) as! SemesterCollectionViewCell
            cell.number = indexPath.item+1
            cell.semesterLabel.text = "Semester \(cell.number)"
            cell.setNeedsUpdateConstraints()
            return cell
        } else {
            let cell = addCoursesCollectionView.dequeueReusableCell(withReuseIdentifier: addcourseReuseIdentifier, for: indexPath) as! MyCoursesCollectionViewCell
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
            return CGSize(width: view.frame.width, height: 100)
        } else {
            return CGSize(width: 350, height: 120)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Present Detail View modally
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == semestersCollectionView {
            sharedVars.selected_semester = indexPath.item
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
    
    func setBackgroundGradient (label: UILabel) {
        print("tries to set gradient for \(label)")
        buttonGradient = CAGradientLayer()
        buttonGradient.colors = [UIColor.red.cgColor,
                                 UIColor.blue.cgColor]
        buttonGradient.startPoint = CGPoint(x: 1, y: 0.5)
        buttonGradient.endPoint = CGPoint(x: 0, y: 0.5)
        buttonGradient.cornerRadius = 16
        buttonGradient.frame = label.bounds
        label.layer.insertSublayer(buttonGradient, at: 0)
    }
}









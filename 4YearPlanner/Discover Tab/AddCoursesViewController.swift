//
//  AddCoursesViewController.swift
//  4YearPlanner
//
//  Created by Con Swenberg on 4/28/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit

protocol addCoursesDelegate {
    func presentDVC(cellClass: Class)
}

class AddCoursesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func reloadCourses() {
        print("successful call")
        addCoursesCollectionView.reloadData()
    }
    
    var addCoursesCollectionView: UICollectionView!
    var addcourseReuseIdentifier = "addcourseReuseIdentiyer"
    
    var delegate: addCoursesDelegate?
    var fallSelected = false
    var springSelected = false
    
    var courses = [Class]()
    var buttonGradient: CAGradientLayer!
    
    override func viewDidLoad() {
        view.backgroundColor = aesthetics.backgroundColor
        
        //add courses collection view
        let addCourseLayout = UICollectionViewFlowLayout()
        addCourseLayout.scrollDirection = .vertical
        addCoursesCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: addCourseLayout)
        addCoursesCollectionView.dataSource = self
        addCoursesCollectionView.delegate = self
        addCoursesCollectionView.register(MyCoursesCollectionViewCell.self, forCellWithReuseIdentifier: addcourseReuseIdentifier)
        addCoursesCollectionView.backgroundColor = aesthetics.backgroundColor
        
        view.addSubview(addCoursesCollectionView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        //add courses collection view
        addCoursesCollectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(aesthetics.smallGap)
            make.leading.trailing.bottom.equalToSuperview()
        }
 }
    
    //1st in reloadData()
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //2nd in reloadData()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("\(sharedVars.discoverCourses.count) courses were loaded")
        print("'\(sharedVars.searchSubject) + \(sharedVars.searchNumber)' was searched")
        return sharedVars.discoverCourses.count
    }
    //3rd in reloadData()
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width - 20
        return CGSize(width: width, height: 120)
    }
    //4th in reloadData()
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = addCoursesCollectionView.dequeueReusableCell(withReuseIdentifier: addcourseReuseIdentifier, for: indexPath) as! MyCoursesCollectionViewCell
        cell.cellClass = sharedVars.discoverCourses[indexPath.item]
        cell.classLabel.text = cell.cellClass.classLabel()
        cell.creditLabel.text = String(cell.cellClass.creditsChosen)
        cell.titleLabel.text = cell.cellClass.title
        cell.gradientNum = indexPath.item
        cell.gradient.colors = [aesthetics.gradientList[indexPath.item % 4][0], aesthetics.gradientList[indexPath.item % 4][1]]
        cell.layer.insertSublayer(cell.gradient, at: 0)
        cell.layer.cornerRadius = 20
        cell.setNeedsUpdateConstraints()
        return cell
    }
    
    // Present Detail View modally
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellClass = sharedVars.discoverCourses[indexPath.item]
        delegate?.presentDVC(cellClass: cellClass)
    }
    
    // function to setup gradients
    func setBackgroundGradient (button: UIButton) {
        buttonGradient = CAGradientLayer()
        buttonGradient.colors = [UIColor.red.cgColor,
                                 UIColor.blue.cgColor]
        buttonGradient.startPoint = CGPoint(x: 1, y: 0.5)
        buttonGradient.endPoint = CGPoint(x: 0, y: 0.5)
        buttonGradient.cornerRadius = 16
        buttonGradient.frame = button.bounds
        button.layer.insertSublayer(buttonGradient, at: 0)
    }
}

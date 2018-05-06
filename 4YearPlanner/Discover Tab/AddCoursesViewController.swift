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
    
    var termsStackView: UIStackView!
    var fallButton: UIButton!
    var springButton: UIButton!
    var fallSelected = false
    var springSelected = false
    
    var courses = [Class]()
    
    var cellsInCollection = [MyCoursesCollectionViewCell]()
    var buttonGradient: CAGradientLayer!
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        // Button for the MySchedule Tab
        fallButton = UIButton()
        fallButton.layer.cornerRadius = fallButton.intrinsicContentSize.height/2
        fallButton.setTitle("Fall", for: .normal)
        fallButton.titleLabel?.font = .systemFont(ofSize: 32)
        fallButton.setTitleColor(.black, for: .normal)
        fallButton.layer.borderWidth = 2
        fallButton.layer.borderColor = sharedVars.termColor.cgColor
        fallButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        // Button for Settings Tab
        springButton = UIButton()
        springButton.layer.cornerRadius = springButton.intrinsicContentSize.height/2
        springButton.setTitle("Spring", for: .normal)
        springButton.titleLabel?.font = .systemFont(ofSize: 32)
        springButton.setTitleColor(.black, for: .normal)
        springButton.layer.borderWidth = 2
        springButton.layer.borderColor = sharedVars.termColor.cgColor
        springButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    
        
        // StackView for tabs at the top
        termsStackView = UIStackView(arrangedSubviews: [fallButton, springButton])
        termsStackView.axis = .horizontal
        termsStackView.distribution = .equalCentering
        
        //add courses collection view
        let addCourseLayout = UICollectionViewFlowLayout()
        addCourseLayout.scrollDirection = .vertical
        addCoursesCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: addCourseLayout)
        addCoursesCollectionView.dataSource = self
        addCoursesCollectionView.delegate = self
        addCoursesCollectionView.register(MyCoursesCollectionViewCell.self, forCellWithReuseIdentifier: addcourseReuseIdentifier)
        addCoursesCollectionView.backgroundColor = .white
        
        view.addSubview(termsStackView)
        view.addSubview(addCoursesCollectionView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        // terms stack
        termsStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(80)
            make.trailing.equalToSuperview().offset(-80)
            make.height.equalTo(60)
        }
        
        // Fall Button
        fallButton.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalTo(springButton.intrinsicContentSize.width)
        }
        // Spring Button
        springButton.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalTo(springButton.intrinsicContentSize.width + 20)
        }
        
        //add courses collection view
        addCoursesCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(termsStackView.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == semestersCollectionView {
            return 8
        } else {
            return sharedVars.discoverCourses.count
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
            cell.cellClass = sharedVars.discoverCourses[indexPath.item]
            cell.gradientNum = indexPath.item
            cell.gradient.colors = [sharedVars.gradientList[indexPath.item % 4][0], sharedVars.gradientList[indexPath.item % 4][1]]
            cell.layer.insertSublayer(cell.gradient, at: 0)
            cell.layer.cornerRadius = 20
            cell.classLabel.text = cell.cellClass.classLabel()
            cell.titleLabel.text = cell.cellClass.title
            
            cellsInCollection.append(cell)
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
                dVC.prereqList = [cellClass.pulledPrereqs!]
                dVC.prereqText = cellClass.pulledPrereqs
                dVC.descriptionText = cellClass.description
                present(dVC, animated: true, completion: nil)
            }
        }
    }
    
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
    
    @objc func buttonPressed (sender:UIButton) {
        switchSelected(s: (sender.titleLabel?.text)!)
        if sender.titleLabel?.text == "Fall" {
            if fallSelected {
                fallButton.backgroundColor = sharedVars.termColor
                fallButton.setTitleColor(.white, for: .normal)
            } else {
                fallButton.backgroundColor = .white
                fallButton.setTitleColor(.black, for: .normal)
            }
        }
        else if sender.titleLabel?.text == "Spring" {
            if springSelected {
                springButton.backgroundColor = sharedVars.termColor
                springButton.setTitleColor(.white, for: .normal)
            } else {
                springButton.backgroundColor = .white
                springButton.setTitleColor(.black, for: .normal)
            }
        }
        if (fallSelected && springSelected) {sharedVars.searchTerm = "fall and spring"}
        else if fallSelected {sharedVars.searchTerm = "fall"}
        else if springSelected {sharedVars.searchTerm = "spring"}
        else {sharedVars.searchTerm = ""}
        Network.getAllCourses { (courses) in
            print(courses)
        }
        addCoursesCollectionView.reloadData()
    }
    
    func switchSelected(s: String) {
        if s == "Fall" {
            if fallSelected {fallSelected = false}
            else {fallSelected = true}
        }
        else if s == "Spring" {
            if springSelected {springSelected = false}
            else {springSelected = true}
        }
    }
}

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
    
    var coursesToDisplay = [Class]()
    var cellsInCollection = [MyCoursesCollectionViewCell]()
    var buttonGradient: CAGradientLayer!
    
    override func viewDidLoad() {
        view.backgroundColor = .white

        
//        let newclass = Class(subject: "MATH", number: "6969", title: "Infinite foils & connected surfaces", description: "1,2,3,4 take more xannies and pour some more", term: ["Fall"], credits: 69, prerequisites: [])
//        coursesToDisplay.append(newclass)
//        coursesToDisplay.append(newclass)
//        coursesToDisplay.append(newclass)
        
        // Button for the MySchedule Tab
        fallButton = UIButton()
        fallButton.layer.cornerRadius = 32
        fallButton.setTitle("Fall", for: .normal)
        fallButton.titleLabel?.font = .systemFont(ofSize: 32)
        fallButton.setTitleColor(.black, for: .normal)
        fallButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        // Button for Settings Tab
        springButton = UIButton()
        springButton.layer.cornerRadius = 32
        springButton.setTitle("Spring", for: .normal)
        springButton.titleLabel?.font = .systemFont(ofSize: 32)
        springButton.setTitleColor(.black, for: .normal)
        springButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    
        
        // StackView for tabs at the top
        termsStackView = UIStackView(arrangedSubviews: [fallButton, springButton])
        termsStackView.axis = .horizontal
        termsStackView.distribution = .equalCentering
        
        //setBackgroundGradient(button: fallButton)
        
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
            make.width.equalTo(fallButton.intrinsicContentSize.width + 30)
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
    
    func setBackgroundGradient (button: UIButton) {
        print("tries to set gradient for \(button)")
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
                setBackgroundGradient(button: fallButton)
                fallButton.setTitleColor(.white, for: .normal)
            } else {
                fallButton.layer.sublayers![0].removeFromSuperlayer()
                fallButton.setTitleColor(.black, for: .normal)
            }
        }
        else if sender.titleLabel?.text == "Spring" {
            if springSelected {
                setBackgroundGradient(button: springButton)
                springButton.setTitleColor(.white, for: .normal)
            } else {
                springButton.layer.sublayers![0].removeFromSuperlayer()
                springButton.setTitleColor(.black, for: .normal)
            }
        }
        if (fallSelected && springSelected) {sharedVars.searchTerm = "fall and spring"}
        else if fallSelected {sharedVars.searchTerm = "fall"}
        else if springSelected {sharedVars.searchTerm = "spring"}
        else {sharedVars.searchTerm = ""}
        print(sharedVars.searchTerm)
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








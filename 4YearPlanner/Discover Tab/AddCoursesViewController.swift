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

class AddCoursesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, networksDelegate {
    
    func reloadCourses() {
        print("successful call")
        addCoursesCollectionView.reloadData()
    }
    
    var addCoursesCollectionView: UICollectionView!
    var addcourseReuseIdentifier = "addcourseReuseIdentiyer"
    
    var delegate: addCoursesDelegate?
    var termsStackView: UIStackView!
    var fallButton: UIButton!
    var springButton: UIButton!
    var recommendedButton: UIButton!
    var allCoursesButton: UIButton!
    var fallSelected = false
    var springSelected = false
    
    var courses = [Class]()
    var buttonGradient: CAGradientLayer!
    
    override func viewDidLoad() {
        view.backgroundColor = aesthetics.backgroundColor
        Network.delegate = self
        
        // Fall Button
        fallButton = UIButton()
        fallButton.layer.cornerRadius = fallButton.intrinsicContentSize.height/2
        fallButton.setTitle("Fall", for: .normal)
        fallButton.titleLabel?.font = .systemFont(ofSize: 32)
        fallButton.setTitleColor(aesthetics.textColor, for: .normal)
        fallButton.layer.borderWidth = 2
        fallButton.layer.borderColor = aesthetics.termColor.cgColor
        fallButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        print(fallButton.intrinsicContentSize.height)
        
        // Spring button
        springButton = UIButton()
        springButton.layer.cornerRadius = springButton.intrinsicContentSize.height/2
        springButton.setTitle("Spring", for: .normal)
        springButton.titleLabel?.font = .systemFont(ofSize: 32)
        springButton.setTitleColor(aesthetics.textColor, for: .normal)
        springButton.layer.borderWidth = 2
        springButton.layer.borderColor = aesthetics.termColor.cgColor
        springButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        // StackView for buttons
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
        addCoursesCollectionView.backgroundColor = aesthetics.backgroundColor
        
        view.addSubview(termsStackView)
        view.addSubview(addCoursesCollectionView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        // terms stack
        termsStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(aesthetics.smallGap)
            make.leading.equalToSuperview().offset(80)
            make.trailing.equalToSuperview().offset(-80)
            make.height.equalTo(51)
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
            make.top.equalTo(termsStackView.snp.bottom).offset(aesthetics.smallGap)
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
    
    // Change classes based on filter
    @objc func buttonPressed (sender:UIButton) {
        switchSelected(s: (sender.titleLabel?.text)!)
        if sender.titleLabel?.text == "Fall" {
            if fallSelected {
                fallButton.backgroundColor = aesthetics.termColor
                fallButton.setTitleColor(aesthetics.opposite(color: aesthetics.textColor), for: .normal)
            } else {
                fallButton.backgroundColor = aesthetics.backgroundColor
                fallButton.setTitleColor(aesthetics.textColor, for: .normal)
            }
        }
        else if sender.titleLabel?.text == "Spring" {
            if springSelected {
                springButton.backgroundColor = aesthetics.termColor
                springButton.setTitleColor(aesthetics.opposite(color: aesthetics.textColor), for: .normal)
            } else {
                springButton.backgroundColor = aesthetics.backgroundColor
                springButton.setTitleColor(aesthetics.textColor, for: .normal)
            }
        }
        if (fallSelected && springSelected) {sharedVars.searchTerm = "fall and spring"}
        else if fallSelected {sharedVars.searchTerm = "fall"}
        else if springSelected {sharedVars.searchTerm = "spring"}
        else {sharedVars.searchTerm = ""}
        Network.getCourses { (courses) in
            print(courses)
        }
        addCoursesCollectionView.reloadData()
    }
    
    // Helper function for switching filter
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

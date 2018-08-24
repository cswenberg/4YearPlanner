//
//  FiltersViewController.swift
//  4YearPlanner
//
//  Created by Conner Swenberg on 8/24/18.
//  Copyright © 2018 Conner Swenberg. All rights reserved.
//

import UIKit
import SnapKit
protocol filtersDelegate {
    func removeBlurView()
}
class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sectionHeaders = ["Terms", "Selections"]
    var allFilters = [["Fall", "Spring"], ["Recommended", "All"]]
    var selectedFilters = sharedVars.selectedFilters
    var filtersCellReuseIdentifier = "filterCell"
    var fallSelected = sharedVars.selectedFilters.contains("Fall")
    var springSelected = sharedVars.selectedFilters.contains("Spring")
    
    var delegate: filtersDelegate?
    var filtersTitle: UILabel!
    var filtersTableView: UITableView!
    var returnButton: UIButton!
    var applyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filtersTitle = UILabel()
        filtersTitle.text = "Filters"
        filtersTitle.font = .systemFont(ofSize: 28)
        filtersTitle.textColor = .white
        filtersTitle.numberOfLines = 0
        filtersTitle.textAlignment = .left
        filtersTitle.alpha = 0
        
        filtersTableView = UITableView.init(frame: CGRect(x: 10, y: filtersTitle.intrinsicContentSize.height+80, width: self.view.frame.size.width, height: self.view.frame.size.height-filtersTitle.intrinsicContentSize.height-80), style: .grouped)
        filtersTableView.delegate = self
        filtersTableView.dataSource = self
        filtersTableView.estimatedRowHeight = 52
        filtersTableView.rowHeight = UITableViewAutomaticDimension
        filtersTableView.register(FiltersTableViewCell.self, forCellReuseIdentifier: filtersCellReuseIdentifier)
        filtersTableView.backgroundColor = .clear
        filtersTableView.backgroundView = nil
        filtersTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        returnButton = UIButton()
        returnButton.layer.cornerRadius = 16
        returnButton.setTitle("<", for: .normal)
        returnButton.titleLabel?.font = aesthetics.tabsFont
        returnButton.setTitleColor(.white, for: .normal)
        returnButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        returnButton.bounds = returnButton.frame
        returnButton.alpha = 0
        
        applyButton = UIButton()
        applyButton.layer.cornerRadius = 16
        applyButton.setTitle("Apply", for: .normal)
        applyButton.titleLabel?.font = aesthetics.tabsFont
        applyButton.setTitleColor(.white, for: .normal)
        applyButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        applyButton.bounds = returnButton.frame
        applyButton.alpha = 0
        
        view.addSubview(filtersTableView)
        view.addSubview(filtersTitle)
        view.addSubview(returnButton)
        view.addSubview(applyButton)
        
        setupFiltersConstraints()
    }
    
    func setupFiltersConstraints () {
        //Filters title label
        filtersTitle.snp.makeConstraints{ (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(aesthetics.topOffset)
            make.width.equalTo(filtersTitle.intrinsicContentSize.width)
        }
        //Filters Tableview
        filtersTableView.snp.makeConstraints { (make) in
            make.top.equalTo(filtersTitle.snp.bottom).offset(aesthetics.topOffset)
            make.leading.equalToSuperview().offset(aesthetics.smallGap)
            make.trailing.bottom.equalToSuperview().offset(-aesthetics.smallGap)
        }
        //return button
        returnButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(aesthetics.smallGap)
            make.top.equalTo(filtersTitle.snp.top)
            make.width.equalTo(returnButton.intrinsicContentSize.width)
        }
        //apply button
        applyButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-aesthetics.smallGap)
            make.top.equalTo(filtersTitle.snp.top)
            make.width.equalTo(applyButton.intrinsicContentSize.width)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return allFilters.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFilters[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = filtersTableView.dequeueReusableCell(withIdentifier: filtersCellReuseIdentifier) as! FiltersTableViewCell
        cell.filterTitle.text = allFilters[indexPath.section][indexPath.row]
        if (selectedFilters.contains(cell.filterTitle.text!)) {
            cell.accessoryType = .checkmark
        }
        cell.setNeedsUpdateConstraints()
        
        UIView.animate(withDuration: 0.5) {
            cell.filterTitle.alpha = 1
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = filtersTableView.cellForRow(at: indexPath) as! FiltersTableViewCell
        if (!selectedFilters.contains(cell.filterTitle.text!)) {
            selectedFilters.append(cell.filterTitle.text!)
            cell.accessoryType = .checkmark
        } else {
            selectedFilters.remove(at: selectedFilters.index(of: cell.filterTitle.text!)!)
            cell.accessoryType = .none
        }
        switchSelected(s: cell.filterTitle.text!)
        filtersTableView.deselectRow(at: indexPath, animated: false)
        cell.setNeedsUpdateConstraints()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height:44))
        
        let headerTitle = UILabel()
        headerTitle.text = self.sectionHeaders[section]
        headerTitle.textColor = .white
        headerTitle.font = .systemFont(ofSize: 20)
        
        headerView.addSubview(headerTitle)
        
        headerTitle.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(headerTitle.intrinsicContentSize.width)
            make.height.equalTo(headerTitle.intrinsicContentSize.height)
        }
        
        headerView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            headerView.alpha = 1
        }
        
        print(headerView.frame.size.height)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    @objc func buttonPressed(sender: UIButton) {
        if (sender == returnButton) {
            self.dismiss(animated: false, completion: nil)
            delegate?.removeBlurView()
            
        } else if (sender == applyButton) {
            sharedVars.selectedFilters = selectedFilters
            Network .getCourses { (courses) in
                self.delegate?.removeBlurView()
            }
        }
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
        if (fallSelected && springSelected) {sharedVars.searchTerm = "fall and spring"}
        else if fallSelected {sharedVars.searchTerm = "fall"}
        else if springSelected {sharedVars.searchTerm = "spring"}
        else {sharedVars.searchTerm = ""}
    }
}

//
//  SummaryTableView.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 07/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import UIKit

class SummaryTableView: UIView {

    // IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // Expand
    fileprivate var expandedSectionIndex = 0
    
    // TableViewCell Identifier
    fileprivate let cellIdentifier = String(describing: SummaryListTableViewCell.self)
    
    // Header Identifier
    fileprivate let headerIdentifier = String(describing: SummaryHeaderView.self)
    
    // Number of Header array
    fileprivate let arrSectionHeaderText: [String] = ["Details", "History", "Mass", "Vitals", "RACE", "18G IV"]
    
    // Override awake from nib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set fake footer to table view (this will remove useless empty rows)
        self.tableView.tableFooterView = UIView()
        
        // Set top inset
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        // Register UITableViewCell
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
        
        // Register Header
        let poiListTableViewHeader = UINib(nibName: headerIdentifier, bundle: nil)
        self.tableView.register(poiListTableViewHeader, forHeaderFooterViewReuseIdentifier: headerIdentifier)
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
    }
}

// MARK: UITableViewDataSource + UITableViewDelegate
extension SummaryTableView: UITableViewDataSource, UITableViewDelegate {
    
    // Number of section
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionedItems.count
    }
    
    // Header view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as! SummaryHeaderView
        header.lblHeaderTitle.text = sectionedItems[section].title
        header.btnExpandCollepse.isSelected = false
        
        if section == expandedSectionIndex {
            header.btnExpandCollepse.isSelected = true
        }
        
        header.btnExpandCollepse.tag = section
        header.btnExpandCollepse.addTarget(self, action: #selector(btnExpandClicked), for: .touchUpInside)
        return header
    }
    
    @objc fileprivate func btnExpandClicked(sender: UIButton) {
        
        expandedSectionIndex = sender.tag
        self.tableView.reloadData()
    }
    
    /// Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if expandedSectionIndex == section {
            return sectionedItems[section].sectionedValues.count
        }
        return 0
    }
    
    /// Cell for row at index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SummaryListTableViewCell
        cell.cellValue = sectionedItems[indexPath.section].sectionedValues[indexPath.row]
        return cell
    }
    
    /// Did select row at index path
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

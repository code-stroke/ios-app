//
//  SummaryListTableViewCell.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 07/10/18.
//  Copyright © 2018 Jayesh Mardiya. All rights reserved.
//

import UIKit

class CellValues {
    
    var title: String       = ""
    var value: String       = ""
}

class SummaryListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    
    var cellValue: CellValues? {
        didSet {
            self.rxSetup()
        }
    }
    
    fileprivate func rxSetup() {
        
        guard let cellItem = self.cellValue else { return }
        self.lblTitle.text = cellItem.title
        self.lblValue.text = cellItem.value
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

//
//  LogTableViewCell.swift
//  Location Log
//
//  Created by Quang Minh Trinh on 2/23/16.
//  Copyright © 2016 Quang Minh Trinh. All rights reserved.
//

import UIKit

class LogTableViewCell: UITableViewCell {

    // MARK: - IBOutlet

    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var dateLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}

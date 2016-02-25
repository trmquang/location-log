//
//  LogDetailTableViewCell.swift
//  Location Log
//
//  Created by Quang Minh Trinh on 2/24/16.
//  Copyright © 2016 Quang Minh Trinh. All rights reserved.
//

import UIKit

class LogDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    /** Reload data after awake from nib */
    func reloadData() {
        
    }
    
}

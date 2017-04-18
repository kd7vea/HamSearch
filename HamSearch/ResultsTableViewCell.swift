//
//  ResultsTableViewCell.swift
//  HamSearch
//
//  Created by Jake Estepp on 4/16/17.
//  Copyright © 2017 Jake Estepp. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var staticLabel: UILabel!
    @IBOutlet weak var resultsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

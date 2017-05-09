//
//  LeagueTableViewCell.swift
//  Turnir
//
//  Created by Adam Gorkoz on 25/11/2016.
//  Copyright © 2016 Adam Gorkoz. All rights reserved.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var spotLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBOutlet weak var diffLabel: UILabel!
    
    @IBOutlet weak var matchesLabel: UILabel!
    
    var isColorSet: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

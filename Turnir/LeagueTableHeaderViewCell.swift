//
//  LeagueTableHeaderViewCell.swift
//  Turnir
//
//  Created by Adam Gorkoz on 27/11/2016.
//  Copyright © 2016 Adam Gorkoz. All rights reserved.
//

import UIKit

class LeagueTableHeaderViewCell: UITableViewCell {

    
    @IBOutlet weak var playedLabel: UILabel!
    
    @IBOutlet weak var diffLabel: UILabel!
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

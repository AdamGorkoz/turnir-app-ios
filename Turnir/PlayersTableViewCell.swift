//
//  PlayersTableViewCell.swift
//  Turnir
//
//  Created by Adam Gorkoz on 09/05/2017.
//  Copyright © 2017 Adam Gorkoz. All rights reserved.
//

import UIKit

class PlayersTableViewCell: UITableViewCell {

    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    
    @IBOutlet weak var goalsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

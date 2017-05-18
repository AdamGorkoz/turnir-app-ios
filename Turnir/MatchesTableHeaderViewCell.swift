//
//  MatchesTableHeaderViewCell.swift
//  Turnir
//
//  Created by Adam Gorkoz on 18/05/2017.
//  Copyright © 2017 Adam Gorkoz. All rights reserved.
//

import UIKit

class MatchesTableHeaderViewCell: UITableViewCell {

    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var opponentLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

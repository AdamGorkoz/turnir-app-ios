//
//  MessagesTableViewCell.swift
//  Turnir
//
//  Created by Adam Gorkoz on 19/11/2016.
//  Copyright © 2016 Adam Gorkoz. All rights reserved.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!

    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

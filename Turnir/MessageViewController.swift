//
//  DetailViewController.swift
//  Turnir
//
//  Created by Adam Gorkoz on 11/11/2016.
//  Copyright © 2016 Adam Gorkoz. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    
    @IBOutlet weak var messageTitleLabel: UILabel!
    
    @IBOutlet weak var messageDateLabel: UILabel!

    @IBOutlet weak var messageBodyLabel: UILabel!

    func configureView() {
        // Update the user interface for the detail item.
        if let message = self.detailItem {
            if let titleLabel = self.messageTitleLabel {
                titleLabel.text = message.title
            }
            if let bodyLabel = self.messageBodyLabel {
                bodyLabel.text = message.body
            }
            
            if let dateLabel = self.messageDateLabel{
                dateLabel.text = message.date
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: MessageModel? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }


}


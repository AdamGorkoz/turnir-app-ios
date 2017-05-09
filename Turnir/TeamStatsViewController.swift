//
//  TeamViewController.swift
//  Turnir
//
//  Created by Adam Gorkoz on 06/05/2017.
//  Copyright © 2017 Adam Gorkoz. All rights reserved.
//

import UIKit

class TeamStatsViewController: UIViewController {

    @IBOutlet weak var positionLabel: UILabel!
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBOutlet weak var matchesLabel: UILabel!
    
    @IBOutlet weak var winsLabel: UILabel!
    
    @IBOutlet weak var drawsLabel: UILabel!
    
    @IBOutlet weak var lossesLabel: UILabel!
    
    @IBOutlet weak var goalsLabel: UILabel!
    
    @IBOutlet weak var diffLabel: UILabel!
    
    var currentTeam: LeagueTeamModel? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the current team.
        if let team = self.currentTeam {
            if let positionLabel = self.positionLabel {
                positionLabel.text = ((currentTeam?.position)! + 1).description
            }
            if let pointsLabel = self.pointsLabel {
                pointsLabel.text = team.points.description
            }
            if let matchesLabel = self.matchesLabel {
                matchesLabel.text = team.matches.description
            }
            if let winsLabel = self.winsLabel {
                winsLabel.text = team.wins.description
            }
            if let drawsLabel = self.drawsLabel {
                drawsLabel.text = team.draws.description
            }
            if let lossesLabel = self.lossesLabel {
                lossesLabel.text = team.losses.description
            }
            if let goalsLabel = self.goalsLabel {
                goalsLabel.text = team.goals.description
            }
            if let diffLabel = self.diffLabel {
                diffLabel.text = team.diff.description
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

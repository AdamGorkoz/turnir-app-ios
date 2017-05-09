//
//  TeamPlayersTableViewController.swift
//  Turnir
//
//  Created by Adam Gorkoz on 07/05/2017.
//  Copyright © 2017 Adam Gorkoz. All rights reserved.
//

import UIKit

class TeamPlayersTableViewController: UITableViewController {

    var teamPlayers = [PlayerModel]()
    
    var currentTeamId: Int? {
        didSet {
            // Update the view.
            self.fetchTeamPlayers()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.refreshControl?.addTarget(self, action: #selector(TeamPlayersTableViewController.handleRefresh), for: UIControlEvents.valueChanged)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        self.tableView.contentOffset = CGPoint(x: 0, y: -1 * (self.tableView.refreshControl?.frame.size.height)!)
        self.tableView.refreshControl?.layoutIfNeeded()
        self.tableView.refreshControl?.beginRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleRefresh(){
        fetchTeamPlayers()
    }
    
    private func fetchTeamPlayers(){
        if(currentTeamId != nil){
            var request = URLRequest(url: URL(string: "http://adiga-mundial.com/rest/team/\(self.currentTeamId!.description)/profile/players")!)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                self.teamPlayers.removeAll()
                if let array = json as? [Any] {
                    for object in array {
                        self.teamPlayers.append(PlayerModel(json: object as! [String : Any])!)
                    }
                }
                self.teamPlayers = self.teamPlayers.sorted(by: { (playerA: PlayerModel, playerB: PlayerModel) -> Bool in
                    return playerA.goals > playerB.goals
                })
                DispatchQueue.main.async {
                    self.tableView.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                }
            }
            task.resume()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.teamPlayers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersIdentifier", for: indexPath) as! PlayersTableViewCell
        
        if indexPath.row % 2 == 0{
            cell.contentView.backgroundColor = UIColor(red: 236.0/250, green: 239.0/250, blue: 241.0/250, alpha: 1.0)
        }
        else{
            cell.contentView.backgroundColor = UIColor.white
        }
        
        let player = teamPlayers[indexPath.row]
        
        cell.playerNameLabel?.text = player.name
        cell.goalsLabel?.text = player.goals.description
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "PlayersHeaderIdentifier") as! PlayersTableHeaderViewCell
        headerCell.backgroundColor = UIColor.white
        return headerCell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 40.0
    }

}

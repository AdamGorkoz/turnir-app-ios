//
//  MatchesViewController.swift
//  Turnir
//
//  Created by Adam Gorkoz on 18/05/2017.
//  Copyright © 2017 Adam Gorkoz. All rights reserved.
//

import UIKit

class TeamMatchesTableViewController: UITableViewController {

    var teamMatches = [MatchModel]()
    
    var currentTeamId: Int? {
        didSet {
            self.fetchTeamMatches()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.refreshControl?.addTarget(self, action: #selector(TeamMatchesTableViewController.handleRefresh), for: UIControlEvents.valueChanged)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        self.tableView.contentOffset = CGPoint(x: 0, y: -1 * (self.tableView.refreshControl?.frame.size.height)!)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
        self.tableView.refreshControl?.layoutIfNeeded()
        self.tableView.refreshControl?.beginRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func handleRefresh(){
        fetchTeamMatches()
    }
    
    private func fetchTeamMatches(){
        if(currentTeamId != nil){
            var request = URLRequest(url: URL(string: "http://adiga-mundial.com/rest/team/\(self.currentTeamId!.description)/history")!)
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
                self.teamMatches.removeAll()
                if let array = json as? [Any] {
                    for object in array {
                        self.teamMatches.append(MatchModel(json: object as! [String : Any])!)
                    }
                }
//                self.teamMatches = self.teamPlayers.sorted(by: { (matchA: MatchModel, matchB: MatchModel) -> Bool in
//                    return matchA.d.goals > playerB.goals
//                })
                DispatchQueue.main.async {
                    self.tableView.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                }
            }
            task.resume()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teamMatches.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchesIdentifier", for: indexPath) as! MatchesTableViewCell
        
        if indexPath.row % 2 == 0{
            cell.contentView.backgroundColor = UIColor(red: 236.0/250, green: 239.0/250, blue: 241.0/250, alpha: 1.0)
        }
        else{
            cell.contentView.backgroundColor = UIColor.white
        }
        
        let match = teamMatches[indexPath.row]
        
        cell.dateLabel?.text = match.date
        cell.opponentLabel?.text = match.opponent
        cell.scoreLabel?.text = match.score
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "MatchesHeaderIdentifier") as! MatchesTableHeaderViewCell
        headerCell.backgroundColor = UIColor.white
        return headerCell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 40.0
    }

}

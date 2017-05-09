//
//  LeagueViewController.swift
//  Turnir
//
//  Created by Adam Gorkoz on 25/11/2016.
//  Copyright © 2016 Adam Gorkoz. All rights reserved.
//

import UIKit

class LeagueViewController: UITableViewController {

    var leagueTeams = [LeagueTeamModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl?.addTarget(self, action: #selector(LeagueViewController.handleRefresh), for: UIControlEvents.valueChanged)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        self.tableView.contentOffset = CGPoint(x: 0, y: -1 * (self.tableView.refreshControl?.frame.size.height)!)
        self.tableView.refreshControl?.layoutIfNeeded()
        self.tableView.refreshControl?.beginRefreshing()
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(leagueTeams.isEmpty){
            fetchLeagueTeams()
        }
    }
    
    func handleRefresh(){
        fetchLeagueTeams()
    }
    
    private func fetchLeagueTeams(){
        var request = URLRequest(url: URL(string: "http://adiga-mundial.com/rest/league")!)
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
            self.leagueTeams.removeAll()
            if let array = json as? [Any] {
                for object in array {
                    self.leagueTeams.append(LeagueTeamModel(json: object as! [String : Any])!)
                }
            }
            self.leagueTeams = self.leagueTeams.sorted(by: { (teamA: LeagueTeamModel, teamB: LeagueTeamModel) -> Bool in
                if teamA.points > teamB.points{
                    return true
                }
                else if teamA.points == teamB.points{
                    return teamA.diff >= teamB.diff
                }
                return false
            })
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "teamSegue" ,
           let nextScene = segue.destination as? TeamPageViewController,
            let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedTeam = leagueTeams[indexPath.row]
            selectedTeam.position = indexPath.row
            nextScene.currentTeam = selectedTeam
        }
    }
 
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagueTeams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueTeamIdentifier", for: indexPath) as! LeagueTableViewCell
        
        if indexPath.row % 2 == 0{
            cell.contentView.backgroundColor = UIColor(red: 236.0/250, green: 239.0/250, blue: 241.0/250, alpha: 1.0)
        }
        else{
            cell.contentView.backgroundColor = UIColor.white
        }
        
        let leagueTeam = leagueTeams[indexPath.row]
        
        cell.spotLabel?.text = (indexPath.row + 1).description
        cell.nameLabel?.text = leagueTeam.name
        cell.matchesLabel?.text = leagueTeam.matches.description
        cell.diffLabel?.text = leagueTeam.goals
        cell.pointsLabel?.text = leagueTeam.points.description
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "LeagueTeamHeaderIdentifier") as! LeagueTableHeaderViewCell
        headerCell.backgroundColor = UIColor.white
        return headerCell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 40.0
    }

}

//
//  MasterViewController.swift
//  Turnir
//
//  Created by Adam Gorkoz on 11/11/2016.
//  Copyright © 2016 Adam Gorkoz. All rights reserved.
//

import UIKit

class MessagesViewController: UITableViewController {

    var messsagesViewController: MessagesViewController? = nil
    var messages = [MessageModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.view.backgroundColor = UIColor.white
        self.refreshControl?.addTarget(self, action: #selector(MessagesViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        self.tableView.contentOffset = CGPoint(x: 0, y: -1 * (self.tableView.refreshControl?.frame.size.height)!)
        self.tableView.refreshControl?.layoutIfNeeded()
        self.tableView.refreshControl?.beginRefreshing()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(messages.isEmpty){
            fetchMessages()
        }
    }
    
    func handleRefresh(_ sender: Any){
        fetchMessages()
    }
    
    private func fetchMessages(){
        var request = URLRequest(url: URL(string: "http://adiga-mundial.com/rest/message")!)
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
            self.messages.removeAll()
            if let array = json as? [Any] {
                for object in array {
                    self.messages.append(MessageModel(json: object as! [String : Any])!)
                }
            }
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMessage" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = messages[indexPath.row]
                let controller = segue.destination as! MessageViewController
                controller.detailItem = object
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageIdentifier", for: indexPath) as! MessagesTableViewCell

        let message = messages[indexPath.row]
        
        cell.titleLabel?.text = message.title
        cell.bodyLabel?.text = message.body
        cell.dateLabel?.text = message.date
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }



}


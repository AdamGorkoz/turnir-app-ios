//
//  PlayerModel.swift
//  Turnir
//
//  Created by Adam Gorkoz on 09/05/2017.
//  Copyright © 2017 Adam Gorkoz. All rights reserved.
//

import Foundation

class PlayerModel {
    
    var name: String
    var goals: Int
    
    init(name: String, goals: Int) {
        self.name = name
        self.goals = goals
    }
    
    init?(json: [String: Any]){
        guard let currentName = json["Name"] as? String,
            let currentGoals = json["Goals"] as? Int
            else{
                return nil
        }
        self.name = currentName
        self.goals = currentGoals
    }
}

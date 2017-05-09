//
//  LeagueModel.swift
//  Turnir
//
//  Created by Adam Gorkoz on 25/11/2016.
//  Copyright © 2016 Adam Gorkoz. All rights reserved.
//

import Foundation

class LeagueTeamModel {
    
    var id: Int
    var position: Int
    var name: String
    var points: Int
    var matches: Int
    var diff: Int
    var wins: Int
    var losses: Int
    var draws: Int
    var goals: String
    
    init(id: Int, position: Int, name: String, points: Int, matches: Int, diff: Int, wins: Int, draws: Int, losses: Int, goals: String){
        self.id = id
        self.position = position
        self.name = name
        self.points = points
        self.matches = matches
        self.diff = diff
        self.wins = wins
        self.draws = draws
        self.losses = losses
        self.goals = goals
    }
    
    init?(json: [String: Any]){
        guard let currentID = json["ID"] as? Int,
            let currentName = json["Name"] as? String,
            let currentPoints = json["Points"] as? Int,
            let currentDiff = json["Diff"] as? Int,
            let currentMatches = json["Matches"] as? Int,
            let currentWins = json["Wins"] as? Int,
            let currentDraws = json["Draws"] as? Int,
            let currentLosses = json["Losses"] as?  Int,
            let currentGoals = json["Goals"] as? String
            else{
                return nil
        }
        self.id = currentID
        self.position = 0
        self.name = currentName
        self.points = currentPoints
        self.matches = currentMatches
        self.diff = currentDiff
        self.wins = currentWins
        self.draws = currentDraws
        self.losses = currentLosses
        self.goals = currentGoals
    }
}

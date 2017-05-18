//
//  MatchModel.swift
//  Turnir
//
//  Created by Adam Gorkoz on 18/05/2017.
//  Copyright © 2017 Adam Gorkoz. All rights reserved.
//

import Foundation

class MatchModel {
    
    var date: String
    var opponent: String
    var score: String
    var matchOutcome: Int
    
    init(date: String, opponent: String, score: String, matchOutcome: Int) {
        self.date = date
        self.opponent = opponent
        self.score = score
        self.matchOutcome = matchOutcome
    }
    
    init?(json: [String: Any]){
        guard let currentDate = json["MatchDate"] as? String,
            let currentOpponent = json["Opponent"] as? String,
            let currentScore = json["Score"] as? String,
            let currentMatchOutcome = json["MatchOutcome"] as? Int
            else{
                return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let nsDate = dateFormatter.date(from: currentDate)
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.date = dateFormatter.string(from: nsDate!)
        self.opponent = currentOpponent
        self.score = currentScore
        self.matchOutcome = currentMatchOutcome
    }
}

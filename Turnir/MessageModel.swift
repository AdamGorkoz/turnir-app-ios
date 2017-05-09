//
//  MessageModel.swift
//  Turnir
//
//  Created by Adam Gorkoz on 19/11/2016.
//  Copyright © 2016 Adam Gorkoz. All rights reserved.
//

import Foundation


class MessageModel {
    
    var title: String
    var body: String
    var date: String
    
    init(title: String, body: String, date: String) {
        self.title = title
        self.body = body
        self.date = date
    }
    
    init?(json: [String: Any]){
        guard let currentTitle = json["Title"] as? String,
              let currentBody = json["Body"] as? String,
              let currentDate = json["CreationDate"] as? String
            else{
                return nil
            }
        self.title = currentTitle
        self.body = currentBody
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let nsDate = dateFormatter.date(from: currentDate)
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.date = dateFormatter.string(from: nsDate!)
    }
}

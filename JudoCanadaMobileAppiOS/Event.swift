//
//  Event.swift
//  JudoCanadaMobileAppiOS
//
//  Created by Louis-Simon Poulin on 2018-06-06.
//  Copyright © 2018 Louis-Simon Poulin. All rights reserved.
//

import Foundation
import ObjectMapper


struct Event:Mappable{
    var id:String?
    var dateStart:Date?
    var dateEnd:Date?
    var url:String?
    var summary:String?
    
    init(){}
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["uid"]
        url <- map["url"]
        summary <- map["summary"]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        if let dateString = map["dtstart"].currentValue as? String, let _date = dateFormatter.date(from: dateString) {
            dateStart = _date
        }
        if let dateString = map["dtend"].currentValue as? String, let _date = dateFormatter.date(from: dateString) {
            dateEnd = _date
        }
    }
}


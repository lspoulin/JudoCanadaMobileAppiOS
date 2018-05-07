//
//  Post.swift
//  JudoCanadaMobileAppiOS
//
//  Created by Louis-Simon Poulin on 2018-05-07.
//  Copyright © 2018 Louis-Simon Poulin. All rights reserved.
//

import Foundation
import ObjectMapper

struct Post:Mappable {
    var id:Int = 0
    var date:String = ""
    var dateGMT:String = ""
    var title:String = ""
    var content:String = ""
    var exerpt:String = ""
    
    init(){
        
    }
    
    init?(map: Map) {
       id <- map["id"]
        title    <- map["title.rendered"]
        content <- map["content.rendered"]
        exerpt <- map["exerpt.rendered"]
        date <- map["date"]
        dateGMT <- map["date_gmt"]
    }
    
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title    <- map["title.rendered"]
        content <- map["content.rendered"]
        exerpt <- map["exerpt.rendered"]
        date <- map["date"]
        dateGMT <- map["date_gmt"]
        
    }
}


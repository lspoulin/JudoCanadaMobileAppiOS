//
//  Video.swift
//  JudoCanadaMobileAppiOS
//
//  Created by Louis-Simon Poulin on 2018-05-09.
//  Copyright © 2018 Louis-Simon Poulin. All rights reserved.
//

import Foundation
import ObjectMapper


struct Video:Mappable{
    var id:String?
    var title:String?

    init(){}
    init?(map: Map) {
        id <- map["id"]
        title    <- map["title"]
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title    <- map["title"]
    }
}

struct VideoList:Mappable{
    var page:Int?
    var limit:Int?
    var hasMore:Bool?
    var videos:[Video]?
    
    init(){
        videos = [Video]()
    }
    
    init?(map: Map) {
        page <- map["page"]
        limit    <- map["limit"]
        hasMore <- map["hasMore"]
        videos    <- map["list"]
    }
    
    mutating func mapping(map: Map) {
        page <- map["page"]
        limit    <- map["limit"]
        hasMore <- map["hasMore"]
        videos    <- map["list"]
    }
    
}

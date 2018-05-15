//
//  User.swift
//  JudoCanadaMobileAppiOS
//
//  Created by Louis-Simon Poulin on 2018-05-07.
//  Copyright © 2018 Louis-Simon Poulin. All rights reserved.
//

import Foundation
import ObjectMapper

struct User:Mappable {
    var id:Int = 0
    var name:String = ""
    var firstname:String = ""
    var email:String = ""
    
    init(){
        
    }
    
    init?(map: Map) {
        id <- map["id"]
        name    <- map["name"]
        firstname <- map["firstname"]
        email <- map["email"]
    }
    
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name    <- map["name"]
        firstname <- map["firstname"]
        email <- map["email"]
    }
}


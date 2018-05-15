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
    private let GET_URL_RE:String = "(http|ftp|https):[/][/]([\\w_-]+(?:(?:\\.[\\w_-]+)+))([\\w.,@?^=%&:/~+#-]*[\\w@?^=%&/~+#-])?"
    private let IS_IMAGE_RE:String = "^[^?]*\\.(jpg|jpeg|gif|png)";
    private let REMOVE_AHREF:String = "<a.*?</a>";
    
    var id:Int = 0
    var date:String = ""
    var dateGMT:String = ""
    var title:String = ""
    var content:String = ""
    var excerpt:String = ""
    var imageList:[String] = [String]()
    
    init(){
        
    }
    
    init?(map: Map) {
       id <- map["id"]
        title    <- map["title.rendered"]
        content <- map["content.rendered"]
        excerpt <- map["excerpt.rendered"]
        date <- map["date"]
        dateGMT <- map["date_gmt"]
    }
    
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title    <- map["title.rendered"]
        content <- map["content.rendered"]
        excerpt <- map["excerpt.rendered"]
        date <- map["date"]
        dateGMT <- map["date_gmt"]
        
        for url:String in matches(for: GET_URL_RE, in: content){
            if url.matches(IS_IMAGE_RE){
                imageList.append(url)
            }
        }
        
    }
    
    func matches(for regex: String, in text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    
}
extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}


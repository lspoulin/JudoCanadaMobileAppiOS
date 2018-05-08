//
//  ApiHelper.swift
//  JudoCanadaMobileAppiOS
//
//  Created by Louis-Simon Poulin on 2018-05-08.
//  Copyright © 2018 Louis-Simon Poulin. All rights reserved.
//

import Foundation

class ApiHelper{
    private var apiManagerPost:ApiManager<Post>?
    
    init(){
        apiManagerPost = ApiManager<Post>()
    }
    
    public func getPosts(completion: @escaping ( _ mappable:Any) -> ()){
        guard let api:ApiManager<Post> = apiManagerPost else  {return}
        api.getMappableArray(getURL: (api.geAllPostsURL())!, completion:completion )
        
    }
}

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
    private var apiManagerVideo:ApiManager<VideoList>?
    
    init(){
        apiManagerPost = ApiManager<Post>()
        apiManagerVideo = ApiManager<VideoList>()
    }
    
    public func getPosts(completion: @escaping ( _ mappable:Any) -> ()){
        guard let api:ApiManager<Post> = apiManagerPost else  {return}
        api.getMappableArray(getURL: (api.geAllPostsURL())!, completion:completion )
        
    }
    
    public func getVideos(completion: @escaping ( _ mappable:Any) -> ()){
        guard let api:ApiManager<VideoList> = apiManagerVideo else  {return}
        api.getMappable(getURL: (api.getVideoList())!, completion:completion )
        
    }
}

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
    private var apiManagerUser:ApiManager<User>?
    
    init(){
        apiManagerPost = ApiManager<Post>()
        apiManagerVideo = ApiManager<VideoList>()
        apiManagerUser = ApiManager<User>()
    }
    
    public func getPosts(completion: @escaping ( _ mappable:Any) -> ()){
        guard let api:ApiManager<Post> = apiManagerPost else  {return}
        api.getMappableArray(getURL: (api.geAllPostsURL())!, completion:completion )
        
    }
    
    public func getVideos(completion: @escaping ( _ mappable:Any) -> ()){
        guard let api:ApiManager<VideoList> = apiManagerVideo else  {return}
        api.getMappable(getURL: (api.getVideoList())!, completion:completion )
        
    }
    
    public func getUsers(completion: @escaping ( _ mappable:Any) -> ()){
        guard let api:ApiManager<User> = apiManagerUser else  {return}
        api.getMappableArray(getURL: (api.getUsers())!, completion:completion )
    }
}

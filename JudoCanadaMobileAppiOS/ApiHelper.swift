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
    private var apiManagerEvent:ApiManager<Event>?
    
    init(){
        apiManagerPost = ApiManager<Post>()
        apiManagerVideo = ApiManager<VideoList>()
        apiManagerUser = ApiManager<User>()
        apiManagerEvent = ApiManager<Event>()
    }
    
    public func getPosts(completion: @escaping ( _ mappable:Any) -> ()){
        guard let api:ApiManager<Post> = apiManagerPost else  {return}
        api.getMappableArray(getURL: (api.geAllPostsURL())!, completion:completion )
    }
    
    public func getVideos(completion: @escaping ( _ mappable:Any) -> ()){
        guard let api:ApiManager<VideoList> = apiManagerVideo else  {return}
        api.getMappable(getURL: (api.getVideoList())!, completion:completion )
    }
    
    public func getEvents(completion: @escaping ( _ mappable:Any) -> ()){
        guard let api:ApiManager<Event> = apiManagerEvent else  {return}
        api.getMappableArray(getURL: (api.getEvents())!, completion:completion )
    }
    
    public func getUsers(completion: @escaping ( _ mappable:Any) -> ()){
        guard let api:ApiManager<User> = apiManagerUser else  {return}
        api.getMappableArray(getURL: (api.getUsers())!, completion:completion )
    }
    
    public func createUser(completion: @escaping ( _ mappable:Any) -> ()){
        guard let api:ApiManager<User> = apiManagerUser else  {return}
        api.postMappable(postURL: api.getUsers()!, parameters: ["":"" as AnyObject], completion: completion)
    }
}

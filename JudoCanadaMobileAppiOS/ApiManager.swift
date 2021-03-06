//
//  ApiManager.swift
//  JudoCanadaMobileAppiOS
//
//  Created by Louis-Simon Poulin on 2018-05-07.
//  Copyright © 2018 Louis-Simon Poulin. All rights reserved.
//


import Foundation
import Alamofire
import ObjectMapper

let getPostEndpoint = "posts"
let getVideoEndPoint = "user/JudoCanada/videos"
let getUserEndPoint = "users/"
let getThumbnailEndPoint = "thumbnail/video/"
let getEventEndPoint = "events/"
let getProductEndPoint = "products/"

class ApiManager<M:Mappable>{
    
    public func geAllPostsURL() -> String?{
        if let value = ProcessInfo.processInfo.environment["BASE_URL"] {
            return value+getPostEndpoint
        }
        return ""
    }
    
    public func getVideoList() -> String?{
        if let value = ProcessInfo.processInfo.environment["VIDEO_BASE_URL"] {
            return value+getVideoEndPoint
        }
        return ""
    }
    
    public func getEvents() -> String?{
        if let value = ProcessInfo.processInfo.environment["USER_BASE_URL"] {
            let test = value+getEventEndPoint
            return test
        }
        return ""
    }
    
    public func getProductURL() -> String?{
        if let value = ProcessInfo.processInfo.environment["USER_BASE_URL"] {
            let test = value+getProductEndPoint
            return test
        }
        return ""
    }
    
    public func getUsers()->String?{
        if let value = ProcessInfo.processInfo.environment["USER_BASE_URL"] {
            return value+getUserEndPoint
        }
        return ""
    }
    
    public func postUser()->String?{
        if let value = ProcessInfo.processInfo.environment["USER_BASE_URL"] {
            return value+getUserEndPoint
        }
        return ""
    }
    
    public static func getThumbnailURL(id:String)->String?{
        if let value = ProcessInfo.processInfo.environment["THUMBNAIL_BASE_URL"] {
            return value+getThumbnailEndPoint+id
        }
        return ""
    }
    
    public func getMappable(getURL:String, completion: @escaping ( _ mappable:Any) -> ()){
        
        Alamofire.request(getURL).responseJSON { response in
            if response.error != nil{
                print("\(String(describing: response.error))")
                completion(AnyClass.self)
                return
            }
            if response.result.isSuccess {
                print("This is a success")
                guard let value  = response.value else {return}
            
                
                guard let mappableObject = Mapper<M>().map(JSONObject: value) else{
                    print("Not a mappable")
                    return
                }
                completion(mappableObject)
                return
            }
            else {
                print("Not a success")
            }
            completion(AnyClass.self)
        }
        
    }
    
    public func getMappableArray(getURL:String, completion: @escaping ( _ mappable:Any) -> ()){
        
        Alamofire.request(getURL).responseJSON { response in
            if response.error != nil{
                print("\(String(describing: response.error))")
                completion(AnyClass.self)
                return
            }
            if response.result.isSuccess {
                print("This is a success")
                guard let value  = response.value else {return}
                print(value as Any)
                var mappableObjects:[M] = [M]()
                let jsonWithArrayRoot = try? JSONSerialization.jsonObject(with: response.data!, options: [])
                guard let array = jsonWithArrayRoot as? [AnyObject] else { return }
                for json in array{
                    mappableObjects.append(Mapper<M>().map(JSONObject: json)!)
                }
                completion(mappableObjects)
                return
            }
            else {
                print("Not a success")
            }
             completion(AnyClass.self)
        }
       
    }
   public func postMappable(postURL:String, parameters: [String: AnyObject], completion: @escaping ( _ mappable:Any) -> ()){
        Alamofire.request(postURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
            }
        }

}

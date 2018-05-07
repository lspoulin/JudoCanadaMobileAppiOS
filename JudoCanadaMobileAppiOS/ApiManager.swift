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

let baseURL = "http://judocanada.org/wp-json/"
let getPostEndpoint = "wp/v2/posts"

class ApiManager<M:Mappable>{
    
    public func geAllPostsURL() -> String?{
        return baseURL+getPostEndpoint
    }
    
    public func getMappable(getURL:String, completion: @escaping ( _ mappable:Any) -> ()){
        
        Alamofire.request(getURL).responseJSON { response in
            if response.error != nil{
                print("\(String(describing: response.error))")
                return
            }
            if response.result.isSuccess {
                print("This is a success")
                guard let value  = response.value else {return}
                //print(value as Any)
                
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
                return
            }
            if response.result.isSuccess {
                print("This is a success")
                guard let value  = response.value else {return}
                //print(value as Any)
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

}

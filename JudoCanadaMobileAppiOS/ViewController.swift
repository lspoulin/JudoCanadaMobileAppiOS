//
//  ViewController.swift
//  JudoCanadaMobileAppiOS
//
//  Created by Louis-Simon Poulin on 2018-05-07.
//  Copyright © 2018 Louis-Simon Poulin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let apiManager = ApiManager<Post>()
        apiManager.getMappableArray(getURL: apiManager.geAllPostsURL()!, completion: display)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func display(myPosts:Any?)->(){
        guard let posts:[Post] = myPosts as? [Post] else{
            print("No Post array")
            return
        }
        for post in posts{
            print ("\(post.title)")
        }
    }
    
    


}


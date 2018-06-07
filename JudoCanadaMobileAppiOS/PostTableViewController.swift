//
//  TableViewController.swift
//  JudoCanadaMobileAppiOS
//
//  Created by Louis-Simon Poulin on 2018-05-07.
//  Copyright © 2018 Louis-Simon Poulin. All rights reserved.
//

import UIKit
import Kingfisher

class PostTableViewController: UITableViewController {
    @IBOutlet weak var progressBar: UIProgressView!
    var posts = [Post]()
    var time:Float = 0.0
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPosts()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo.png")
        imageView.image = image
        navigationItem.titleView = imageView
        
         // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func getPosts() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.setProgress), userInfo: nil, repeats: true)
        let apiHelper:ApiHelper = ApiHelper()
        apiHelper.getPosts(completion: display)
    }
    
    @objc func setProgress() {
        time += 0.01
        self.progressBar.progress = time.truncatingRemainder(dividingBy: 1.0)
    }
    
    func display(myPosts:Any?)->(){
        guard let posts:[Post] = myPosts as? [Post] else{
            print("No Post array")
            return
        }
        self.posts = posts
        self.tableView.reloadData()
        self.timer?.invalidate()
        self.progressBar.isHidden = true
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostIndentifier")
        cell?.imageView?.kf.cancelDownloadTask()
        
        let cells = tableView.dequeueReusableCell(withIdentifier: "PostIndentifier", for: indexPath)
        let post = cells as! PostTableViewCell
        
        
        let postobj = posts[indexPath.row]
        post.labelTitle.text = postobj.title
        post.labelExerpt.text = postobj.excerpt.htmlToString
    
        if postobj.imageList.count != 0{
        let urlString:String = postobj.imageList[0]
        let url = URL(string: urlString)
            // this downloads the image asynchronously if it's not cached yet
            post.imgPost.kf.setImage(with: url)
            
            //post.labelTitle.constraints.append(<#T##newElement: NSLayoutConstraint##NSLayoutConstraint#>)
        }
        else{
            post.imgWidth.constant = 0
            post.imgPost.isHidden = true
            post.layoutIfNeeded()
        }
    
        return cells
    }
    @IBAction func logout(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
        UserDefaults.standard.removeObject(forKey: "UserName")
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginSignupVC")
        
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let view:PostViewController = segue.destination as! PostViewController else {
            return
        }
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
           view.post = posts[selectedRow]
        }
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}

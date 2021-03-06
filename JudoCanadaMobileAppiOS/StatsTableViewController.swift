//
//  StatsTableViewController.swift
//  JudoCanadaMobileAppiOS
//
//  Created by Louis-Simon Poulin on 2018-05-11.
//  Copyright © 2018 Louis-Simon Poulin. All rights reserved.
//

import UIKit

class StatsTableViewController: UITableViewController {

    var users:[User] = [User]()
    var time:Float = 0.0
    var timer:Timer?
    
    @IBOutlet weak var progressBar: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
        
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
    
    func getUsers() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.setProgress), userInfo: nil, repeats: true)
        let apiHelper:ApiHelper = ApiHelper()
        apiHelper.getUsers(completion: display)
    }
    
    @objc func setProgress() {
        time += 0.01
        self.progressBar.progress = time.truncatingRemainder(dividingBy: 1.0)
    }
    
    func display(myList:Any?)->(){
        self.timer?.invalidate()
        self.progressBar.isHidden = true
        guard let usertemp:[User] = myList as? [User] else{
            print("No Video list")
            return
        }
        self.users = usertemp
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (users.count)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath) as! StatsTableViewCell
        let user:User = users[indexPath.row]
        cell.label.text = "\(user.firstname) \(user.name) : \(user.email)"
        
        return cell
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

   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let view:VideoPlayerViewController = segue.destination as! VideoPlayerViewController else {
            return
        }
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            view.video = videoList.videos![selectedRow]
        }
    }*/

}

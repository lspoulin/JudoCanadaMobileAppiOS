//
//  ProductTableVC.swift
//  JudoCanadaMobileAppiOS
//
//  Created by Louis-Simon Poulin on 2018-06-07.
//  Copyright © 2018 Louis-Simon Poulin. All rights reserved.
//

import UIKit
import Kingfisher


class ProductTableVC: UITableViewController {
    var products = [Product]()
    var time:Float = 0.0
    var timer:Timer?
    

    @IBOutlet weak var progressBar: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getProducts()
        
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
    
    func getProducts() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.setProgress), userInfo: nil, repeats: true)
        let apiHelper:ApiHelper = ApiHelper()
        apiHelper.getProducts(completion: display)
    }
    
    @objc func setProgress() {
        time += 0.01
        self.progressBar.progress = time.truncatingRemainder(dividingBy: 1.0)
    }
    
    func display(myPosts:Any?)->(){
        guard let products:[Product] = myPosts as? [Product] else{
            print("No Post array")
            return
        }
        self.products = products
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
        return products.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        
        let product = products[indexPath.row]
        
        
        cell.productName.text = product.name
        cell.productDescription.text = product.shortDescription
        
        let url = URL(string: product.imageUrl)
        // this downloads the image asynchronously if it's not cached yet
        cell.productImag.kf.setImage(with: url)
        

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

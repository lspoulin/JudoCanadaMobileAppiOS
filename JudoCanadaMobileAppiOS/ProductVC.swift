//
//  ProductVC.swift
//  JudoCanadaMobileAppiOS
//
//  Created by Louis-Simon Poulin on 2018-06-08.
//  Copyright © 2018 Louis-Simon Poulin. All rights reserved.
//

import UIKit

class ProductVC: UIViewController {
    var product = Product()

    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let p = product
        
        productDescription.text = p.shortDescription
        productName.text = p.name
        let url = URL(string: p.imageUrl)
        // this downloads the image asynchronously if it's not cached yet
        imgProduct.kf.setImage(with: url)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ViewController.swift
//  JudoCanadaMobileAppiOS
//
//  Created by Louis-Simon Poulin on 2018-05-07.
//  Copyright © 2018 Louis-Simon Poulin. All rights reserved.
//

import UIKit
import Kingfisher

class PostViewController: UIViewController {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textContent: UITextView!
    @IBOutlet weak var imgPost: UIImageView!
    
    var post:Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        display()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func display(){
        guard let mypost:Post = post else{
            print("No Post")
            return
        }
        labelTitle.text = mypost.title        
        textContent.text = mypost.content.htmlToString
        
        guard let urlstring:String = mypost.imageList[0] else{
            return
        }
        let url = URL(string: urlstring)
        // this downloads the image asynchronously if it's not cached yet
        imgPost.kf.setImage(with: url)
        
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .unicode) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:  NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

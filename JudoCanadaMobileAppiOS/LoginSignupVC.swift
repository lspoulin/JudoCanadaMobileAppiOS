//
//  LoginSignupVC.swift
//  JudoCanadaMobileAppiOS
//
//  Created by Louis-Simon Poulin on 2018-05-22.
//  Copyright © 2018 Louis-Simon Poulin. All rights reserved.
//

import UIKit

class LoginSignupVC: UIViewController {
    @IBOutlet weak var email: UITextField!
   
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func login(_ sender: Any) {
        let email = self.email.text
        let password = self.password.text
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if email == "lspoulin@gmail.com" && password == "allo"{
            UserDefaults.standard.set(email, forKey: "UserName")
            appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainVC")
            
            appDelegate.window?.rootViewController = initialViewController
            appDelegate.window?.makeKeyAndVisible()
        }
        
        
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

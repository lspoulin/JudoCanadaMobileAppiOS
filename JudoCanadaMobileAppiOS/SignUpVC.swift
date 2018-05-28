//
//  SignUpVC.swift
//  JudoCanadaMobileAppiOS
//
//  Created by Louis-Simon Poulin on 2018-05-28.
//  Copyright © 2018 Louis-Simon Poulin. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var confirm: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var DateofBirth: UITextField!
    @IBOutlet weak var JudoCanadaId: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var firstname: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signup(_ sender: Any) {
        let name = self.name.text
        let firstname = self.firstname.text
        let email = self.email.text
        let password = self.password.text
        let confirum = self.confirm.text
        let dob = self.DateofBirth.text
        let judocadanaid = self.JudoCanadaId.text
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        UserDefaults.standard.set(email, forKey: "UserName")
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainVC")
        
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
    
        
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

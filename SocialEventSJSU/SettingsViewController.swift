//
//  SettingsViewController.swift
//  SocialEventSJSU
//
//  Created by Joshua Ventocilla on 5/14/17.
//  Copyright © 2017 KitoMam. All rights reserved.
//

import FBSDKLoginKit
import UIKit

class SettingsViewController: UITableViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var welcomeMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 235, width: view.frame.width - 32, height: 50)
        
        loginButton.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logged out of facebook")
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "backlogin", sender: self)
        }
    }
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        } else if FBSDKAccessToken.current() == nil {
            welcomeMessage.text = "Authentication was canceled"
            print("User click cancel")
        }
        else if error == nil {
            print("Successfull logged in via facebook")
            self.performSegue(withIdentifier: "showNew", sender: self)
        }
    }

}

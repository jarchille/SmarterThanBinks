//
//  LoginViewController.swift
//  SmarterThanBinks
//
//  Created by Jonathan Archille on 1/14/17.
//  Copyright © 2017 The Iron Yard. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {

    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var binksImageView: UIImageView!
    
    @IBAction func googleSignInButton(_ sender: UIButton) {
        handleSignIn()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "LoginBackgroundImage"))
        
        
        binksImageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        
        setupViews()


    }
    
    
    
    func handleSignIn() {
    GIDSignIn.sharedInstance().signIn()
    }

    func setupViews() {
        

        
        
        
        
    
    
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
    }
    


}

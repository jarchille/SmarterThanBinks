//
//  GameViewController.swift
//  SmarterThanBinks
//
//  Created by Jonathan Archille on 1/16/17.
//  Copyright © 2017 The Iron Yard. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var questionNumber: UIImageView!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var answerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var scoreBoard: UIImageView!
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var incorrectButton: UIButton!
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        sendMessage()
        
    }
    
    @IBAction func incorrectTapped(_ sender: UIButton) {
    }

    @IBAction func correctTapped(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerTextField.becomeFirstResponder()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return false
    }
    
    func keyboardDidShow(_ notification: Notification!)
    {
        let height = ((notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height)
        answerViewBottomConstraint.constant = height
    
    }
    
    func sendMessage() {
    
    
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }

    
}

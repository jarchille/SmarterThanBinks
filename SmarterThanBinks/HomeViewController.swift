//
//  ViewController.swift
//  SmarterThanBinks
//
//  Created by Jonathan Archille on 1/10/17.
//  Copyright © 2017 The Iron Yard. All rights reserved.
//

import UIKit
import BetterSegmentedControl
import GoogleSignIn


class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var playersTableView: UITableView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var instructionsImage: UIImageView!
    @IBOutlet weak var starsImage: UIImageView!
    
    @IBOutlet weak var segmentedControl: BetterSegmentedControl!
    
    
    
    var triviaArray = [Trivia]()
    
    var players: [player] = []
    var playerStatus = ["Brian" : "Available", "Heather" : "You have been invited!", "Adam" : "", "Kim" : "", "Huy" : "", "Michael" : "Available", "Moa" : "", "Alex" : "Available", "Eric" : "", "Ben" : "You have been invited!", "Marco" : "Available"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        starsImage.alpha = 0.0
        instructionsImage.contentMode = .scaleAspectFit
        
        segmentedControl.titles = ["Home", "Leader Board"]
        segmentedControl.titleFont = UIFont(name: "HelveticaNeue-Light", size: 20.0)!
        segmentedControl.selectedTitleFont = UIFont(name: "HelveticaNeue-Light", size: 20.0)!
        segmentedControl.alwaysAnnouncesValue = false
        segmentedControl.announcesValueImmediately = true
        segmentedControl.backgroundColor = UIColor.darkGray
        
        createPlayers()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.playersTableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! playerTableViewCell
        
        
        let player = players[indexPath.row]
        cell.nameLabel.text = player.name
        if playerStatus[player.name!] != "Invited" {
            cell.statusLabel.text = playerStatus[player.name!] }
        else { cell.statusLabel.text = "" }
        
        if playerStatus[player.name!] == "Available" {
            cell.statusButton.setTitle("Invite", for: .normal)
        } else if playerStatus[player.name!] == "You have been invited!" {
            cell.statusButton.setTitle("Accept", for: .normal)
        } else if playerStatus[player.name!] == "Invited" {
            cell.statusButton.setTitle("Invited", for: .normal)
        } else {
            cell.statusButton.setTitle("Unavailable", for: .normal)
        }
        
        cell.statusButton.backgroundColor = (cell.statusLabel.text == "" || cell.statusLabel.text == "Invited") ? UIColor.gray : UIColor(red: 30/255, green: 215/255, blue: 96/255, alpha: 1)
        cell.statusButton.titleLabel?.textAlignment = .center
        
        cell.tapAction = { (cell) in
            let index = tableView.indexPath(for: cell)!.row
            if index == 0 || index == 10 || index == 7 || index == 6  {
                self.setButtonToInvitedStatus(index: index)
            }
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
    
    
    func setButtonToInvitedStatus(index: Int) {
        
         let playerStatusToChange = players[index]
         playerStatus[playerStatusToChange.name!] = "Invited"
         playersTableView.reloadData()
        
        
    }
    
    @IBAction func valueChanged(_ sender: BetterSegmentedControl) {
        if sender.index == 1 {
            showLeaderBoard()
            instructionsImage.alpha = 0.0
            starsImage.alpha = 1.0
            
         
        } else {
            hideLeaderBoard()
            instructionsImage.alpha = 1.0
            starsImage.alpha = 0.0
            
            
        }
        
    }
    
    func showLeaderBoard() {
        
        
        guard let window = UIApplication.shared.keyWindow else { return }
        let dy = window.frame.height - secondView.frame.height
       
        
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.playersTableView.frame = CGRect(x: -self.playersTableView.frame.width, y: dy, width: self.view.frame.width, height: self.view.frame.height)
            self.secondView.frame = CGRect(x: 0, y: dy, width: self.secondView.frame.width, height: self.secondView.frame.height)

            
        })
        
    }
    
    func hideLeaderBoard() {
        
       instructionsImage.image = #imageLiteral(resourceName: "SelectYourOpponentImage")
        
        guard let window = UIApplication.shared.keyWindow else { return }
        let dy = window.frame.height - secondView.frame.height
        
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.playersTableView.frame = CGRect(x: 0, y: dy, width: self.view.frame.width, height: self.view.frame.height)
            self.secondView.frame = CGRect(x: self.view.frame.width, y: dy, width: self.secondView.frame.width, height: self.secondView.frame.height)
            
        })
    }
    
    
    
    
    func testAPI()
    {
        let config = URLSessionConfiguration.default
        let apiKeyString = "2f2d51994fca9161665ca337e0c9ef55bf2c72fd:fc0c8eeff743d92c448d1b1e29a71b5c6e5df632"
        let apiKeyStringData = apiKeyString.data(using: String.Encoding.utf8)
        let base64EncodedCredential = apiKeyStringData!.base64EncodedString()
        let authString = "Basic \(base64EncodedCredential)"
        config.httpAdditionalHeaders = ["Authorization" : authString]
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: URL(string: "http://trivia.propernerd.com/api/questions?limit=5&random=true&category=Star%20Wars")!, completionHandler: { data, response, error in
            
            if error != nil {
                print("response failed")
                
            }
            
            
            do {
                let apiResponse = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String : Any]]
                
                
                for dictionary in apiResponse {
                    guard let question = dictionary["question"] as? String else { return }
                    guard let answer = dictionary["answer"] else { return }
                    
                    let triviaSet = Trivia()
                    triviaSet.question = question
                    triviaSet.answer = answer
                    
                    self.triviaArray.append(triviaSet)
                    
                    
                }
                print(self.triviaArray.count)
                
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            
            
            
            
            
        })
        
        task.resume()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    func createPlayers() {
        let players = ["Brian", "Eric", "Kim", "Ben", "Heather", "Adam", "Michael", "Marco", "Moa", "Huy", "Alex"]
        
        for i in players {
            let newPlayer = player.init(name: i, isInvited: false)
            self.players.append(newPlayer)
            
            
            
        }
    
    }
    
    
}

struct player {
    let name: String?
    var isInvited: Bool?
    }
    

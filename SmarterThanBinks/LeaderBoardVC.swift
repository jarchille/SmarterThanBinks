//
//  LeaderBoardVC.swift
//  SmarterThanBinks
//
//  Created by Jonathan Archille on 1/16/17.
//  Copyright © 2017 The Iron Yard. All rights reserved.
//

import UIKit

class LeaderBoardVC: UITableViewController {

   
    var players = ["Brian", "Heather", "Adam", "Kim", "Huy", "Michael", "Moa", "Alex", "Eric", "Ben", "Marco", "Jonathan"]
    var playerScore = ["Brian" : 57, "Heather" : 51, "Adam" : 44, "Kim" : 39, "Huy" : 39, "Michael" : 31, "Moa" : 22, "Alex" : 18, "Eric" : 11, "Ben" : 9, "Marco" : 3, "Jonathan" : 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return players.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let player = players[indexPath.row]
        cell.textLabel?.text = "\(indexPath.row + 1). \(player)"
        cell.detailTextLabel?.text = "\(playerScore[player]!) points"
        
        cell.backgroundColor = UIColor.clear
    
        

       

        return cell
    }
    


}

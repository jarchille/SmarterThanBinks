//
//  playerTableViewCell.swift
//  SmarterThanBinks
//
//  Created by Jonathan Archille on 1/16/17.
//  Copyright © 2017 The Iron Yard. All rights reserved.
//

import UIKit

class playerTableViewCell: UITableViewCell {

    var tapAction: ((UITableViewCell) -> Void)?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    
    @IBAction func statusButtonTapped(_ sender: UIButton) {
        tapAction?(self)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

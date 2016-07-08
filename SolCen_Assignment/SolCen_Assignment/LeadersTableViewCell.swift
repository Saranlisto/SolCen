//
//  LeadersTableViewCell.swift
//  SolCen_Assignment
//
//  Created by Saranyan Mahadevan on 07/07/16.
//  Copyright © 2016 saran. All rights reserved.
//

import UIKit

class LeadersTableViewCell: UITableViewCell {

    
    @IBOutlet var cardView: UIView!
    @IBOutlet var leaderImageView: UIImageView!
    @IBOutlet var leaderNameLabel: UILabel!
    @IBOutlet var leaderEmailLabel: UILabel!
    var leadersDictionary:NSMutableDictionary?
    {
        didSet
        {
            leaderNameLabel.text = (leadersDictionary?.valueForKey("firstName") as? String)! + " " + ((leadersDictionary?.valueForKey("lastName"))! as! String)
            leaderEmailLabel.text = leadersDictionary?.valueForKey("emailId") as? String

            let url = NSURL(string: leadersDictionary?.valueForKey("imageUrl") as! String)
            self.leaderImageView.sd_setImageWithURL(url)
            
        }
        willSet
        {
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.layer.borderColor = UIColor.blackColor().CGColor
        cardView.layer.borderWidth = 1.0
        cardView.layer.cornerRadius = 5.0
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}

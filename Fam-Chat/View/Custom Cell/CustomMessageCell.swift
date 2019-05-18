//
//  CustomMessageCell.swift
//  Fam-Chat
//
//  Created by Timothy Itodo on 5/17/19.
//  Copyright © 2019 Timothy Itodo. All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {

    @IBOutlet weak var messageBackground: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var senderUsername: UILabel!
    @IBOutlet weak var messageBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

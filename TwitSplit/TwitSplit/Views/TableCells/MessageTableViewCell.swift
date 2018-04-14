//
//  MessageTableViewCell.swift
//  TwitSplit
//
//  Created by tri dang huu on 4/9/18.
//  Copyright © 2018 tri dang huu. All rights reserved.
//

import UIKit

class MessageTableViewCell: BaseTableViewCell {

    @IBOutlet weak var orginMessage: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setupUI(object: AnyObject) {
        var messageString = ""
        var orginMessage = ""
        if object is Array<Message> {
            let arrMessage = object as! Array<Message>
            
           orginMessage = arrMessage.map({ (message) -> String in
                return message.content
            }).joined(separator: " ")
            
            messageString = arrMessage.map({ (message) -> String in
                return message.toString()
            }).joined(separator: "\n")
            
        } else if object is Message {
            let message = object as! Message
            orginMessage = message.content
            messageString = message.content
        }
        self.messageLabel.text = messageString
        self.orginMessage.text = orginMessage
    }

    override func prepareForReuse() {
        self.messageLabel.text = ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  BaseTableViewCell.swift
//  TwitSplit
//
//  Created by tri dang huu on 4/9/18.
//  Copyright © 2018 tri dang huu. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    @IBOutlet weak var baseContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupUI(object:AnyObject) {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

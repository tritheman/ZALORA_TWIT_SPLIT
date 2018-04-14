//
//  Utils.swift
//  TwitSplit
//
//  Created by tri dang huu on 4/9/18.
//  Copyright © 2018 tri dang huu. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    class func showAlert(message: String, title: String = "Warning", atVC:UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        atVC.present(alert, animated: true, completion: nil)
    }

}

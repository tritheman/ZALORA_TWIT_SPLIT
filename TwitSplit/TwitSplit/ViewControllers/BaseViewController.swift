//
//  BaseViewController.swift
//  TwitSplit
//
//  Created by tri dang huu on 4/9/18.
//  Copyright © 2018 tri dang huu. All rights reserved.
//

import UIKit

protocol BaseViewProtocol {
    func setupUI()
}

class BaseViewController: UIViewController, BaseViewProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BaseViewController {
    func addKeyboardListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            
            let keyboardBeginFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
            let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let heightOffset = keyboardBeginFrame.origin.y - keyboardEndFrame.origin.y
            
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
            
            var rect = self.view.frame
            rect.size.height += heightOffset;
            UIView.animate(withDuration: duration.doubleValue, animations: {
                self.view.frame = rect
            })
            
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            
            let keyboardBeginFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
            let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let heightOffset = keyboardBeginFrame.origin.y - keyboardEndFrame.origin.y
            
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber

            var rect = self.view.frame
            rect.size.height -= heightOffset;
            UIView.animate(withDuration: duration.doubleValue, animations: {
                self.view.frame = rect
            })
            
        }
    }
}

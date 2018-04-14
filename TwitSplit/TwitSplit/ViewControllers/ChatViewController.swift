//
//  ChatViewController.swift
//  TwitSplit
//
//  Created by tri dang huu on 4/7/18.
//  Copyright © 2018 tri dang huu. All rights reserved.
//

import UIKit


class ChatViewController: BaseViewController {

    @IBOutlet weak var messageTextView: KMPlaceholderTextView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageTableView: UITableView!
    
    var messageArr:[[Message]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addKeyboardListeners()
        self.setupUI()
    }

    @IBAction func sendButtonClicked(_ sender: Any) {
        guard let message = messageTextView.text else {
            return
        }
//        messageTextView.endEditing(true)
        let result = TwitSplit.shared.process(message: Message(content: message))
        if case let TwitResult.DidSuccess(messages) = result  {
            if messages.count > 0 {
                let newIndexPath = IndexPath(row: self.messageArr.count, section: 0)
                self.messageArr.append(messages)
                self.messageTableView.beginUpdates()
                self.messageTableView.insertRows(at: [newIndexPath], with: .left)
                self.messageTableView.endUpdates()
                
                self.messageTableView.scrollToRow(
                    at: newIndexPath,
                    at: UITableViewScrollPosition.bottom, animated: true)
            }
            messageTextView.text = ""
        } else if case let TwitResult.DidFailed(error) = result {
            Utils.showAlert(message: error.errorString, atVC: self)
        }

    }
    
    override func setupUI() {
        
        self.messageTextView.text = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        
        self.messageTableView.register(UINib.init(nibName: ConstantsCell.kMessageCell.rawValue, bundle: nil), forCellReuseIdentifier: ConstantsCell.kMessageCell.rawValue)
        self.messageTableView.estimatedRowHeight = 44
        self.messageTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConstantsCell.kMessageCell.rawValue,
                                                 for: indexPath) as? MessageTableViewCell
        
        cell?.setupUI(object: messageArr[indexPath.row] as AnyObject)
        return cell!
    }


}


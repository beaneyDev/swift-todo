//
//  ActivityPresentable.swift
//  MBTodo
//
//  Created by Matt Beaney on 30/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation
import UIKit

protocol ActivityPresentable : class {
    var activityBlocker: UIView? { get set }
    
    func presentActivityView(with message: String?)
    func removeActivityView()
}

extension ActivityPresentable where Self : UIViewController {
    func presentActivityView(with message: String? = nil) {
        if activityBlocker != nil {
            return
        }
        
        activityBlocker = UIView()
        if let activityBlocker = activityBlocker {
            activityBlocker.backgroundColor = UIColor.clear
            activityBlocker.alpha = 1.0
            activityBlocker.translatesAutoresizingMaskIntoConstraints = false
            
            let blockerooney = UIView()
            blockerooney.translatesAutoresizingMaskIntoConstraints = false
            blockerooney.alpha = 0.7
            blockerooney.backgroundColor = UIColor.black
            
            activityBlocker.addSubview(blockerooney)
            
            let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|[blocker]|", options: [], metrics: nil, views: ["blocker": blockerooney])
            let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|[blocker]|", options: [], metrics: nil, views: ["blocker": blockerooney])
            
            activityBlocker.addConstraints(horizontal)
            activityBlocker.addConstraints(vertical)
            
            self.view.addSubview(activityBlocker)
            
            let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[activityBlocker]|", options: [], metrics: nil, views: ["activityBlocker": activityBlocker])
            let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[activityBlocker]|", options: [], metrics: nil, views: ["activityBlocker": activityBlocker])
            
            self.view.addConstraints(horizontalConstraints)
            self.view.addConstraints(verticalConstraints)
            
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activityIndicator.startAnimating()
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            
            activityBlocker.addSubview(activityIndicator)
            
            let horizontalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: activityBlocker, attribute: .centerX, multiplier: 1, constant: 0)
            activityBlocker.addConstraint(horizontalConstraint)
            
            let verticalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: activityBlocker, attribute: .centerY, multiplier: 1, constant: 0)
            activityBlocker.addConstraint(verticalConstraint)
            
            if let message = message {
                let lblMsg = UILabel()
                lblMsg.text = message
                lblMsg.textColor = .white
                lblMsg.translatesAutoresizingMaskIntoConstraints = false
                activityBlocker.addSubview(lblMsg)
                
                let horizontalConstraint = NSLayoutConstraint(item: lblMsg, attribute: .centerX, relatedBy: .equal, toItem: activityBlocker, attribute: .centerX, multiplier: 1, constant: 0)
                activityBlocker.addConstraint(horizontalConstraint)
                
                let verticalConstraint = NSLayoutConstraint(item: lblMsg, attribute: .top, relatedBy: .equal, toItem: activityIndicator, attribute: .bottom, multiplier: 1, constant: 8.0)
                activityBlocker.addConstraint(verticalConstraint)
            }
        }
    }
    
    func removeActivityView() {
        on.main {
            if let activityBlocker = self.activityBlocker {
                activityBlocker.removeFromSuperview()
                self.activityBlocker = nil
            }
        }
    }
}

//
//  LaunchViewController.swift
//  MBTodo
//
//  Created by Matt Beaney on 30/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation
import UIKit
import ReSwift

class LaunchViewController : UIViewController, AuthListener {
    
    var authVM: AuthVM?
    @IBOutlet weak var tick: UIView!
    
    override func viewDidLoad() {
        self.configureTicker()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        authVM?.unsubscribe()
    }
    
    func configureTicker() {
        let ticker = MBTickBox()
        ticker.configure()
        ticker.translatesAutoresizingMaskIntoConstraints = false
        self.tick.addSubview(ticker)
        self.tick.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tick]|", options: [], metrics: nil, views: ["tick": ticker]))
        self.tick.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tick]|", options: [], metrics: nil, views: ["tick": ticker]))
        on.delay(0.1) {
            ticker.tick {
                self.authVM = AuthVM(listener: self)
            }
        }
    }
    
    func userAuthorised(uid: String) {
        on.main_delay(0.5) {
            self.performSegue(withIdentifier: "home", sender: nil)
        }
    }
    
    func moveToLogin() {
        on.main_delay(0.5) {
            self.performSegue(withIdentifier: "login", sender: nil)
        }
    }
    
    func userNotLoggedIn() {
        self.moveToLogin()
    }
    
    func userLoginErrored(error: Error) {
        self.moveToLogin()
    }
}

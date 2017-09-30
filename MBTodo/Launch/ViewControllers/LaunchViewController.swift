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
    
    override func viewDidAppear(_ animated: Bool) {
        self.authVM = AuthVM(listener: self)
    }
    
    func userAuthorised(uid: String) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "home", sender: nil)
        }
    }
    
    func moveToLogin() {
        DispatchQueue.main.async {
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

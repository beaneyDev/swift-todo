//
//  AuthViewController.swift
//  MBTodo
//
//  Created by Matt Beaney on 30/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation
import UIKit

class AuthViewController : UIViewController, AuthListener, ActivityPresentable {
    var authVM : AuthVM?
    var activityBlocker: UIView?
    
    override func viewDidLoad() {
        self.authVM = AuthVM(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.authVM?.unsubscribe()
    }
    
    @IBAction func login(_ sender: Any) {
        self.presentActivityView(with: "Logging In...")
        self.authVM?.login()
    }
    
    func userAuthorised(uid: String) {
        on.main {
            self.performSegue(withIdentifier: "home", sender: nil)
        }
    }
    
    func userLoginErrored(error: Error) {
        on.main {
            let alert = UIAlertController(title: "There was a problem logging in", message: "Sorry, there was an issue logging in, please try again.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func userNotLoggedIn() {
        
    }
}


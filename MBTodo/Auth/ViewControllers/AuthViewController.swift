//
//  AuthViewController.swift
//  MBTodo
//
//  Created by Matt Beaney on 30/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation
import UIKit

class AuthViewController : UIViewController, AuthListener {
    func userAuthorised(uid: String) {
        
    }
    
    func userLoginErrored(error: Error) {
        
    }
    
    func userNotLoggedIn() {
        
    }
}

//self.databaseReference = FirebaseTodoController().observeTodos(uid: uid, completion: { (todos, error) in
//    guard let todos = todos else { return }
//    store.dispatch(SetTodos(todos: todos))
//})

//store.dispatch(Actions_Auth.initiateSSOLogin())


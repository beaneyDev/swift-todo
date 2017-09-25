//
//  FirebaseAPIController.swift
//  MBTodo
//
//  Created by Matt Beaney on 24/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation
import Firebase

class FirebaseTodoController {
    static func fetchTodos(uid: String, completion: @escaping (_ dict: Dictionary<String, Any>?, _ error: Error?) -> ()) {
        let ref = Database.database().reference()
        ref.child("users").child(uid).child("todos").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? Dictionary<String, Any>
            completion(value, nil)
        }) { (error) in
            completion(nil, error)
        }
    }
}

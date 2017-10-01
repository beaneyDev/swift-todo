//
//  FirebaseAuthController.swift
//  MBTodo
//
//  Created by Matt Beaney on 24/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseAuthController: OAuthTokenValidator {
    func validateToken(token: String, completion: @escaping (String?, Error?) -> ()) {
        let credential = GitHubAuthProvider.credential(withToken: token)
        Auth.auth().signIn(with: credential) { (user, error) in
            guard let user = user else {
                completion(nil, error)
                return
            }
            
            completion(user.uid, nil)
        }
    }
    
    func logout() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            return false
        }
    }
}

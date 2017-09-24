//
//  Actions_Launch.swift
//  MBTodo
//
//  Created by Matt Beaney on 21/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import ReSwift

///Once authorisation is complete with GitHub and Firebase, this action sets the user on the main state.
struct SetUser: Action {
    var user: FirebaseAuth.User
}

///If there is an error of any kind, show it.
struct ShowAuthError: Action {
    var error: Error?
}

class Actions_Auth {
    /**
     Begins login flow by redirecting the user to GitHub.
     - returns: An async action that continues the authorisation chain.
    */
    static func initiateSSOLogin() -> Store<State>.ActionCreator {
        return { state, store in
            let url = URL(string: GitHubStrings.authoriseURL)!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            return nil
        }
    }
    
    /**
     This function is called by the AppDelegate once GitHub redirect has completed.
     - parameters:
     - URL: The callback URL set in the GitHub portal.
     - returns: An async action that continues the authorisation chain.
    */
    static func fetchToken(url: URL) -> Store<State>.ActionCreator {
        return { state, store in
            GitHubAPIController.fetchToken(url: url, completion: { (token, error) in
                guard let token = token else {
                    store.dispatch(ShowAuthError(error: error))
                    return
                }
                
                store.dispatch(self.authoriseWithAccessToken(token: token))
            })
            
            return nil
        }
    }
    
    /**
     This function is called once the GitHub flow is complete - it will now authorise with Firebase.
     - parameters:
     - Token: The user-specific token returned by GitHub.
     - returns: An async action that completes authorisation, either with an error or a valid User object.
     */
    static func authoriseWithAccessToken(token: String) -> Store<State>.ActionCreator {
        return { state, store in
            let credential = GitHubAuthProvider.credential(withToken: token)
            Auth.auth().signIn(with: credential) { (user, error) in
                guard let user = user else {
                    store.dispatch(ShowAuthError(error: error))
                    return
                }
                
                store.dispatch(SetUser(user: user))
            }
            
            return nil
        }
    }
}

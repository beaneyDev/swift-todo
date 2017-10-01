//
//  Actions_Auth.swift
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
    var uid: String
}

struct ClearUser: Action {
    
}

///If there is an error of any kind, show it.
struct ShowAuthError: Action {
    var error: Error?
}

class Actions_Auth {
    /**
     Refreshes user login
     - parameters:
     - state: application state.
     - store: store that dispatches actions.
     */
    static func refreshLogin(state: State, store: Store<State>) -> Action? {
        if let currentUser = Auth.auth().currentUser {
            return SetUser(uid: currentUser.uid)
        }
        
        return nil
    }
    
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
     - parameters:
     - UserType: This is supplied to bypass Firebase when Unit testing.
     - URL: The callback URL set in the GitHub portal.
     - returns: An async action that continues the authorisation chain.
     */
    static func fetchToken(url: URL, fetcher: OAuthTokenFetcher, validator: OAuthTokenValidator) -> Store<State>.ActionCreator {
        return { state, store in
            fetcher.fetchToken(url: url, completion: { (token, error) in
                guard let token = token else {
                    store.dispatch(ShowAuthError(error: error))
                    return
                }
                
                store.dispatch(authoriseWithAccessToken(token: token, validator: validator))
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
    static func authoriseWithAccessToken(token: String, validator: OAuthTokenValidator) -> Store<State>.ActionCreator {
        return { state, store in
            validator.validateToken(token: token, completion: { (user, error) in
                guard let user = user else {
                    store.dispatch(ShowAuthError(error: error))
                    return
                }
                
                store.dispatch(SetUser(uid: user))
            })
            
            return nil
        }
    }
    
    static func logout(state: State, store: Store<State>) -> Action? {
        return FirebaseAuthController().logout() ? ClearUser() : nil
    }
}

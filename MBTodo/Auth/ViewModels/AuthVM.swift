//
//  AuthVM.swift
//  MBTodo
//
//  Created by Matt Beaney on 30/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation
import ReSwift

protocol AuthListener: class {
    func userAuthorised(uid: String)
    func userNotLoggedIn()
    func userLoginErrored(error: Error)
}

class AuthVM : NSObject {
    var authState       : State_Auth?
    weak var authListener    : AuthListener?
    
    init(listener: AuthListener) {
        super.init()
        self.authListener = listener
        store.dispatch(Actions_Auth.refreshLogin(state:store:))
        self.subscribe()
    }
    
    func login() {
        store.dispatch(Actions_Auth.initiateSSOLogin())
    }
    
    func logout() {
        store.dispatch(Actions_Auth.logout(state:store:))
    }
}

extension AuthVM : StoreSubscriber {
    /**
     ReSwift function for ensuring we get store updates.
     */
    func newState(state: State) {
        if state.authState != self.authState {
            switch state.authState.loginStatus {
            case let .loggedIn(uid):
                self.authListener?.userAuthorised(uid: uid)
                break
            case let .loginErrored(error):
                self.authListener?.userLoginErrored(error: error)
                break
            case .notLoggedIn:
                self.authListener?.userNotLoggedIn()
                break
            }
            
            self.authState = state.authState
        }
    }
    
    func subscribe() {
        store.subscribe(self)
    }
    
    func unsubscribe() {
        store.unsubscribe(self)
    }
}

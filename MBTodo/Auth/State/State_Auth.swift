//
//  State_Auth.swift
//  MBTodo
//
//  Created by Matt Beaney on 21/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation
import ReSwift
import FirebaseAuth

enum LoginStatus {
    case notLoggedIn
    case loginErrored(error: Error)
    case loggedIn(uid: String)
}

struct State_Auth : StateType {
    var loginStatus: LoginStatus
}

extension State_Auth: Equatable {
    static func == (lhs: State_Auth, rhs: State_Auth) -> Bool {
        switch (lhs.loginStatus, rhs.loginStatus) {
        case (.notLoggedIn, .notLoggedIn):
            return true
        case (let .loginErrored(error1), let .loginErrored(error2)):
            return error1.localizedDescription == error2.localizedDescription
        case (let .loggedIn(uid1), let .loggedIn(uid2)):
            return uid1 == uid2
        default:
            return false
        }
    }
}

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

struct State_Auth : StateType {
    var user: FirebaseAuth.User?
}

extension State_Auth: Equatable {
    static func == (lhs: State_Auth, rhs: State_Auth) -> Bool {
        return lhs.user == rhs.user
    }
}

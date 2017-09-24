//
//  State_Todos.swift
//  MBTodo
//
//  Created by Matt Beaney on 24/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation
import ReSwift

struct State_Todos: StateType {
    var todos: [Todo]
}

extension State_Todos: Equatable {
    static func == (lhs: State_Todos, rhs: State_Todos) -> Bool {
        return lhs.todos == rhs.todos
    }
}

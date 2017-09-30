//
//  Actions_Todo.swift
//  MBTodo
//
//  Created by Matt Beaney on 24/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation
import Firebase
import ReSwift

struct SetTodos: Action {
    var todos: [Todo]
}

class Actions_Todo {
    static func addTodo(todoText: String) -> Store<State>.ActionCreator {
        return { state, store in
            guard case let .loggedIn(userID) = state.authState.loginStatus else {
                return nil
            }
            
            FirebaseTodoController().addTodo(uid: userID, todoText: todoText)
            return nil
        }
    }
    
    static func toggleTodo(todo: Todo) -> Store<State>.ActionCreator {
        return { state, store in
            guard case let .loggedIn(userID) = state.authState.loginStatus else {
                return nil
            }
            FirebaseTodoController().toggleTodo(uid: userID, todo: todo)
            return nil
        }
    }
}

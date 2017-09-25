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
    static func startFetchTodos() -> Store<State>.ActionCreator {
        return { state, store in
            guard let userID = state.authState.uid else {
                return nil
            }
            
            FirebaseTodoController.fetchTodos(uid: userID, completion: { (result, error) in
                guard let result = result else {
                    return
                }
                
                let todoList: [Todo] = result.keys.flatMap {
                    if let todo = result[$0] as? Dictionary<String, Any> {
                        return Todo(key: $0, todos: todo)
                    }
                    
                    return nil
                }
                
                store.dispatch(SetTodos(todos: todoList))
            })
            
            return nil
        }
    }
}

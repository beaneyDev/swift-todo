//
//  Reducer.swift
//  MBTodo
//
//  Created by Matt Beaney on 21/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation
import ReSwift

func appReducer(action: Action, state: State?) -> State {
    return State(
        authState: authReducer(action: action, state: state?.authState),
        todosState: todoReducer(action: action, state: state?.todosState)
    )
}

func authReducer(action: Action, state: State_Auth?) -> State_Auth {
    switch action {
    case let action as SetUser:
        if var newState = state {
            newState.loginStatus = LoginStatus.loggedIn(uid: action.uid)
            return newState
        }
    case let action as ShowAuthError:
        if var newState = state {
            if let error = action.error {
                newState.loginStatus = .loginErrored(error: error)
            } else {
                newState.loginStatus = .notLoggedIn
            }
            
            return newState
        }
    case let action as ClearUser:
        if var newState = state {
            newState.loginStatus = .notLoggedIn
            return newState
        }
    default:
        break
    }
    
    return state ?? State_Auth(loginStatus: .notLoggedIn)
}

func todoReducer(action: Action, state: State_Todos?) -> State_Todos {
    switch action {
    case let action as SetTodos:
        if var newState = state {
            newState.todos = action.todos
            return newState
        }
    default:
        break
    }
    
    return state ?? State_Todos(todos: [])
}

//
//  TodoGenerator.swift
//  MBTodoTests
//
//  Created by Matt Beaney on 30/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation

@testable import MBTodo

class TodoGenerator {
    func fetch4Todos() -> [Todo] {
        let todo1 = Todo(key: "Key1", text: "Text1", createdAt: Date(), completedAt: nil, completed: false)
        let todo2 = Todo(key: "Key2", text: "Text2", createdAt: Date(), completedAt: nil, completed: false)
        let todo3 = Todo(key: "Key3", text: "Text3", createdAt: Date(), completedAt: nil, completed: false)
        let todo4 = Todo(key: "Key4", text: "Text4", createdAt: Date(), completedAt: nil, completed: true)
        return [todo1, todo2, todo3, todo4]
    }
    
    func fetch3Todos() -> [Todo] {
        let todo1 = Todo(key: "Key5", text: "Text1", createdAt: Date(), completedAt: nil, completed: false)
        let todo2 = Todo(key: "Key6", text: "Text2", createdAt: Date(), completedAt: nil, completed: false)
        let todo3 = Todo(key: "Key7", text: "Text3", createdAt: Date(), completedAt: nil, completed: false)
        let todo4 = Todo(key: "Key8", text: "Text4", createdAt: Date(), completedAt: nil, completed: true)
        return [todo1, todo2, todo3, todo4]
    }
}

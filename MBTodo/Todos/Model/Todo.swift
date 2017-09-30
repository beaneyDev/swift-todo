//
//  Todo.swift
//  MBTodo
//
//  Created by Matt Beaney on 24/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation

struct Todo {
    var key: String?
    var text: String?
    var createdAt: Date?
    var completedAt: Date?
    var completed: Bool?
    
    init(key: String, todos: Dictionary<String, Any>) {
        self.key = key
        self.text           = todos.obj(for: "text")
        self.createdAt      = todos.dateFromTimeStamp(with: "createdAt")
        self.completedAt    = todos.dateFromTimeStamp(with: "completedAt")
        self.completed      = todos.obj(for: "completed")
    }
}

extension Todo: Equatable {
    static func == (lhs: Todo, rhs: Todo) -> Bool {
        return lhs.key == rhs.key && lhs.completed == rhs.completed
    }
}

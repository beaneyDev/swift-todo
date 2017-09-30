//
//  TodoVM.swift
//  MBTodo
//
//  Created by Matt Beaney on 24/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation

class TodoVM {
    private var todo: Todo
    
    init(todo: Todo) {
        self.todo = todo
    }
    
    var text: String {
        return self.todo.text ?? ""
    }
    
    var createdAt: String {
        return "Created: \(TodoDateFormatter.shared.createdAtFormatter.string(from: self.todo.createdAt ?? Date()))"
    }
    
    var completed: Bool {
        return self.todo.completed ?? false
    }
    
    func todoTapped() {
        
    }
}

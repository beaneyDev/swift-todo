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
    
    func todoTapped() {
        
    }
}

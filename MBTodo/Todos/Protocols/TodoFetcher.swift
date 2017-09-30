//
//  TodoFetcher.swift
//  MBTodo
//
//  Created by Matt Beaney on 30/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation

protocol TodoFetcher {
    func observeTodos(uid: String, completion: @escaping (_ todos: [Todo]?, _ error: Error?) -> ()) -> TodoDataSource
    func addTodo(uid: String, todoText: String)
    func toggleTodo(uid: String, todo: Todo)
}

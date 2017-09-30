//
//  TodosVM.swift
//  MBTodo
//
//  Created by Matt Beaney on 24/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import ReSwift

class TodosVM: NSObject {
    var todosState  = State_Todos(todos: [])
    var showCompleted: Bool = false
    var filterText: String = ""
    
    var todos: [Todo] = [Todo]()
    
    var databaseReference: TodoDataSource?
    
    weak var tableView: UITableView?
    
    init(tableView: UITableView, fetcher: TodoFetcher) {
        super.init()
        store.subscribe(self)
        tableView.delegate      = self
        tableView.dataSource    = self
        self.tableView = tableView
        
        guard case let LoginStatus.loggedIn(uid: uid) = store.state.authState.loginStatus else {
            return
        }
        
        self.databaseReference = fetcher.observeTodos(uid: uid) { (todos, error) in
            guard let todos = todos else {
                return
            }
            
            store.dispatch(SetTodos(todos: todos))
        }
    }
    
    func reload() {
        self.loadWithData(todos: self.todosState.todos)
    }
    
    func loadWithData(todos: [Todo]) {
        var todos = todos
        
        if !self.showCompleted {
            todos = todos.filter {
                !($0.completed ?? false)
            }
        }
        
        if !self.filterText.isEmpty {
            todos = todos.filter {
                ($0.text ?? "").contains(self.filterText)
            }
        }
        
        self.todos = todos
        self.tableView?.reloadData()
    }
}

extension TodosVM: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? Todo_TableViewCell {
            let todoVM = TodoVM(todo: self.todos[indexPath.row])
            cell.configure(with: todoVM)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos.count
    }
}

extension TodosVM: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension TodosVM : StoreSubscriber {
    /**
     ReSwift function for ensuring we get store updates.
     */
    func newState(state: State) {
        //Are there new todos?
        if state.todosState != self.todosState {
            self.todosState = state.todosState
            self.loadWithData(todos: self.todosState.todos)
        } else {
            print("Todos state the same.")
        }
    }
}

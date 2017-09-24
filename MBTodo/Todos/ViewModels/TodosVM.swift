//
//  TodosVM.swift
//  MBTodo
//
//  Created by Matt Beaney on 24/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation
import UIKit

class TodosVM: NSObject {
    var todos: [Todo] = []
    
    init(tableView: UITableView) {
        super.init()
        tableView.delegate      = self
        tableView.dataSource    = self
    }
    
    func loadWithData(todos: [Todo], tableView: UITableView) {
        self.todos = todos
        tableView.reloadData()
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

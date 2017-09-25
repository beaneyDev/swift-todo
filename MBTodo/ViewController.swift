//
//  ViewController.swift
//  MBTodo
//
//  Created by Matt Beaney on 21/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SafariServices
import ReSwift

class ViewController: UIViewController {
    ///UI Components.
    @IBOutlet weak var tableView: UITableView!
    
    //VMs
    var todosVM: TodosVM?
    
    ///State functions.
    var authState   = State_Auth(uid: nil)
    var todosState  = State_Todos(todos: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.todosVM = TodosVM(tableView: self.tableView)
        store.subscribe(self)
    }

    override func viewDidAppear(_ animated: Bool) {
        store.dispatch(Actions_Auth.initiateSSOLogin())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func refreshTodos(_ sender: Any) {
        store.dispatch(Actions_Todo.startFetchTodos())
    }
}

extension ViewController : StoreSubscriber {
    func newState(state: State) {
        if state.authState.uid != nil {
            self.handleValidUser(state: state)
        } else {
            self.handleInvalidUser(state: state)
        }
    }
    
    func handleValidUser(state: State) {
        if state.authState != self.authState {
            self.authState = state.authState
            store.dispatch(Actions_Todo.startFetchTodos())
        } else {
            print("Auth state the same.")
        }
        
        if state.todosState != self.todosState {
            self.todosState = state.todosState
            self.todosVM?.loadWithData(todos: self.todosState.todos, tableView: self.tableView)
        } else {
            print("Todos state the same.")
        }
    }
    
    func handleInvalidUser(state: State) {
        
    }
}


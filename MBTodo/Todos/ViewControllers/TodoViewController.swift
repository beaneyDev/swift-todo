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

class TodoViewController: UIViewController {
    ///UI Components.
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtFieldAdd: UITextField!
    @IBOutlet weak var txtFieldSearch: UITextField!
    
    @IBOutlet weak var container: UIView! {
        didSet {
            container.layer.borderColor = UIColor.lightGray.cgColor
            container.layer.borderWidth = 0.5
        }
    }
    
    //VMs
    var todosVM: TodosVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.todosVM = TodosVM(tableView: self.tableView, fetcher: FirebaseTodoController())
    }
    
    @IBAction func filter(_ sender: Any) {
        self.todosVM?.filterText = self.txtFieldSearch.text ?? ""
        self.todosVM?.reload()
    }
    
    @IBAction func toggleShowCompleted(_ sender: UISwitch) {
        self.todosVM?.showCompleted = sender.isOn
        self.todosVM?.reload()
    }
    
    @IBAction func addTodo(_ sender: Any) {
        guard let todoText = self.txtFieldAdd.text, !todoText.isEmpty else {
            return
        }
        
        store.dispatch(Actions_Todo.addTodo(todoText: todoText))
        self.txtFieldAdd.text = ""
    }
    
}


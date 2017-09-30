//
//  TodosVM_Test.swift
//  MBTodoTests
//
//  Created by Matt Beaney on 30/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

@testable import MBTodo

import Foundation
import FirebaseCore
import FirebaseAuth
import ReSwift
import XCTest

import Quick
import Nimble

class MockTodoDataSource: TodoDataSource {
    
}

class MockTodoFetcher : TodoFetcher {
    var todos = [Todo]()
    func addTodo(uid: String, todoText: String) {
        
    }
    
    func observeTodos(uid: String, completion: @escaping ([Todo]?, Error?) -> ()) -> TodoDataSource {
        let ref = MockTodoDataSource()
        self.todos = TodoGenerator().fetch4Todos()
        completion(self.todos, nil)
        return ref
    }
    
    func toggleTodo(uid: String, todo: Todo) {
        
    }
}

class TodosVM_Test: QuickSpec {
    //MARK: TESTS
    override func spec() {
        describe("Test presenter logic") {
            it("Should take a tableView and assign itself as delegate", closure: {
                let tableView = UITableView()
                let todosVM = TodosVM(tableView: tableView, fetcher: MockTodoFetcher())
                expect(todosVM.tableView).toNot(beNil())
                expect(todosVM.tableView?.delegate).to(be(todosVM))
            })
            
            it("Should initialise with a set of todos") {
                store.state.authState.loginStatus = LoginStatus.loggedIn(uid: "test")
                let tableView = UITableView()
                let todosVM = TodosVM(tableView: tableView, fetcher: MockTodoFetcher())
                
                let filteredTodos = TodoGenerator().fetch4Todos().filter {
                    !($0.completed ?? false)
                }
                
                expect(todosVM.todos).to(equal(filteredTodos))
            }
            
            it("Should reload with a filtered set of todos") {
                store.state.authState.loginStatus = LoginStatus.loggedIn(uid: "test")
                let tableView = UITableView()
                let todosVM = TodosVM(tableView: tableView, fetcher: MockTodoFetcher())
                let currentTodos = todosVM.todos
                
                todosVM.loadWithData(todos: TodoGenerator().fetch3Todos())
                
                expect(currentTodos).toNot(equal(todosVM.todos))
            }
            
            it("Should filter todos based on settings") {
                store.state.authState.loginStatus = LoginStatus.loggedIn(uid: "test")
                let tableView = UITableView()
                let todosVM = TodosVM(tableView: tableView, fetcher: MockTodoFetcher())
                expect(todosVM.todos.count).to(equal(3))
                
                todosVM.showCompleted = true
                todosVM.reload()
                
                expect(todosVM.todos.count).to(equal(4))
            }
            
            it("Should appropriately handle my tableView") {
                store.state.authState.loginStatus = LoginStatus.loggedIn(uid: "test")
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "todos") as! TodoViewController
                vc.beginAppearanceTransition(true, animated: false)
                
                let tableView = vc.tableView!
                
                let mockFetcher = MockTodoFetcher()
                
                let vm = TodosVM(tableView: tableView, fetcher: mockFetcher)
                
                expect(tableView.numberOfRows(inSection: 0)).to(equal(3))
                let tableCell : Todo_TableViewCell? = vm.tableView(tableView, cellForRowAt: IndexPath(item: 0, section: 0)) as? Todo_TableViewCell
                
                expect(tableCell).toNot(beNil())
                expect(tableCell!.checkBox.backgroundColor).to(equal(UIColor.white))
                expect(tableCell!.lblText.text).to(equal("Text1"))
                
                let date = mockFetcher.todos[0].createdAt!
                let df = DateFormatter()
                df.dateFormat = "MMM dd, yyyy @ HH:mm a"
                let expectedString = "Created: \(df.string(from: date))"
                
//                expect(tableCell!.lblCreated.text).to(equal(expectedString))
            }
        }
    }
}

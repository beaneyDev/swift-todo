//
//  TodoVM_Test.swift
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

class TodoVM_Test: QuickSpec {
    //MARK: TESTS
    override func spec() {
        describe("Test presenter logic") {
            it("Should parse a todo and create a VM with certain props", closure: {
                let date = Date()
                let dict : [String : Any] = [
                    "completed" : false,
                    "createdAt" : date,
                    "text"      : "Test text"
                ]
                
                let todo    = Todo(key: "testKey", todos: dict)
                let vm      = TodoVM(todo: todo)
                
                let df = DateFormatter()
                df.dateFormat = "MMM dd, yyyy @ HH:mm a"
                let expectedString = "Created: \(df.string(from: date))"
                
                expect(vm.completed).to(equal(false))
                expect(vm.createdAt).to(equal(expectedString))
                expect(vm.text).to(equal("Test text"))
            })
        }
    }
}


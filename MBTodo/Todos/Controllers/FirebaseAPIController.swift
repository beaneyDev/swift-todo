//
//  FirebaseAPIController.swift
//  MBTodo
//
//  Created by Matt Beaney on 24/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation
import Firebase

extension DatabaseReference : TodoDataSource {}

class FirebaseTodoController : TodoFetcher {
    func observeTodos(uid: String, completion: @escaping (_ todos: [Todo]?, _ error: Error?) -> ()) -> TodoDataSource {
        let ref = Database.database().reference()
        
        ref.child("users").child(uid).child("todos").observe(.value, with: { (snapshot) in
            guard let value = snapshot.value as? Dictionary<String, Any> else {
                completion(nil, nil)
                return
            }
            
            completion(self.mapFirebaseObjects(dict: value), nil)
        }) { (error) in
            completion(nil, error)
        }
        
        return ref
    }
    
    func addTodo(uid: String, todoText: String) {
        let ref = Database.database().reference()
        let todo: [String : Any] = [
            "completed": false,
            "createdAt": Int(Date().timeIntervalSince1970),
            "text": todoText
        ]
        
        ref.child("users").child(uid).child("todos").childByAutoId().setValue(todo)
    }
    
    func toggleTodo(uid: String, todo: Todo) {
        let ref = Database.database().reference()
        let todoUpdated : [String : Any] = [
            "completed"     : !(todo.completed ?? true),
            "createdAt"     : (todo.createdAt ?? Date()).timeIntervalSince1970,
            "text"          : todo.text ?? "",
            "completedAt"   : Int(Date().timeIntervalSince1970)
        ]
        ref.child("users").child(uid).child("todos").child(todo.key ?? "").setValue(todoUpdated)
    }
    
    func mapFirebaseObjects(dict: Dictionary<String, Any>) -> [Todo]? {
        let todoList: [Todo] = dict.keys.flatMap {
            if let todo = dict[$0] as? Dictionary<String, Any> {
                return Todo(key: $0, todos: todo)
            }
            
            return nil
        }
        
        let sortedList: [Todo] = todoList.sorted {
            return ($0.0.createdAt ?? Date()).isGreaterThanDate($0.1.createdAt ?? Date())
        }.reversed()
        
        return sortedList
    }
}

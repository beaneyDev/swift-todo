//
//  Dictionary+OptionalSubscript.swift
//  MBTodo
//
//  Created by Matt Beaney on 24/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation

extension Dictionary where Key == String {
    func obj<T>(for key: String) -> T? {
        return self[key] as? T
    }
    
    func dateFromTimeStamp(with key: String) -> Date? {
        if let obj: Int = self.obj(for: key) {
            return Date(timeIntervalSince1970: TimeInterval(obj))
        }
        
        return nil
    }
}

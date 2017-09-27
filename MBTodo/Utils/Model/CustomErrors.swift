//
//  CustomError.swift
//  MBTodo
//
//  Created by Matt Beaney on 27/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation

class CustomErrors {
    static var POST_BODY_INIT_FAILED: NSError = NSError(domain: "com.mb.todo", code: 2001, userInfo: nil)
    
    
    struct GitHub {
        static var NO_ACCESS_TOKEN: NSError = NSError(domain: "com.mb.todo", code: 2021, userInfo: nil)
    }
}

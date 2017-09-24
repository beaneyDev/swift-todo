//
//  Actions_Launch.swift
//  MBTodo
//
//  Created by Matt Beaney on 21/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation
import Firebase
import ReSwift

struct StartFirebase: Action {
    var successful: Bool
}

class Actions_Launch {
    static func startFirebase() -> Action? {
        guard
            let fireBaseConfigFile = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
            let firOptions = FirebaseOptions(contentsOfFile: fireBaseConfigFile)
        else
        {
            assert(false, "Failed to load Firebase config file")
            return StartFirebase(successful: false)
        }
        
        FirebaseApp.configure(options: firOptions)
        return StartFirebase(successful: false)
    }
}

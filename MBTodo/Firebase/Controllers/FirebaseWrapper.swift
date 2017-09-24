//
//  FirebaseWrapper.swift
//  MBTodo
//
//  Created by Matt Beaney on 21/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation
import Firebase

class FirebaseWrapper {
    static func initaliseFireBase() {
        guard
            let fireBaseConfigFile = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
            let firOptions = FirebaseOptions(contentsOfFile: fireBaseConfigFile)
        else
        {
            assert(false, "Failed to load Firebase config file")
            return
        }
        
        FirebaseApp.configure(options: firOptions)
    }
}

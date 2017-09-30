//
//  TodoDateFormatter.swift
//  MBTodo
//
//  Created by Matt Beaney on 30/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation

class TodoDateFormatter {
    static var shared = TodoDateFormatter()
    var createdAtFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMM dd, yyyy @ HH:mm a"
        return df
    }()
}

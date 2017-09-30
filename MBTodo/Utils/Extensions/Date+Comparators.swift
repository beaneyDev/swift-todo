//
//  Date+Comparators.swift
//  MBTodo
//
//  Created by Matt Beaney on 28/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation

extension Date {
    func isGreaterThanDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
}

//
//  Date+Comparators_Test.swift
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

class Date_Extension_Test: QuickSpec {
    //MARK: TESTS
    override func spec() {
        describe("Date comparison extension tests") {
            it("Should compare 2 dates", closure: {
                let date1 = Date()
                let date2 = Date().addingTimeInterval(3000)
                let is1GreaterThan2 = date1.isGreaterThanDate(date2)
                let is2GreaterThan1 = date2.isGreaterThanDate(date1)
                
                expect(is1GreaterThan2).to(beFalse())
                expect(is2GreaterThan1).to(beTrue())
            })
        }
    }
}

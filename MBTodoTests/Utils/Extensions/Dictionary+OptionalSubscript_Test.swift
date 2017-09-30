//
//  HTTPClient_Test.swift
//  MBTodo
//
//  Created by Matt Beaney on 24/09/2017.
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

class Dictionary_Extension_Test: QuickSpec {
    //MARK: TESTS
    override func spec() {
        describe("Dict extension tests") {
            it("Should optionally subscript an item of a certain type.", closure: {
                let testData: Dictionary<String, Any> = [
                    "test1" : "string",
                    "test2" : 2,
                    "test3" : true
                ]
                
                let test1 : String? = testData.obj(for: "test1")
                let test2 : Int? = testData.obj(for: "test2")
                let test3 : Bool? = testData.obj(for: "test3")
                
                expect(test1).to(equal("string"))
                expect(test2).to(equal(2))
                expect(test3).to(equal(true))
                
                let test4 : Int? = testData.obj(for: "test1")
                expect(test4).to(beNil())
            })
            
            it("Should optionally unwrap a valid date, if the date string isn't nil") {
                let testData : Dictionary<String, Any> = [
                    "test1" : 1506786689
                ]
                
                let date : Date? = testData.dateFromTimeStamp(with: "test1")
                expect(date).toNot(beNil())
                
                let date2 : Date? = testData.dateFromTimeStamp(with: "test3")
                expect(date2).to(beNil())
            }
        }
    }
}


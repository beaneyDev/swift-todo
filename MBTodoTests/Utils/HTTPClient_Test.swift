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

class MockURLSession : URLSessionProtocol {
    var nextDataTask: URLSessionDataTaskProtocol = MockURLSessionDataTask()
    
    func dataTaskWithURL(url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return self.nextDataTask
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    var hasResumed: Bool = false
    func resume() {
        self.hasResumed = true
    }
}

class HTTPClient_Test: QuickSpec {
    override func spec() {
        describe("Test for Network requests.") {
            it("Should return a response for a valid request.", closure: {
                let nextDataTask = MockURLSessionDataTask()
                let mockSession = MockURLSession()
                mockSession.nextDataTask = nextDataTask
                
                let url = URL(string: "http://google.com")!
                
                let _ = HTTPController().request(session: mockSession, url: url, completion: { (response) in })
                expect(nextDataTask.hasResumed).to(beTrue())
            })
        }
        
        describe("Integration test for network") {
            it("should return data for a decent URL") {
                let url = URL(string: "http://google.com")!
                var data: Data?
                let _ = HTTPController().request(session: URLSession.shared, url: url, completion: { (response) in
                    if case let HTTPResponse.result(unwrappedData) = response {
                        data = unwrappedData
                    }
                })
                
                expect(data).toEventuallyNot(beNil())
            }
        }
     }
}

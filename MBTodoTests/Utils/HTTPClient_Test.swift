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
    var nextData: Data?
    var nextError: Error?
    var nextDataTask: URLSessionDataTaskProtocol = MockURLSessionDataTask()
    
    func dataTaskWithURL(url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        completionHandler(nextData, nil, nextError)
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
        describe("Flat network requests.") {
            it("Should resume the session when called.", closure: {
                let nextDataTask = MockURLSessionDataTask()
                let mockSession = MockURLSession()
                mockSession.nextDataTask = nextDataTask
                
                let url = URL(string: "http://google.com")!
                
                let _ = HTTPController().request(session: mockSession, url: url, completion: { (response) in })
                expect(nextDataTask.hasResumed).to(beTrue())
            })
            
            it("should return data for a valid URL") {
                let nextDataTask = MockURLSessionDataTask()
                let mockSession = MockURLSession()
                mockSession.nextDataTask = nextDataTask
                
                let expectedData = "{}".data(using: String.Encoding.utf8)
                mockSession.nextData = expectedData
                
                let url = URL(string: "http://google.com")!
                
                var actualData: Data?
                let _ = HTTPController().request(session: mockSession, url: url, completion: { (response) in
                    if case let HTTPResponse.result(data: data) = response {
                        actualData = data
                    }
                })
                
                expect(actualData).toEventually(equal(expectedData))
            }
            
            it("should error when a network request fails") {
                let nextDataTask = MockURLSessionDataTask()
                let mockSession = MockURLSession()
                mockSession.nextDataTask = nextDataTask
                
                let expectedError = NSError(domain: "test", code: 500, userInfo: [:]) as Error
                mockSession.nextError = expectedError
                
                let url = URL(string: "http://google.com")!
                
                var actualError: Error?
                let _ = HTTPController().request(session: mockSession, url: url, completion: { (response) in
                    if case let HTTPResponse.error(error: error) = response {
                        actualError = error
                    }
                })
                
                expect(actualError).toEventually(be(expectedError))
            }
        }
        
        describe("Integration tests") {
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

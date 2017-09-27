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

class HTTPClient_Test: QuickSpec {
    //MARK: TESTS
    override func spec() {
        describe("GET Tests") {
            it("Should resume the session when called.", closure: {
                let nextDataTask = MockURLSessionDataTask()
                let mockSession = MockURLSession()
                mockSession.nextDataTask = nextDataTask
                
                let url = URL(string: "http://google.com")!
                
                let _ = HTTPController().get(session: mockSession, url: url, completion: { (response) in })
                expect(nextDataTask.hasResumed).to(beTrue())
            })
            
            it("should return data for a valid URL in a GET request") {
                let nextDataTask = MockURLSessionDataTask()
                let mockSession = MockURLSession()
                mockSession.nextDataTask = nextDataTask
                
                let expectedData = "{}".data(using: String.Encoding.utf8)
                mockSession.nextData = expectedData
                
                let url = URL(string: "http://google.com")!
                
                var actualData: Data?
                let _ = HTTPController().get(session: mockSession, url: url, completion: { (response) in
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
                let _ = HTTPController().get(session: mockSession, url: url, completion: { (response) in
                    if case let HTTPResponse.error(error: error) = response {
                        actualError = error
                    }
                })
                
                expect(actualError).toEventually(be(expectedError))
            }
        }
        
        describe("POST Tests") {
            it("Should resume the session when called.", closure: {
                let nextDataTask = MockURLSessionDataTask()
                let mockSession = MockURLSession()
                mockSession.nextDataTask = nextDataTask
                let url = URL(string: "http://google.com")!
                let _ = HTTPController().post(session: mockSession, url: url, headers: self.fetchDefaultHeaders(), body: self.fetchDefaultBody(), completion: { (response) in })
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
                let _ = HTTPController().post(session: mockSession, url: url, headers: self.fetchDefaultHeaders(), body: self.fetchDefaultBody(), completion: { (response) in
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
                let _ = HTTPController().post(session: mockSession, url: url, headers: self.fetchDefaultHeaders(), body: self.fetchDefaultBody(), completion: { (response) in
                    if case let HTTPResponse.error(error: error) = response {
                        actualError = error
                    }
                })
                
                expect(actualError).toEventually(be(expectedError))
            }
            
            it("should apply headers and body to the URLRequest") {
                let nextDataTask = MockURLSessionDataTask()
                let mockSession = MockURLSession()
                let headers = self.fetchDefaultHeaders()
                let body = self.fetchDefaultBody()
                mockSession.nextDataTask = nextDataTask
                
                let url = URL(string: "http://google.com")!
                let _ = HTTPController().post(session: mockSession, url: url, headers: self.fetchDefaultHeaders(), body: self.fetchDefaultBody(), completion: { (response) in })
                
                expect(mockSession.nextReq?.allHTTPHeaderFields).to(equal(headers))
                
                if let data = try? JSONSerialization.data(withJSONObject: body, options: []) {
                    expect(mockSession.nextReq?.httpBody).to(equal(data))
                }
            }
        }
        
        describe("Integration tests") {
            it("should return data for a decent URL") {
                let url = URL(string: "http://google.com")!
                var data: Data?
                let _ = HTTPController().get(session: URLSession.shared, url: url, completion: { (response) in
                    if case let HTTPResponse.result(unwrappedData) = response {
                        data = unwrappedData
                    }
                })
                
                expect(data).toEventuallyNot(beNil())
            }
        }
     }
    
    //MARK: HELPER FUNCTIONS
    func fetchDefaultHeaders() -> [String : String] {
        return [
            "Content-Type" : "application/json",
            "Accept" : "application/json"
        ]
    }
    
    func fetchDefaultBody() -> [String : String] {
        return [
            "client_id": "test_client_id",
            "client_secret": "test_client_secret",
            "code": "test_code",
            "state": "test_state"
        ]
    }
}

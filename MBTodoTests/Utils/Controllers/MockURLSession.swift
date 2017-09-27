//
//  MockURLSession.swift
//  MBTodoTests
//
//  Created by Matt Beaney on 27/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation
@testable import MBTodo

class MockURLSession : URLSessionProtocol {
    var nextData: Data?
    var nextError: Error?
    var nextDataTask: URLSessionDataTaskProtocol = MockURLSessionDataTask()
    var nextReq: URLRequest?
    
    func dataTaskWithURL(url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        completionHandler(nextData, nil, nextError)
        return self.nextDataTask
    }
    
    func dataTaskWithRequest(req: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        self.nextReq = req
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

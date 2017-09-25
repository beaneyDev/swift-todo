//
//  URLSessionProtocol.swift
//  MBTodo
//
//  Created by Matt Beaney on 25/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTaskWithURL(url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

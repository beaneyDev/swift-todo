//
//  Networkable.swift
//  MBTodo
//
//  Created by Matt Beaney on 24/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation

typealias NetworkCompletion = (HTTPResponse) -> ()

protocol Networkable {
    func request(session: URLSessionProtocol, url: URL, completion: @escaping NetworkCompletion) -> URLSessionDataTaskProtocol?
    func request(url: URL, completion: @escaping NetworkCompletion) -> URLSessionDataTaskProtocol?
    func request(url: String, completion: @escaping NetworkCompletion) -> URLSessionDataTaskProtocol?
}

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
    func get(session: URLSessionProtocol, url: URL, completion: @escaping NetworkCompletion) -> URLSessionDataTaskProtocol?
    func get(url: URL, completion: @escaping NetworkCompletion) -> URLSessionDataTaskProtocol?
    func get(url: String, completion: @escaping NetworkCompletion) -> URLSessionDataTaskProtocol?
    
    func post(url: String, headers: [String: String], body: [String : String], completion: @escaping (HTTPResponse) -> ()) -> URLSessionDataTaskProtocol?
    func post(url: URL, headers: [String: String], body: [String : String], completion: @escaping (HTTPResponse) -> ()) -> URLSessionDataTaskProtocol?
    func post(session: URLSessionProtocol, url: URL, headers: [String: String], body: [String : String], completion: @escaping (HTTPResponse) -> ()) -> URLSessionDataTaskProtocol?
}

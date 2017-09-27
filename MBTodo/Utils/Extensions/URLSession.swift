//
//  URLSession.swift
//  MBTodo
//
//  Created by Matt Beaney on 25/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation

extension URLSession : URLSessionProtocol {
    func dataTaskWithRequest(req: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return (dataTask(with: req, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
    
    func dataTaskWithURL(url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return (dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
}
extension URLSessionDataTask : URLSessionDataTaskProtocol {}

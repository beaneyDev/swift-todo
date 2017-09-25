//
//  HTTPClient.swift
//  MBTodo
//
//  Created by Matt Beaney on 24/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation

enum HTTPResponse {
    case result(data: Data)
    case error(error: Error)
    case noResult
}

class HTTPController: Networkable {
    func request(url: String, completion: @escaping (HTTPResponse) -> ()) -> URLSessionDataTaskProtocol? {
        return nil
    }
    
    func request(url: URL, completion: @escaping (HTTPResponse) -> ()) -> URLSessionDataTaskProtocol? {
        return nil
    }
    
    func request(session: URLSessionProtocol, url: URL, completion: @escaping (HTTPResponse) -> ()) -> URLSessionDataTaskProtocol? {
        let dataTask = session.dataTaskWithURL(url: url) { (data, response, error) in
            if let data = data {
                completion(HTTPResponse.result(data: data))
                return
            }
            
            if let error = error {
                completion(HTTPResponse.error(error: error))
                return
            }
            
            completion(HTTPResponse.noResult)
        }
        
        dataTask.resume()
        return dataTask
    }
}

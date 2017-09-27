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
    
    //MARK: Get requests.
    
    /**
     - parameters:
     - url: This is a string representing the URL that the GET must call.
     - completion: The completion handler of the consumer class.
     - returns: A dataTask that can be cancelled by the consumer class if necessary.
     */
    func get(url: String, completion: @escaping (HTTPResponse) -> ()) -> URLSessionDataTaskProtocol? {
        //TODO: Fill this bad boy out.
        return nil
    }
    
    /**
     - parameters:
     - url: This is a URL object representing the URL that the GET must call.
     - completion: The completion handler of the consumer class.
     - returns: A dataTask that can be cancelled by the consumer class if necessary.
     */
    func get(url: URL, completion: @escaping (HTTPResponse) -> ()) -> URLSessionDataTaskProtocol? {
        return nil
    }
    
    /**
     This function is where the heavy lifting is done, and hence the one we test.
     - parameters:
     - session: This is usually a URLSession, but may be mocked in order to test.
     - url: This is a URL object representing the URL that the GET must call.
     - completion: The completion handler of the consumer class.
     - returns: A dataTask that can be cancelled by the consumer class if necessary.
     */
    func get(session: URLSessionProtocol, url: URL, completion: @escaping (HTTPResponse) -> ()) -> URLSessionDataTaskProtocol? {
        let dataTask = session.dataTaskWithURL(url: url) { (data, response, error) in
            self.handleData(data: data, response: response, error: error, completion: completion)
        }
        
        dataTask.resume()
        return dataTask
    }
    
    //MARK: POST Requests.
    
    /**
     - parameters:
     - url: This is a string representing the URL that the POST must call.
     - headers: Any headers the consumer would like to pass into the POST.
     - body: Any body parameters needed in the POST.
     - completion: The completion handler of the consumer class.
     - returns: A dataTask that can be cancelled by the consumer class if necessary.
     */
    func post(url: String, headers: [String: String], body: [String : String], completion: @escaping (HTTPResponse) -> ()) -> URLSessionDataTaskProtocol? {
        if let objURL = URL(string: url) {
            return post(url: objURL, headers: headers, body: body, completion: completion)
        }
        return nil
    }
    
    /**
     - parameters:
     - url: This is a URL object representing the URL that the POST must call.
     - headers: Any headers the consumer would like to pass into the POST.
     - body: Any body parameters needed in the POST.
     - completion: The completion handler of the consumer class.
     - returns: A dataTask that can be cancelled by the consumer class if necessary.
     */
    func post(url: URL, headers: [String: String], body: [String : String], completion: @escaping (HTTPResponse) -> ()) -> URLSessionDataTaskProtocol? {
        return post(session: URLSession.shared, url: url, headers: headers, body: body, completion: completion)
    }
    
    /**
     This function is where the heavy lifting is done, and hence the one we test.
     - parameters:
     - session: This is usually a URLSession, but may be mocked in order to test.
     - url: This is a URL object representing the URL that the POST must call.
     - headers: Any headers the consumer would like to pass into the POST.
     - body: Any body parameters needed in the POST.
     - completion: The completion handler of the consumer class.
     - returns: A dataTask that can be cancelled by the consumer class if necessary.
     */
    func post(session: URLSessionProtocol, url: URL, headers: [String: String], body: [String : String], completion: @escaping (HTTPResponse) -> ()) -> URLSessionDataTaskProtocol? {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        //Set any headers.
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        guard
            let data = try? JSONSerialization.data(withJSONObject: body, options: [])
            else
        {
            completion(HTTPResponse.error(error: CustomErrors.POST_BODY_INIT_FAILED))
            return nil
        }
        
        //Set body.
        request.httpBody = data
        
        let task = session.dataTaskWithRequest(req: request) { (data, response, error) in
            self.handleData(data: data, response: response, error: error, completion: completion)
        }
        
        //Fire!
        task.resume()
        return task
    }
    
    //MARK: Response handlers.
    
    /**
     Simple helper function responsible for handling the response from a request.
     - parameters:
     - data: Optional data that could be returned from the request.
     - error: Optional error that could be returned from the request.
     - response: Optional response that could be return from the request (currently not handled).
     */
    func handleData(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (HTTPResponse) -> ()) {
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
}

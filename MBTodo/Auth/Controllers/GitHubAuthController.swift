//
//  GitHubTokenRequest.swift
//  MBTodo
//
//  Created by Matt Beaney on 23/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation

class GitHubAuthController : OAuthTokenFetcher {
    func fetchToken(url: URL, completion: @escaping (_ token: String?, _ error: Error?) -> ()) {
        
    }
    
    func fetchToken(networker: Networkable, url: URL, completion: @escaping (_ token: String?, _ error: Error?) -> ()) {
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: GitHubStrings.tokenURL)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        
        
        var code = url.absoluteString.components(separatedBy: "://?code=")[1]
        code = code.components(separatedBy: "&")[0]
        
        let dict =  [
            "client_id": "df6b508bc92edc6cdb8c",
            "client_secret": "819dc555f87766b8cdb8f3974c18bbd42b69495f",
            "code": code,
            "state": "asdad"
        ]
        
        guard
            let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
            else
        {
            completion(nil, nil)
            return
        }
        
        request.httpBody = data
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard
                let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments), let dict = json as? NSDictionary,
                let accessToken = dict["access_token"] as? String,
                error == nil
                else
            {
                completion(nil, error)
                return
            }
            
            completion(accessToken, nil)
        })
        
        task.resume();
    }
}

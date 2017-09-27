//
//  GitHubTokenRequest.swift
//  MBTodo
//
//  Created by Matt Beaney on 23/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation

typealias GitHubCompletion = (_ token: String?, _ error: Error?) -> ()

class GitHubAuthController : OAuthTokenFetcher {
    func fetchToken(url: URL, completion: @escaping GitHubCompletion) {
        fetchToken(networker: HTTPController(), url: url, completion: completion)
    }
    
    
    func fetchToken(networker: Networkable, url: URL, completion: @escaping GitHubCompletion) {
        let headers = [
            "Content-Type" : "application/json",
            "Accept" : "application/json"
        ]
        
        var code = url.absoluteString.components(separatedBy: "://?code=")[1]
        code = code.components(separatedBy: "&")[0]
        
        let body =  [
            "client_id": "df6b508bc92edc6cdb8c",
            "client_secret": "819dc555f87766b8cdb8f3974c18bbd42b69495f",
            "code": code,
            "state": "asdad"
        ]
        
        let _ = HTTPController().post(url: GitHubStrings.tokenURL, headers: headers, body: body) { (response) in
            switch response {
            case .result(data: let data):
                self.handleData(data: data, completion: completion)
                return
            case .error(error: let error):
                completion(nil, error)
                return
            case .noResult:
                completion(nil, nil)
                return
            }
        }
    }
    
    func handleData(data: Data, completion: @escaping GitHubCompletion) {
        if
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments), let dict = json as? NSDictionary,
            let accessToken = dict["access_token"] as? String {
            completion(accessToken, nil)
        } else {
            completion(nil, CustomErrors.GitHub.NO_ACCESS_TOKEN)
        }
    }
}

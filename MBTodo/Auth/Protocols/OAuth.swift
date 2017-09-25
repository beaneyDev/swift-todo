//
//  OAuth.swift
//  MBTodo
//
//  Created by Matt Beaney on 24/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation

protocol OAuthTokenFetcher {
    func fetchToken(url: URL, completion: @escaping (_ token: String?, _ error: Error?) -> ())
}

protocol OAuthTokenValidator {
    func validateToken(token: String, completion: @escaping (String?, Error?) -> ())
}

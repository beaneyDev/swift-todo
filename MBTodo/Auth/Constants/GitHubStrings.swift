//
//  AuthStrings.swift
//  MBTodo
//
//  Created by Matt Beaney on 23/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation

class GitHubStrings {
    static var DOMAIN                   : String = "http://github.com"
    static var AUTHORISE_ENDPOINT       : String = "/login/oauth/authorize"
    static var TOKEN_ENDPOINT           : String = "/login/oauth/access_token"
    static var CLIENT_ID                : String = "df6b508bc92edc6cdb8c"
    static var REDIRECT_URI             : String = "https://oauth-forwarder.herokuapp.com/redir_mobile.php"
    
    static var authoriseURL : String {
        return "\(DOMAIN)\(AUTHORISE_ENDPOINT)?client_id=\(CLIENT_ID)&redirect_uri=\(REDIRECT_URI)"
    }
    
    static var tokenURL: String {
        return "\(DOMAIN)\(TOKEN_ENDPOINT)"
    }
}

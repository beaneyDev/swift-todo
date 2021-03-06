//
//  Firebase_Tests.swift
//  MBTodo
//
//  Created by Matt Beaney on 24/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

@testable import MBTodo

import Foundation
import FirebaseCore
import FirebaseAuth
import ReSwift
import XCTest

import Quick
import Nimble

class MockGitHubAuthController : OAuthTokenFetcher {
    func fetchToken(url: URL, completion: @escaping (_ token: String?, _ error: Error?) -> ()) {
        if url.absoluteString.contains("fail") {
            completion(nil, nil)
        } else {
            completion("yay", nil)
        }
    }
}

class MockFirebaseAuthController : OAuthTokenValidator {
    func validateToken(token: String, completion: @escaping (String?, Error?) -> ()) {
        if token.isEmpty {
            completion(nil, nil)
        } else {
            completion(token, nil)
        }
    }
}

class Auth_Tests: QuickSpec {
    override func spec() {
        describe("Tests For authentication") {
            var store = Store<State>(reducer: appReducer, state: nil)

            beforeEach {
                store = Store<State>(reducer: appReducer, state: nil)
            }
            
            it("Fetches the token from a URL, and dispatches an action to update the user.", closure: {
                store.dispatch(Actions_Auth.fetchToken(url: URL(string: "http://yay.com")!, fetcher: MockGitHubAuthController(), validator: MockFirebaseAuthController()))
                
                guard case let LoginStatus.loggedIn(uid: uid) = store.state.authState.loginStatus else {
                    expect(false).to(equal(true))
                    return
                }
                
                expect(uid).to(equal("yay"))
            })
            
            it("Fails to fetch a token from a URL, and does not update the store.") {
                store.dispatch(Actions_Auth.fetchToken(url: URL(string: "http://fail.com")!, fetcher: MockGitHubAuthController(), validator: MockFirebaseAuthController()))
                
                expect(store.state.authState).to(equal(State_Auth(loginStatus: .notLoggedIn)))
            }
        }
    }
}

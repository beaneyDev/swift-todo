//
//  ActivityPresentable_Test.swift
//  MBTodoTests
//
//  Created by Matt Beaney on 30/09/2017.
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

class MockViewController: UIViewController, ActivityPresentable {
    var activityBlocker: UIView?
    
    override func viewDidLoad() {
        self.presentActivityView(with: "Test")
    }
}

class ActivityPresentable_Test : QuickSpec {
    //MARK: TESTS
    override func spec() {
        describe("Dict extension tests") {
            it("Should present an activity view.", closure: {
                let vc = MockViewController()
                vc.beginAppearanceTransition(true, animated: false)
                expect(vc.activityBlocker).toNot(beNil())
                
                let labels: [UILabel]? = vc.activityBlocker?.subviews.filter {
                    $0 is UILabel
                } as? [UILabel]
                
                expect(labels).toNot(beNil())
                expect(labels?.count ?? 0).to(equal(1))
            })
        }
    }
}


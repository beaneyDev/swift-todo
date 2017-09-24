//
//  State.swift
//  SwiftFlowGitHubBrowser
//
//  Created by Benji Encz on 1/5/16.
//  Copyright © 2016 Benji Encz. All rights reserved.
//

import ReSwift

struct State: StateType {
    var authState   : State_Auth
    var todosState  : State_Todos
}

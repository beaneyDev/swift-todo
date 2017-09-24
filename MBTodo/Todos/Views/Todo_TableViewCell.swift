//
//  Todo_TableViewCell.swift
//  MBTodo
//
//  Created by Matt Beaney on 24/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation
import UIKit

class Todo_TableViewCell: UITableViewCell {
    //UI Components.
    @IBOutlet weak var lblText: UILabel!
    
    //State
    var todoVM: TodoVM?
    
    func configure(with vm: TodoVM) {
        self.todoVM = vm
        self.lblText.text = vm.text
    }
}

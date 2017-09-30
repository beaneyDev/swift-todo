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
    @IBOutlet weak var lblCreated: UILabel!
    @IBOutlet weak var checkBox: UIView! {
        didSet {
            checkBox.layer.cornerRadius     = 5.0
            checkBox.layer.borderColor      = UIColor.lightGray.cgColor
            checkBox.layer.borderWidth      = 0.8
        }
    }
    
    //State
    var todoVM: TodoVM?
    
    func configure(with vm: TodoVM) {
        self.todoVM = vm
        self.lblText.textColor  = vm.completed ? UIColor.lightGray : UIColor.black
        
        if vm.completed {
            let attrText = NSMutableAttributedString(string: vm.text)
            attrText.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attrText.length))
            self.lblText.attributedText = attrText
            
            let attrCreatedAt = NSMutableAttributedString(string: vm.createdAt)
            attrCreatedAt.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attrCreatedAt.length))
            self.lblCreated.attributedText = attrCreatedAt
        } else {
            self.lblText.attributedText = nil
            self.lblCreated.attributedText = nil
            
            self.lblText.text       = vm.text
            self.lblCreated.text    = vm.createdAt
        }
    }
}

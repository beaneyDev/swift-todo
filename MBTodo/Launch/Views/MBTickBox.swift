//
//  MBTickBox.swift
//  MBTodo
//
//  Created by Matt Beaney on 30/09/2017.
//  Copyright © 2017 MB. All rights reserved.
//

import Foundation
import UIKit

class MBTickBox: UIView {
    
    var image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "tick")!)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var blocker: UIView = {
        let blocker = UIView()
        blocker.translatesAutoresizingMaskIntoConstraints = false
        blocker.backgroundColor = UIColor.white
        return blocker
    }()
    
    var blockerWidth: NSLayoutConstraint?
    
    func configure() {
        self.addSubview(image)
        self.addSubview(blocker)
        
        let views = ["image": image, "blocker": blocker]
        
        let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|[image]|", options: [], metrics: nil, views: views)
        let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|[image]|", options: [], metrics: nil, views: views)
        self.addConstraints(horizontal)
        self.addConstraints(vertical)
        
        let vertical2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[blocker]-8-|", options: [], metrics: nil, views: views)
        let width = NSLayoutConstraint(item: self.blocker, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: -10)
        let right = NSLayoutConstraint(item: self.blocker, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -5.0)
        
        self.blockerWidth = width
        self.addConstraints(vertical2)
        self.addConstraints([width, right])
    }
    
    func tick(completion: @escaping () -> ()) {
        blockerWidth?.constant = -1000
        self.setNeedsLayout()
        UIView.animate(withDuration: 0.3, animations: {
            self.layoutIfNeeded()
        }) { (finished) in
            completion()
        }
    }
}

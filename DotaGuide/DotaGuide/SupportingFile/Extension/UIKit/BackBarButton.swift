//
//  BackBarButton.swift
//  CCIOS
//
//  Created by NTQuang on 3/2/17.
//  Copyright © 2017 ConcungLtd. All rights reserved.
//

import UIKit

class ErcBarButton: UIBarButtonItem {
    
    var actionBlock:(() -> Void)!
    
    override init() {
        super.init()
        self.image = UIImage(named: "ic_back")
        self.action = #selector(backBarButtonClick(sender:))
        self.tintColor = .white
        self.target = self
    }
    init(image: UIImage) {
        super.init()
        self.image = image
        self.action = #selector(backBarButtonClick(sender:))
        self.tintColor = .white
        self.target = self
    }
    init(title: String) {
        super.init()
        self.title = title
        self.action = #selector(backBarButtonClick(sender:))
        self.tintColor = .white
        self.target = self
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //Action
    @objc func backBarButtonClick(sender: UIBarButtonItem){
        if self.actionBlock != nil {
            actionBlock()
        }
    }
}

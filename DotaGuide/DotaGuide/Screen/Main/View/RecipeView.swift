//
//  RecipeView.swift
//  DotaGuide
//
//  Created by macOS on 8/25/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import UIKit
import FirebaseDatabase

class RecipeView: UIView {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var constraintimageMarginLeft: NSLayoutConstraint!
    
    var isUseIn = false
    var parrentID: String! = ""
    var id: String! {
        didSet{
            guard let id = id else {
                return
            }
            let path = "Items/\(id)"
            let ref = Database.database().reference(withPath: path)
            ref.observeSingleEvent(of: .value) {[weak self] (dataSnapshot) in
                self?.item = Items(snapshot: dataSnapshot)
            }
        }
    }
    
    private var item: Items? {
        didSet{
            guard let item = item else {
                return
            }
            image.setImageWithURLString(string: item.imageAvatar)
            name.text = "\(item.name) (\(item.cost))"
            if id != parrentID {
                recipeImage.isHidden = true
            } else {
                recipeImage.isHidden = false
            }
            if isUseIn {
                constraintimageMarginLeft.constant = 10
            } else {
                constraintimageMarginLeft.constant = 50
            }
        }
    }
}

//
//  MainItemCollectionViewCell.swift
//  DotaGuide
//
//  Created by macOS on 8/11/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import UIKit
import SDWebImage

class MainItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    var model: Heroes! {
        didSet{
            imageView.setImageWithURLString(string: model.imageAvatar)
        }
    }
    
    var item: Items!{
        didSet {
            imageView.setImageWithURLString(string: item.imageAvatar)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

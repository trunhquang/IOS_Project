//
//  MainTitleCollectionViewCell.swift
//  DotaGuide
//
//  Created by macOS on 8/11/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import UIKit

class MainTitleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    
    var title: String! {
        didSet{
            labelTitle.text = title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

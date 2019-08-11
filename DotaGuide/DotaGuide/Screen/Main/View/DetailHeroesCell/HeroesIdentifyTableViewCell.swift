//
//  HeroesIdentifyTableViewCell.swift
//  DotaGuide
//
//  Created by macOS on 8/11/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import UIKit

class HeroesIdentifyTableViewCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var labelSub: UILabel!
    @IBOutlet weak var labelName: UILabel!
    
    var model: Heroes! {
        didSet{
            avatar.setImageWithURLString(string: model.imageAvatar)
            labelName.text = model.name
            labelSub.text = model.subName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

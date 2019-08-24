//
//  AdvancedStatisicsTableViewCellTableViewCell.swift
//  DotaGuide
//
//  Created by macOS on 8/24/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import UIKit

class AdvancedStatisicsTableViewCellTableViewCell: UITableViewCell {
    @IBOutlet weak var labelAffiliantion: UILabel!
    @IBOutlet weak var labelDamage: UILabel!
    @IBOutlet weak var labelArmor: UILabel!
    @IBOutlet weak var labelAttackRange: UILabel!
    @IBOutlet weak var labelAttackAnimation: UILabel!
    @IBOutlet weak var labelCastingAnimation: UILabel!
    @IBOutlet weak var labelMissile: UILabel!
    @IBOutlet weak var labelSightRange: UILabel!
    @IBOutlet weak var labelBaseAttackTime: UILabel!
    @IBOutlet weak var labelMovespeed: UILabel!
    @IBOutlet weak var imageBackGround: UIImageView!
    @IBOutlet weak var labelIntroduction: UILabel!
    @IBOutlet weak var labelStory: UILabel!
    
    var model: Heroes! {
        didSet{
            let dic = model.statisicsDic
            labelAffiliantion.text = dic["Affiliation"]
            labelDamage.text = dic["Damage"]
            labelArmor.text = dic["Armor"]
            labelAttackRange.text = dic["Attack Range"]
            labelAttackAnimation.text = dic["Attack Animation"]
            labelCastingAnimation.text = dic["Casting Animation"]
            labelMissile.text = dic["Missile Speed"]
            labelSightRange.text = dic["Sight Range"]
            labelBaseAttackTime.text = dic["Base Attack Time"]
            labelMovespeed.text = dic["Movespeed"]
            imageBackGround.setImageWithURLString(string: "http://www.playcybergames.com/dota/images/heroes/arts/\(model.id).jpg")
            labelIntroduction.text = dic["Introduction"]
            labelStory.text = dic["Story"]
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

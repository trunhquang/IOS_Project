//
//  HeroesAttributesTableViewCell.swift
//  DotaGuide
//
//  Created by macOS on 8/11/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import UIKit

class HeroesAttributesTableViewCell: UITableViewCell {
    @IBOutlet weak var imageStrength: UIImageView!
    @IBOutlet weak var imageIntelligence: UIImageView!
    @IBOutlet weak var imageAgility: UIImageView!
    @IBOutlet weak var labelStrengthAttributes: UILabel!
    @IBOutlet weak var labelAgilityAttributes: UILabel!
    @IBOutlet weak var labelIntelligenceAttributes: UILabel!

    var model: Heroes! {
        didSet{
            if let agilityAttributes = model.attributes["Agility"] as? [String] {
                imageAgility.setImageWithURLString(string: baseURL + (agilityAttributes.last ?? ""))
                labelAgilityAttributes.text = agilityAttributes.first ?? ""
            }
            if let attributes = model.attributes["Intelligence"] as? [String] {
                imageIntelligence.setImageWithURLString(string: baseURL + (attributes.last ?? ""))
                labelIntelligenceAttributes.text = attributes.first ?? ""
            }
            if let attributes = model.attributes["Strength"] as? [String] {
                imageStrength.setImageWithURLString(string: baseURL + (attributes.last ?? ""))
                labelStrengthAttributes.text = attributes.first ?? ""
            }
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

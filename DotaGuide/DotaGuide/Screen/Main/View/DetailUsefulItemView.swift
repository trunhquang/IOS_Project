//
//  DetailUsefulItemView.swift
//  DotaGuide
//
//  Created by macOS on 8/25/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import UIKit

class DetailUsefulItemView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var labelTItle: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    
    var title: String!{
        didSet{
            labelTItle.text = title
        }
    }
    
    var values: [String]!{
        didSet{
            labelContent.attributedText = getAttributeText(values: values)
        }
    }
    
    var realheight: CGFloat {
        return contentView.h
    }
}

extension DetailUsefulItemView {
    private func getAttributeText(values: [String]) -> NSMutableAttributedString{
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.left
        
        let mutableAttributedString = NSMutableAttributedString()
        
        for value in values {
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: "sword")
            attachment.bounds = CGRect(x: 0, y: 0, w: 30, h: 6)
            let attachmentString = NSAttributedString(attachment: attachment)
            
            let attributeText = NSMutableAttributedString(
                string: "   \(value) \n",
                attributes: [
                    NSAttributedString.Key.paragraphStyle : paragraphStyle
                ]
            )
            attributeText.insert(attachmentString, at: 0)
            mutableAttributedString.append(attributeText)
        }
        return mutableAttributedString
    }
}

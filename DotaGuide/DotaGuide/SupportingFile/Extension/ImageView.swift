//
//  ImageView.swift
//  DotaGuide
//
//  Created by macOS on 8/11/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    func setImageWithURLString(string: String, placeholder: UIImage? = nil, supperView: UIView? = nil, complete: ((_ width: CGFloat?, _ height: CGFloat?) -> Void)? = nil){
        let urlString = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: urlString)
        guard supperView != nil else {
            self.sd_setImage(with: url, placeholderImage: placeholder, options: []) { (image, _, _, _) in
                complete?(self.image?.size.width,self.image?.size.height)
            }
            return
        }
        var loadding: UIActivityIndicatorView!
        for view in  self.superview!.subviews {
            if view.className == UIActivityIndicatorView.className{
                loadding = view as? UIActivityIndicatorView
            }
        }
        if loadding == nil {
            loadding = UIActivityIndicatorView()
            loadding.style = .gray
            superview!.addSubview(loadding)
            loadding.translatesAutoresizingMaskIntoConstraints = false
            
            let horizontalConstraint = NSLayoutConstraint(item: loadding, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            let verticalConstraint = NSLayoutConstraint(item: loadding, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
            let widthConstraint = NSLayoutConstraint(item: loadding, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
            let heightConstraint = NSLayoutConstraint(item: loadding, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
            supperView!.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        }
        
        loadding.startAnimating()
        
        self.sd_setImage(with: url, placeholderImage: placeholder, options: []) { (image, _, _, _) in
            DispatchQueue.main.async {
                loadding.stopAnimating()
            }
            complete?(self.image?.size.width,self.image?.size.height)
        }
    }
}


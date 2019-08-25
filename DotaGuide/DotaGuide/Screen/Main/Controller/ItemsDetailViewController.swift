//
//  ItemsDetailViewController.swift
//  DotaGuide
//
//  Created by macOS on 8/25/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ItemsDetailViewController: UIViewController {
    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var labelItemName: UILabel!
    @IBOutlet weak var labelSubName: UILabel!
    @IBOutlet weak var stackRecipeView: UIStackView!
    @IBOutlet weak var imageItemRecipe: UIImageView!
    @IBOutlet weak var labelItemNameRecipe: UILabel!
    @IBOutlet weak var labelCost: UILabel!
    
    @IBOutlet weak var labelShop: UILabel!
    @IBOutlet weak var labelBonus: UILabel!
    @IBOutlet weak var labelDetail: UILabel!
    @IBOutlet weak var stackViewUseIn: UIStackView!
    @IBOutlet weak var useInImage: UIImageView!
    @IBOutlet weak var useInItemName: UILabel!
    
    @IBOutlet weak var stackViewDetail: UIStackView!
    
    var model: Items!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ITEMS"
        navigationItem.leftBarButtonItem = backBarButton()
        setData()
    }
}

extension ItemsDetailViewController {
    private func setData(){
        imageItem.setImageWithURLString(string: model.imageAvatar)
        imageItemRecipe.setImageWithURLString(string: model.imageAvatar)
        labelItemName.text = model.name
        labelItemNameRecipe.text = "\(model.name) Recipe"
        labelSubName.text = model.sortDes
        labelCost.text = model.cost
        
        if let list = model.dicInfo["Recipe"] as? [String] {
            stackRecipeView.isHidden = false
            for ob in list {
                let view = RecipeView.loadNib()
                stackRecipeView.addArrangedSubview(view)
                view.parrentID = model.id
                view.id = ob
            }
        } else {
            stackRecipeView.isHidden = true
        }
        
        labelShop.text = model.dicInfo["Shop"] as? String  ?? ""
        labelDetail.text = model.dicInfo["Details"] as? String  ?? ""
        if let bonus = model.dicInfo["Bonus"] as? [String] {
            let text = bonus.joined(separator: "\n")
            labelBonus.text = text
        } else {
            labelBonus.text = ""
        }
        
        if let usedIn = model.dicInfo["Used in"] as? [String] {
            for ob in usedIn {
                let view = RecipeView.loadNib()
                stackViewUseIn.insertArrangedSubview(view, at: 0)
                view.isUseIn = true
                view.id = ob
            }
        }
        
        let defaultKey = ["Used in", "Recipe", "Bonus", "Details", "Shop"]
        for (key, value) in model.dicInfo {
            if !defaultKey.contains(key) {
                let view = DetailUsefulItemView.loadNib()
                view.title = key
                view.values = value as? [String]
                view.layoutIfNeeded()
                view.height(constant: view.realheight)
                stackViewDetail.addArrangedSubview(view)
            }
        }
    }
}

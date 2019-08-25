//
//  ItemsIndicatorInfoController.swift
//  DotaGuide
//
//  Created by macOS on 8/3/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import FirebaseDatabase

enum ShopType: String {
    case AncientofWonders       = "Ancient of Wonders"
    case AncientWeaponry        = "Ancient Weaponry"
    case ArcaneSanctum          = "Arcane Sanctum"
    case CacheofQuel            = "Cache of Quel-thelan"
    case EnchantedArtifact      = "Enchanted Artifacts"
    case GatewayRelics          = "Gateway Relics"
    case LeragastheVile         = "Leragas the Vile"
    case Protectorate           = "Protectorate"
    case SenatheAccesorizer     = "Sena the Accesorizer"
    case SupportiveVestments    = "Supportive Vestments"
    case WeaponDealer           = "Weapon Dealer"
    
    static let numberValue = 11
}

class ItemsIndicatorInfoController: IndicatorInfoController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override var itemInfo: IndicatorInfo {
        return IndicatorInfo(title: "Items", image: nil)
    }
    var itemsRef = Database.database().reference(withPath: "Items")
//    var heroesRef = Database.database().reference(withPath: "Heros")
    
    private var items: [Items]?
    private var groups: [[Items]]?
    private var titlesIndex: [Int]?
    private var currentIndex = 0
    private var currentTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsRef.observe(.value) {[weak self] (dataSnapshot) in
            var newItems: [Items] = []
            for child in dataSnapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let groceryItem = Items(snapshot: snapshot) {
                    newItems.append(groceryItem)
                }
            }
            self?.createItemssData(datas: newItems)
            self?.setDataSource()
        }
    }
}

extension ItemsIndicatorInfoController: CommonFlowLayoutDelegate {
    func edgeInsets(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0)
    }
    
    func lineSpacing(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout) -> CGFloat {
        return 10
    }
    
    func interitemSpacing(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout) -> CGFloat {
        return 10
    }
    
    func numberOfColume(inCollectionView collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func itemWidth(forCollectionView collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> CGFloat {
        if isTitle(indexPath: indexPath) {
            return Screen.WIDTH
        }
        return (Screen.WIDTH - 50)/4
    }
    
    func itemHeight(forCollectionView collectionView: UICollectionView, atIndexPath indexPath: IndexPath, itemWidth: CGFloat) -> CGFloat {
        if isTitle(indexPath: indexPath) {
            return 25
        }
        return (Screen.WIDTH - 50)/4
    }
    
    func heightForCollectionView(_ collectionView: UICollectionView, height: CGFloat) {
    }
}

//MARK: - UICollectionView
extension ItemsIndicatorInfoController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = (items?.count ?? 0)
        if count > 0 {
            count += ShopType.numberValue
        }
        return count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isTitle(indexPath: indexPath) {
            let cell = collectionView.dequeueCell(ofType: MainTitleCollectionViewCell.self, indexPath: indexPath)
            cell.title = currentTitle
            return cell
        }
        let cell = collectionView.dequeueCell(ofType: MainItemCollectionViewCell.self, indexPath: indexPath)
        if let model = items?.get(indexPath.row - (currentIndex + 1)) {
            cell.item = model
        }
        return cell
    }
}

extension ItemsIndicatorInfoController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MainItemCollectionViewCell {
            let vc = ItemsDetailViewController.instantiateFromStoryboard(storyboardName: "Main")
            vc.model = cell.item
            pushVC(vc)
        }
    }
}

//MARK: - Private method
extension ItemsIndicatorInfoController {
    private func createItemssData(datas: [Items]?){
        guard let models = datas else {
            return
        }
        groups = []
        titlesIndex = []
        let AncientofWonders       = models.filter({ (ob) -> Bool in
            (ob.dicInfo["Shop"] as? String) == ShopType.AncientofWonders.rawValue
        })
        let AncientWeaponry        = models.filter({ (ob) -> Bool in
            (ob.dicInfo["Shop"] as? String) == ShopType.AncientWeaponry.rawValue
        })
        let ArcaneSanctum          = models.filter({ (ob) -> Bool in
            (ob.dicInfo["Shop"] as? String) == ShopType.ArcaneSanctum.rawValue
        })
        let CacheofQuel            = models.filter({ (ob) -> Bool in
            (ob.dicInfo["Shop"] as? String) == ShopType.CacheofQuel.rawValue
        })
        let EnchantedArtifact      = models.filter({ (ob) -> Bool in
            (ob.dicInfo["Shop"] as? String) == ShopType.EnchantedArtifact.rawValue
        })
        let GatewayRelics          = models.filter({ (ob) -> Bool in
            (ob.dicInfo["Shop"] as? String) == ShopType.GatewayRelics.rawValue
        })
        let LeragastheVile         = models.filter({ (ob) -> Bool in
            (ob.dicInfo["Shop"] as? String) == ShopType.LeragastheVile.rawValue
        })
        let Protectorate           = models.filter({ (ob) -> Bool in
            (ob.dicInfo["Shop"] as? String) == ShopType.Protectorate.rawValue
        })
        let SenatheAccesorizer     = models.filter({ (ob) -> Bool in
            (ob.dicInfo["Shop"] as? String) == ShopType.SenatheAccesorizer.rawValue
        })
        let SupportiveVestments    = models.filter({ (ob) -> Bool in
            (ob.dicInfo["Shop"] as? String) == ShopType.SupportiveVestments.rawValue
        })
        let WeaponDealer           = models.filter({ (ob) -> Bool in
            (ob.dicInfo["Shop"] as? String) == ShopType.WeaponDealer.rawValue
        })

        var last = titlesIndex?.last ?? 0
        titlesIndex?.append(0)
        groups?.append(AncientofWonders)
        titlesIndex?.append((AncientofWonders.count + 1) + last)

        last = titlesIndex?.last ?? 0
        groups?.append(AncientWeaponry)
        titlesIndex?.append((AncientWeaponry.count + 1) + last)
        
        last = titlesIndex?.last ?? 0
        groups?.append(ArcaneSanctum)
        titlesIndex?.append((ArcaneSanctum.count + 1) + last)
        
        last = titlesIndex?.last ?? 0
        groups?.append(CacheofQuel)
        titlesIndex?.append((CacheofQuel.count + 1) + last)
        
        last = titlesIndex?.last ?? 0
        groups?.append(EnchantedArtifact)
        titlesIndex?.append((EnchantedArtifact.count + 1) + last)
        
        last = titlesIndex?.last ?? 0
        groups?.append(GatewayRelics)
        titlesIndex?.append((GatewayRelics.count + 1) + last)
        
        last = titlesIndex?.last ?? 0
        groups?.append(LeragastheVile)
        titlesIndex?.append((LeragastheVile.count + 1) + last)
        
        last = titlesIndex?.last ?? 0
        groups?.append(Protectorate)
        titlesIndex?.append((Protectorate.count + 1) + last)
        
        last = titlesIndex?.last ?? 0
        groups?.append(SenatheAccesorizer)
        titlesIndex?.append((SenatheAccesorizer.count + 1) + last)
        
        last = titlesIndex?.last ?? 0
        groups?.append(SupportiveVestments)
        titlesIndex?.append((SupportiveVestments.count + 1) + last)
        
        last = titlesIndex?.last ?? 0
        titlesIndex?.append(0)
        groups?.append(WeaponDealer)
        
        items = [Items]()
        for list in groups! {
            items!.append(contentsOf: list)
        }
    }
    
    private func setDataSource(){
        collectionView.registerCells(identifies: [MainItemCollectionViewCell.className,
                                                  MainTitleCollectionViewCell.className])
        collectionView.delegate = self
        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? CommonFlowLayout {
            layout.delegate = self
        }
    }
    
    private func isTitle(indexPath: IndexPath) -> Bool {
        guard let indexs = titlesIndex else {
            return false
        }
        
        if indexs.contains(indexPath.row) {
            currentIndex = indexs.indexes(of: indexPath.row).first ?? 0
            let x = currentIndex % ShopType.numberValue
            currentTitle = (groups?[x].first?.dicInfo["Shop"]) as? String ?? ""
            return true
        }
        return false
    }
}

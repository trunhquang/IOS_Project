//
//  HeroesIndicatorInfoController.swift
//  DotaGuide
//
//  Created by macOS on 8/3/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import FirebaseDatabase

enum TypeHeroes: String {
    case StrengthSentinel       = "Sentinel Strength"
    case StrengthScourge        = "Scourge Strength"
    case AgilitySentinel        = "Sentinel Agility"
    case AgilityScourge         = "Scourge Agility"
    case IntelligenceSentinel   = "Sentinel Intelligence"
    case IntelligenceScourge    = "Scourge Intelligence"
}

class HeroesIndicatorInfoController: IndicatorInfoController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var heroesRef = Database.database().reference(withPath: "Heros")
    
    private var heroes: [Heroes]?{
        didSet{
            
        }
    }
    private var groups: [[Heroes]]?
    private var titlesIndex: [Int]?
    private var currentIndex = 0
    private var currentTitle = "Strength Sentinel"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heroesRef.observe(.value) {[weak self] (dataSnapshot) in
            var newItems: [Heroes] = []
            for child in dataSnapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let groceryItem = Heroes(snapshot: snapshot) {
                    newItems.append(groceryItem)
                }
            }
            self?.createHeroesData(datas: newItems)
            self?.setDataSource()
        }
//        setDataSource()
//        ThisAPI.getAllHeroID { [weak self] heroids in
//            if let heroids = heroids {
//                self?.addHerosToDB(heroesID: heroids)
//            }
//        }
        
    }
}

extension HeroesIndicatorInfoController: CommonFlowLayoutDelegate {
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
extension HeroesIndicatorInfoController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = (heroes?.count ?? 0)
        if count > 0 {
            count += 6
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
        if let model = heroes?.get(indexPath.row - (currentIndex + 1)) {
            cell.model = model
        }
        return cell
    }
}

extension HeroesIndicatorInfoController: UICollectionViewDelegate {
    
}

//MARK: - Private method
extension HeroesIndicatorInfoController {
    private func createHeroesData(datas: [Heroes]?){
        guard let models = datas else {
            return
        }
        groups = []
        titlesIndex = []
        let SentinelStrenght = models.filter({ (ob) -> Bool in
            ob.type == TypeHeroes.StrengthSentinel.rawValue
        })
        let StrengthScourge = models.filter({ (ob) -> Bool in
            ob.type == TypeHeroes.StrengthScourge.rawValue
        })
        let AgilitySentinel = models.filter({ (ob) -> Bool in
            ob.type == TypeHeroes.AgilitySentinel.rawValue
        })
        let AgilityScourge = models.filter({ (ob) -> Bool in
            ob.type == TypeHeroes.AgilityScourge.rawValue
        })
        let IntelligenceSentinel = models.filter({ (ob) -> Bool in
            ob.type == TypeHeroes.IntelligenceSentinel.rawValue
        })
        let IntelligenceScourge = models.filter({ (ob) -> Bool in
            ob.type == TypeHeroes.IntelligenceScourge.rawValue
        })
        titlesIndex?.append(0)
        groups?.append(SentinelStrenght)
        titlesIndex?.append((SentinelStrenght.count + 1))
        groups?.append(StrengthScourge)
        var last = titlesIndex?.last ?? 0
        titlesIndex?.append((StrengthScourge.count + 1) + last)
        groups?.append(AgilitySentinel)
        last = titlesIndex?.last ?? 0
        titlesIndex?.append((AgilitySentinel.count + 1) + last)
        groups?.append(AgilityScourge)
        last = titlesIndex?.last ?? 0
        titlesIndex?.append((AgilityScourge.count + 1) + last)
        groups?.append(IntelligenceSentinel)
        last = titlesIndex?.last ?? 0
        titlesIndex?.append((IntelligenceSentinel.count + 1) + last)
        groups?.append(IntelligenceScourge)
        
        heroes = [Heroes]()
        for list in groups! {
            heroes!.append(contentsOf: list)
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
            let x = currentIndex % 6
            currentTitle = groups?[x].first?.type ?? ""
            return true
        }
        return false
    }
    
//    func  addHerosToDB(heroesID: Heroids){
//        let parseHTMLGroup = DispatchGroup()
//        for id in heroesID.ids {
//            if let realID = id.split("/").last?.split(".").first {
//                parseHTMLGroup.enter()
//                ThisAPI.search(key: realID) { (hero) in
//                    parseHTMLGroup.leave()
//                    hero?.addToFirebase(id: realID)
//                }
//                
//            }
//        }
//        parseHTMLGroup.notify(queue: .main) { [weak self] in
//        }
//    }
}

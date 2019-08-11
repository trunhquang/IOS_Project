//
//  CommonFlowLayout.swift
//  ecapp
//
//  Created by macOS on 2/13/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import UIKit

@objc protocol CommonFlowLayoutDelegate: class {
    func edgeInsets(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout) -> UIEdgeInsets
    func lineSpacing(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout) -> CGFloat
    func interitemSpacing(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout) -> CGFloat
    func numberOfColume(inCollectionView collectionView:UICollectionView) -> Int
    func itemHeight(forCollectionView collectionView:UICollectionView, atIndexPath indexPath: IndexPath, itemWidth: CGFloat) -> CGFloat
    func heightForCollectionView(_ collectionView:UICollectionView, height: CGFloat)
    
    @objc optional func contentWidth(forCollectionView collectionView:UICollectionView) -> CGFloat
    @objc optional func itemWidth(forCollectionView collectionView:UICollectionView) -> CGFloat
    @objc optional func numberOfRow(inCollectionView collectionView:UICollectionView) -> Int
    @objc optional func itemWidth(forCollectionView collectionView:UICollectionView, atIndexPath indexPath: IndexPath) -> CGFloat
}
class CommonFlowLayout: UICollectionViewLayout {
    weak var delegate: CommonFlowLayoutDelegate!
    
    private var cache = [UICollectionViewLayoutAttributes]()
    
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat = Screen.WIDTH
    
    private var  numberItems = 0
    private var  currentItem = 0
    private var  oldNumberItem = 0
    
    private var  xOffsets = [CGFloat]()
    private var  yOffsets = [CGFloat]()
    private var  xOffset: CGFloat = 0
    private var  yOffset: CGFloat = 0
    private var  interitemSpacing: CGFloat = 0
    private var  lineSpacing: CGFloat = 0
    private var  edgeInsets: UIEdgeInsets!
    private var  maxItemInRowHeight: CGFloat = 0
    
    private var  itemWidth: CGFloat!
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        layout()
    }
    
    func reset(){
        cache = [UICollectionViewLayoutAttributes]()
        
        contentHeight = 0
        contentWidth = Screen.WIDTH
        
        numberItems = 0
        currentItem = 0
        oldNumberItem = 0
        
        xOffsets = [CGFloat]()
        yOffsets = [CGFloat]()
        xOffset  = 0
        yOffset  = 0
        interitemSpacing = 0
        lineSpacing = 0
        maxItemInRowHeight = 0
        itemWidth = 0
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache.first {
            return $0.indexPath == indexPath
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if let oldHeight = collectionView?.bounds.height {
            return oldHeight != newBounds.height
        }
        return false
    }
}

//MARK: private method
extension CommonFlowLayout {
    private func layout(){
        guard let collectionView = collectionView, delegate != nil else {
            return
        }
        if let contentWidth = delegate.contentWidth?(forCollectionView: collectionView) {
            self.contentWidth = contentWidth
        }
        let numberColumn = delegate.numberOfColume(inCollectionView: collectionView)
        edgeInsets = delegate.edgeInsets(collectionView, layout: self)
        if xOffset == 0 {
            xOffset = edgeInsets.left
        }
        if yOffset == 0 {
            yOffset = edgeInsets.top
        }
        numberItems = collectionView.numberOfItems(inSection: 0)
        interitemSpacing = delegate.interitemSpacing(collectionView, layout: self)
        lineSpacing = delegate.lineSpacing(collectionView, layout: self)
        if numberColumn == 0 {
            layoutForHorizontalScroll()
        } else {
            layoutForVerticalScroll(numberColumn: numberColumn)
        }
    }
    
    private func layoutForHorizontalScroll(){
        let section = 0
        guard let collectionView = collectionView else {
            return
        }
        var totalInteritemSpacing = interitemSpacing * CGFloat(numberItems - 1)
        if totalInteritemSpacing < 0 {
            totalInteritemSpacing = 0
        }
        if numberItems > 3 {
            itemWidth = (Screen.WIDTH - totalInteritemSpacing - edgeInsets.left - edgeInsets.right) / 2.5
            contentWidth = itemWidth * CGFloat(numberItems) + totalInteritemSpacing + edgeInsets.left + edgeInsets.right
        } else {
            itemWidth = (Screen.WIDTH - totalInteritemSpacing - edgeInsets.left - edgeInsets.right) / 3
        }
        
        yOffsets = [CGFloat].init(repeating: edgeInsets.top, count: numberItems)
        
        if let width = delegate.itemWidth?(forCollectionView: collectionView) {
            itemWidth = width
            contentWidth = itemWidth * CGFloat(numberItems) + totalInteritemSpacing + edgeInsets.left + edgeInsets.right
        }
        contentWidth = contentWidth.rounded(.up)
        //caculator attributes
        for i in 0 ..< numberItems{
            let indexPath = IndexPath(item: i, section: section)
            if let width = delegate.itemWidth?(forCollectionView: collectionView, atIndexPath: indexPath) {
                itemWidth = width
            }
            //caculator xOffset
            if i != 0 {
                xOffset = xOffset + itemWidth + interitemSpacing
            }
            xOffsets.append(xOffset)
            
            let itemHeight = delegate.itemHeight(forCollectionView: collectionView, atIndexPath: indexPath, itemWidth: itemWidth)
            if maxItemInRowHeight < itemHeight{
                maxItemInRowHeight = itemHeight
            }
            
            let frame = CGRect(x: xOffsets[i], y: yOffsets[i], w: itemWidth, h: maxItemInRowHeight)
            let insetFrame = frame.insetBy(dx: 0, dy: 0)
            
            //Creates an UICollectionViewLayoutItem with the frame and add it to the cache
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
        }
        if numberItems == 0 {
            contentHeight = 0
        } else {
            contentHeight = maxItemInRowHeight + edgeInsets.top + edgeInsets.bottom
        }
        delegate.heightForCollectionView(collectionView, height: contentHeight)
    }
    
    private func layoutForVerticalScroll(numberColumn : Int){
        let section = 0
        guard let collectionView = collectionView else {
            return
        }
        var totalInteritemSpacing = interitemSpacing * CGFloat(numberColumn - 1)
        if let _itemWidth = delegate.itemWidth?(forCollectionView: collectionView) {
            itemWidth = _itemWidth
        } else {
            if totalInteritemSpacing < 0 {
                totalInteritemSpacing = 0
            }
            itemWidth = (Screen.WIDTH - totalInteritemSpacing - edgeInsets.left - edgeInsets.right) / CGFloat(numberColumn)
        }
        if let _ = delegate.numberOfRow?(inCollectionView: collectionView) {
            contentWidth = itemWidth * CGFloat(numberColumn) + totalInteritemSpacing + edgeInsets.left + edgeInsets.right
        }
        contentWidth = contentWidth.rounded(.up)
        //caculator attributes
        var oldItemWidth: CGFloat = 0
        for i in oldNumberItem ..< numberItems{
            if i != 0 {
                oldItemWidth = itemWidth ?? 0
            }
            let indexPath = IndexPath(item: i, section: section)
            if let width = delegate.itemWidth?(forCollectionView: collectionView, atIndexPath: indexPath) {
                itemWidth = width
            }
            //caculator xOffset
            let sizeWidth = xOffset + oldItemWidth + interitemSpacing + edgeInsets.right +  itemWidth
            if  sizeWidth > contentWidth
                || i == 0{
                xOffset = edgeInsets.left
            } else {
                xOffset = xOffset + oldItemWidth + interitemSpacing
            }
            xOffsets.append(xOffset)
            
            let itemHeight = delegate.itemHeight(forCollectionView: collectionView, atIndexPath: indexPath, itemWidth: itemWidth)
            // caculator yOffset
            
            if xOffset == edgeInsets.left && i != 0 {
                yOffset = yOffset + maxItemInRowHeight + lineSpacing
                maxItemInRowHeight = 0
            }
            if maxItemInRowHeight < itemHeight {
                maxItemInRowHeight = itemHeight
            }
            yOffsets.append(yOffset)
            
            //          Creates an UICollectionViewLayoutItem with the frame and add it to the cache
            let frame = CGRect(x: xOffsets[i], y: yOffsets[i], w: itemWidth, h: maxItemInRowHeight)
            let insetFrame = frame.insetBy(dx: 0, dy: 0)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            //Xuống hàng
            currentItem += 1
            if currentItem == numberColumn{
                currentItem = 0
            }
        }
        oldNumberItem = numberItems
        if let last = yOffsets.last {
            contentHeight = last + maxItemInRowHeight + edgeInsets.bottom
        } else {
            contentHeight = 0
        }
        delegate.heightForCollectionView(collectionView, height: contentHeight)
    }
}

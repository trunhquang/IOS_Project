//
//  MainViewController.swift
//  DotaGuide
//
//  Created by macOS on 8/3/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import XLPagerTabStrip

class MainViewController: BaseButtonBarPagerTabStripViewController<PagerTabCellButtonBarCell> {
    @IBOutlet weak var shadowView: UIView!
    
    override func viewDidLoad() {
        changeSelectedBarColor()
        super.viewDidLoad()
        title = "Defense of the Ancients"
        shadowButtonBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    
    /**************************************************************************/
    //MARK: XLPagerTabTrip
    /**************************************************************************/
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buttonBarItemSpec = ButtonBarItemSpec.nibFile(nibName: PagerTabCellButtonBarCell.className, bundle: Bundle(for: PagerTabCellButtonBarCell.self), width: { (cell: IndicatorInfo) -> CGFloat in
            return Screen.WIDTH / 2
        })
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let itemVC = ItemsIndicatorInfoController()
        let heroesVC = HeroesIndicatorInfoController.instantiateFromStoryboard(storyboardName: "Main")
        return [heroesVC, itemVC]
    }
    
    override func configure(cell: PagerTabCellButtonBarCell, for indicatorInfo: IndicatorInfo) {
        cell.title.text = indicatorInfo.title
    }
    
    private func shadowButtonBar(){
        buttonBarView.backgroundColor = .clear
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 3)
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowRadius = 2.0
    }
    
    private func changeSelectedBarColor(){
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = AppColors.mainColor
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = {  (oldCell: PagerTabCellButtonBarCell?, newCell: PagerTabCellButtonBarCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.title.textColor = AppColors.grayColor
            newCell?.title.textColor = .white
            
        }
    }
    /*************************---XLPagerTabTrip---*****************************/
}


//
//  HeroDetailViewController.swift
//  DotaGuide
//
//  Created by macOS on 8/11/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import UIKit

class HeroDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var heroes: Heroes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "HEROES"
        navigationItem.leftBarButtonItem = backBarButton()
        setUpTableView()
    }
}

//MARK: - UITableView
extension HeroDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueCell(ofType: HeroesIdentifyTableViewCell.self, indexPath: indexPath)
            cell.model = heroes
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueCell(ofType: HeroesAttributesTableViewCell.self, indexPath: indexPath)
            cell.model = heroes
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueCell(ofType: AdvancedStatisicsTableViewCellTableViewCell.self, indexPath: indexPath)
            cell.model = heroes
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
        
    }
}

extension HeroDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARKL: - private method
extension HeroDetailViewController {
    private func setUpTableView(){
        tableView.registerCellByNibs(strings: [HeroesIdentifyTableViewCell.className,
                                               HeroesAttributesTableViewCell.className,
                                               AdvancedStatisicsTableViewCellTableViewCell.className])
    }
}

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
        let image = UIImageView(frame: Screen.BOUNDS)
        image.setImageWithURLString(string: "http://www.playcybergames.com/dota/images/body_background.jpg")
        tableView.backgroundView = image
        title = "HEROES"
        setUpTableView()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - UITableView
extension HeroDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
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
                                               HeroesAttributesTableViewCell.className])
    }
}

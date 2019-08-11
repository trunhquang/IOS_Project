
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let baseURL = "http://www.playcybergames.com/dota/"

struct Screen {
    static let BOUNDS   = UIScreen.main.bounds
    static let WIDTH    = UIScreen.main.bounds.size.width
    static let HEIGHT   = UIScreen.main.bounds.size.height
    static let MAX      = max(Screen.WIDTH, Screen.HEIGHT)
    static let MIN      = min(Screen.WIDTH, Screen.HEIGHT)
}

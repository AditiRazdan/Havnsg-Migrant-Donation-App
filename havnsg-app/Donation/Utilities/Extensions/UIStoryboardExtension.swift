

import UIKit
enum Storyboard : String {
    case Main = "Main"
   
    var instance : UIStoryboard {
      return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass : T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
}

extension UIViewController{
    class var storyboardID: String{
        return "\(self)"
    }
    
    static func instatiate(from storyboard: Storyboard) -> Self{
        return storyboard.viewController(viewControllerClass: self)
    }
}


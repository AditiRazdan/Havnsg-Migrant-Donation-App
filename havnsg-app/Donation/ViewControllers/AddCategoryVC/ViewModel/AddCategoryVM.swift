
import Foundation
import UIKit

class AddCategoryVM: NSObject {
    
    var bindToController:(() -> ()) = {}
    
    override init() {
        super.init()
    }

    func AddCategoryAPI(viewController: UIViewController,param: [String:Any], formdata: NSMutableArray,url:String) {
        APIHandler.shared.callServiceMethodMultiPart(formdata: formdata, parameters: param, name: "categoryImage", keyURL: url, isShowLoader: true, isHideLoader: true, loadingMsg: "", viewController: viewController) { (result: AddCategoryModel?, error) in
            if error == nil {
                if let success = result?.success , success {
                    debugPrint(result as Any)
                    self.bindToController()
                } else {
                    let alertController = UIAlertController(title: "", message: result?.error, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    viewController.present(alertController, animated: true, completion: nil)
                }
            } else {
                let alertController = UIAlertController(title: "", message: "something went wrong", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                viewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

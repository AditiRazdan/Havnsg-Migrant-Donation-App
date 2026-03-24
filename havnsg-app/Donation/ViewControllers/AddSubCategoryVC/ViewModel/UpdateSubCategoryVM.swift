
import Foundation
import UIKit

class UpdateSubCategoryVM: NSObject {
    
    var bindToController:(() -> ()) = {}
    
    override init() {
        super.init()
    }
    
    func UpdateSubCategoryAPI(viewController: UIViewController,param:[String:Any],subCategoryID:String) {
        let url = ApiEndpoints.updateCategory + subCategoryID
        APIHandler.shared.callServiceMethodPOST(viewController: viewController, parameters: param, keyURL: url, isShowLoader: true, isHideLoader: true, loadingMsg: "") { (result:UpdateCategoryModel?, error) in
            if error == nil {
                if let success = result?.success , success {
                    Utility().showAlert(Title: "Sub-Category Updated Successfully.", message: result?.msg ?? "", viewcontroller: viewController) {
                        self.bindToController()
                    }
                } else {
                    let alertController = UIAlertController(title: "", message: result?.error?[0].msg, preferredStyle: .alert)
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

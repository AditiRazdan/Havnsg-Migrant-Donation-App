
import UIKit
import MobileCoreServices
import SystemConfiguration
import SVProgressHUD

class Utility: NSObject
{
    
    func isValidPhone(testStr:String) -> Bool{
        let regularExpressionForPhone = "/^[0-9]{8}$/"
        let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
        return testPhone.evaluate(with: testStr)
    }
    
    func isValidPassword(testPwd : String?) -> Bool
    {
        guard testPwd != nil else
        {
            return false
        }
        //        "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,}$" with special character
        
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}$")
        return passwordPred.evaluate(with: testPwd)
    }

    func isValidEmail(testEmail : String?) -> Bool {
        guard testEmail != nil else {
            return false
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: testEmail)
    }
    
    //  MARK:- ShowAlert Methods
    
    func showAlertMessage(Title: String, message: String,viewcontroller : UIViewController, callback:@escaping ((Bool)->()) )
    {
        let alertController = UIAlertController(title: Title, message: message, preferredStyle: .alert)
        let yesPressed = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            callback(true)
        })
        let noPressed = UIAlertAction(title: "CANCEL", style: .default, handler: { (action) in
            callback(false)
        })
        alertController.addAction(yesPressed)
        alertController.addAction(noPressed)
        viewcontroller.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(Title: String, message: String,viewcontroller : UIViewController, callback:@escaping (()->()) )
    {
        let alertController = UIAlertController(title: Title, message: message, preferredStyle: .alert)
        let yesPressed = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            callback()
        })
        alertController.addAction(yesPressed)
        viewcontroller.present(alertController, animated: true, completion: nil)
    }
    
    
    func showPositiveMessage(message:String, controller: UIViewController)
    {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
//        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        let viewController = appDelegate.window!.rootViewController
        controller.present(alertController, animated: true, completion: nil)
    }
    
    
    
    //    MARK:- Search popup animation Method.
    
    func aniamteSearchPopup(viewName:UIView,xChange:CGFloat,yChange:CGFloat)
    {
        viewName.transform = CGAffineTransform(translationX: CGFloat(xChange), y: CGFloat(yChange))
        viewName.alpha = 1
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(0.3)
        viewName.transform = CGAffineTransform(translationX: 0.0, y: 0)
        viewName.alpha = 1
        UIView.commitAnimations()
    }
    
    func HideSearchPopup(viewName:UIView)
    {
        viewName.transform = CGAffineTransform(translationX: 0.0, y: CGFloat( viewName.frame.size.height/3.0))
        viewName.alpha = 1
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(0.3)
        viewName.transform = CGAffineTransform(translationX: 0.0, y:  viewName.frame.size.height)
        viewName.alpha = 0
        UIView.commitAnimations()
    }
    
    
    //  MARK:- Capitalize first String
    func capitalizingFirstLetter(str:String) -> String {
        if str != ""
        {
            let first = String(str.prefix(1)).capitalized
            let other = String(str.dropFirst())
            return first + other
        }
        else
        {
            return str
        }
    }
 
    //  MARK:- CheckInternetCOnnection
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    //MARK:- ActivityIndicator Methods
    
    func showActivityIndicator(view : UIView, msg:String,backColorChange:String?)
    {
        SVProgressHUD.show(withStatus: msg)
        view.isUserInteractionEnabled = false
        SVProgressHUD.setContainerView(view)
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.show()
    }
    
    
    func hideActivityIndicator(view : UIView)
    {
        SVProgressHUD.dismiss()
        DispatchQueue.main.async
        {
            view.isUserInteractionEnabled = true
        }
    }
    
    func changePlaceholderTetxColor(textField : UITextField , title : String,color:UIColor)
    {
        textField.attributedPlaceholder = NSAttributedString(string:title, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    func getresponseString(dataDict : NSDictionary,key : String) -> String
    {
        var returnString = ""
        if let keyValue : Int = dataDict.value(forKey: key) as? Int
        {
            returnString = String(keyValue)
        }
        else if let keyValueStr : String = dataDict.value(forKey: key) as? String
        {
            returnString = keyValueStr
        }
        else if let keyValueDouble : Double = dataDict.value(forKey: key) as? Double
        {
            returnString = String(keyValueDouble)
        }
        return returnString
    }
    
    func deleteUserDefaults()
    {
        obj_UserDefault.removeObject(forKey: "userId")
        obj_UserDefault.removeObject(forKey: "userType")
        obj_UserDefault.removeObject(forKey: "authToken")
        obj_UserDefault.removeObject(forKey: "autoLogin")
        obj_UserDefault.synchronize()
    }
}

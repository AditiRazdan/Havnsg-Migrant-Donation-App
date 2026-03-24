//
//  APIHandler.swift
//  KIckin'Inn
//
//  Created by Megha iOS on 22/07/21.
//

import UIKit
import Alamofire
import FirebaseAnalytics
import MapKit
import CoreLocation

class APIHandler: NSObject, CLLocationManagerDelegate {
    
    
    let locationManager = CLLocationManager()
    static var location = ""
    static let shared = APIHandler()
    var bindToController:(() -> ()) = {}
    
    private override init() {
        super.init()
        
        AF.sessionConfiguration.timeoutIntervalForRequest = 80
    }
    
    
    func setLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        APIHandler.location = "locations = \(locValue.latitude) \(locValue.longitude)"
    }
    
    //    func callServiceMethodMultiPart<T : Codable>(formdata: NSMutableArray,parameters : [String : Any] ,name:String, keyURL : String, isShowLoader:Bool, isHideLoader:Bool, loadingMsg:String, viewController: UIViewController, completionBlock : @escaping (T?, _ error : NSError?)-> Void )
    //    {
    //        if Utility().isInternetAvailable()
    //        {
    //            let urlRequest = BASE_URL + keyURL
    //            print(urlRequest)
    //            print(parameters)
    //
    //            if isShowLoader
    //            {
    //                Utility().showActivityIndicator(view: viewController.view, msg: loadingMsg, backColorChange: "no")
    //            }
    //
    //            var token = ""
    //            if let tokenVal = obj_UserDefault.value(forKey: "authToken") as? String
    //            {
    //                token = tokenVal
    //            }
    //            let headers:HTTPHeaders = [ "Authorization": token,"Content-type": "multipart/form-data"]
    //
    //            AF.upload(multipartFormData: { (multipartFormData) in
    //                for i in formdata
    //                {
    //                    if let dataDict : NSDictionary = i as? NSDictionary
    //                    {
    //                        //                        let mimetype = Utility().getresponseString(dataDict: dataDict, key: "ContentType")
    //                        if let file_Data : Data = dataDict.value(forKey: name) as? Data
    //                        {
    //                            if file_Data != nil
    //                            {
    //                                multipartFormData.append(file_Data, withName: name, fileName: "image.png", mimeType: "image/png")
    //                            }
    //                        }
    //                    }
    //                }
    //                for (key, value) in parameters
    //                {
    //                    let keyName : String = "\(key)"
    //                    let dataValue : String = "\(value)"
    //                    let valueData : Data = dataValue.data(using: .utf8) ?? Data()
    //                    multipartFormData.append(valueData, withName: keyName)
    //                }
    //            }, to: urlRequest, method: .post, headers: headers, encodingCompletion: { (response) in
    //                //                if response.error == nil{
    //                //                    if let dataDict: NSDictionary = response.value as? NSDictionary {
    //                //                        completionBlock(dataDict ,nil)
    //                //                    }
    //                //                    else {
    //                //                        completionBlock(nil,nil)
    //                //                    }
    //                //                }
    //                //                else {
    //                //                    print(response.error )
    //                //                    completionBlock(NSDictionary(), response.error as! NSError)
    //                //                }
    //                switch response {
    //                case .success(let upload, _, _):
    //                    upload.responseJSON { response in
    //                        switch response.result {
    //                        case .success(_) :
    //                            if isHideLoader {
    //                                Utility().hideActivityIndicator(view: viewController.view)
    //                            }
    //                            if let jsonData = response.data {
    //                                let decoder = JSONDecoder()
    //                                do {
    //                                    let result = try decoder.decode(T.self, from: jsonData)
    //                                    completionBlock(result, nil)
    //                                }
    //                                catch let error{
    //                                    completionBlock(nil, error as NSError)
    //                                    debugPrint("error occured while decoding = \(error)")
    //                                }
    //                            }
    //                            else {
    //                                completionBlock(nil, response.error as NSError?)
    //                            }
    //                        case .failure(let error):
    //
    //                            print("failed 1",error.localizedDescription)
    //                        }
    //                    }
    //                    break
    //                case .failure(let error):
    //                    print("failed 2",error.localizedDescription)
    //                }
    //            })
    //        }
    //        else
    //        {
    //            //            viewController.displayMessage(title: "", msg: "Please Check Your Internet Connection And Try Again")
    //        }
    //    }
    func firebaseLoggingAction(keyURL : String) {
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.dateStyle = .medium
        utcDateFormatter.timeStyle = .medium

        // The default timeZone on DateFormatter is the device’s
        // local time zone. Set timeZone to UTC to get UTC time.
        utcDateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        

        // Printing a Date
        let date = Date()
        let currentUtcTime = utcDateFormatter.string(from: date)
        
        print(keyURL)
        print(currentUtcTime)
        print(APIHandler.location)
        
        Analytics.logEvent("url_called", parameters: [
          "url": keyURL as String,
          "utc_time": currentUtcTime as String,
          "location": APIHandler.location as String
        ])
    }
    
    func callServiceMethodMultiPart<T: Codable>(
        formdata: NSMutableArray,
        parameters: [String: Any],
        name: String,
        keyURL: String,
        isShowLoader: Bool,
        isHideLoader: Bool,
        loadingMsg: String,
        viewController: UIViewController,
        completionBlock: @escaping (T?, NSError?) -> Void
    ) {
        
        firebaseLoggingAction(keyURL: keyURL)
        
        guard Utility().isInternetAvailable() else {
            Utility().showAlert(
                Title: "Error",
                message: ErrorMSG.NO_Internet.rawValue,
                viewcontroller: viewController
            ) {
                self.bindToController()
            }
            return
        }
        
        let urlRequest = BASE_URL + keyURL
        if isShowLoader {
            Utility().showActivityIndicator(
                view: viewController.view,
                msg: loadingMsg,
                backColorChange: "no"
            )
        }
        
        let token = obj_UserDefault.value(forKey: "authToken") as? String ?? ""
        
        let headers: HTTPHeaders = [
            "Authorization": token
            // Content-Type multipart ke liye manually dene ki zarurat nahi
        ]
        
        AF.upload(
            multipartFormData: { multipartFormData in
                
                // 📸 Files
                for item in formdata {
                    if let dataDict = item as? NSDictionary,
                       let fileData = dataDict.value(forKey: name) as? Data {
                        
                        multipartFormData.append(
                            fileData,
                            withName: name,
                            fileName: "image.png",
                            mimeType: "image/png"
                        )
                    }
                }
                
                // 📦 Parameters
                for (key, value) in parameters {
                    let valueData = "\(value)".data(using: .utf8) ?? Data()
                    multipartFormData.append(valueData, withName: key)
                }
                
                // ⏱ UTC Timestamp
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .medium
                formatter.timeZone = TimeZone(abbreviation: "UTC")
                
                let timeStamp = formatter.string(from: Date())
                let timeData = timeStamp.data(using: .utf8) ?? Data()
                multipartFormData.append(timeData, withName: "timeStamp")
                
            },
            to: urlRequest,
            method: .post,
            headers: headers
        )
        .responseDecodable(of: T.self) { response in
            
            if isHideLoader {
                Utility().hideActivityIndicator(view: viewController.view)
            }
            
            switch response.result {
            case .success(let result):
                completionBlock(result, nil)
                
            case .failure(let error):
                print("Multipart API Error:", error)
                completionBlock(nil, error as NSError)
            }
        }
    }

    func callServiceMethodGET<T: Decodable>(viewController : UIViewController, keyURL : String, isShowLoader:Bool, isHideLoader:Bool, loadingMsg:String, model: T.Type,  completionBlock : @escaping ( _ resposeObject : T?  ,  _ error : NSError?)-> Void )
    {
        
        firebaseLoggingAction(keyURL: keyURL)
        
        if Utility().isInternetAvailable() {
            
            let urlString = BASE_URL + keyURL
            
            let urlKey = urlString.replacingOccurrences(of: " ", with: "%20")
            print(urlKey)
            
            if isShowLoader
            {
                Utility().showActivityIndicator(view: viewController.view, msg: loadingMsg, backColorChange: "no")
            }
            var token = ""
            if let tokenVal = obj_UserDefault.value(forKey: "authToken") as? String
            {
                token = tokenVal
            }
            let headers:HTTPHeaders = [ "Authorization": token]
            AF.request(urlKey, method: .get, encoding: JSONEncoding.default,headers: headers).responseData { (response) in
                print(response)
                Utility().hideActivityIndicator(view: viewController.view)
                if let data:  Data = response.data {
                    
                    let str = String(decoding: data, as: UTF8.self)
                    print("-------",str)
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode(T.self, from: data)
                        //                        print(result)
                        completionBlock(result, nil)
                    }
                    catch let error{
                        completionBlock(nil, error as NSError)
                        debugPrint("error occured while decoding = \(error)")
                    }
                    
                }
                else {
                    completionBlock(nil, response.error as NSError?)
                }
            }
        }
        else
        {
            Utility().showAlert(Title: "Error", message: ErrorMSG.NO_Internet.rawValue, viewcontroller: viewController) {
                self.bindToController()
            }
        }
    }
    
    func callServiceMethodPOST<T : Codable >(viewController : UIViewController, parameters : [String : Any] , keyURL : String, isShowLoader:Bool, isHideLoader:Bool, loadingMsg:String, completionBlock : @escaping (T? ,  _ error : NSError?)-> Void )
    {
        
        firebaseLoggingAction(keyURL: keyURL)
        
        if Utility().isInternetAvailable(){
            if isShowLoader
            {
                Utility().showActivityIndicator(view: viewController.view, msg: loadingMsg, backColorChange: "no")
            }
            
            let urlRequest = BASE_URL + keyURL
            
            var token = ""
            if let tokenVal = obj_UserDefault.value(forKey: "authToken") as? String
            {
                token = tokenVal
            }
            
            //            let header = "Bearer " + Utility().getUSER_DEFAULTS_String(key: "token")
            let headers:HTTPHeaders = [ "Authorization": token]
            //            print(headers)
            
            let utcDateFormatter = DateFormatter()
            utcDateFormatter.dateStyle = .medium
            utcDateFormatter.timeStyle = .medium

            // The default timeZone on DateFormatter is the device’s
            // local time zone. Set timeZone to UTC to get UTC time.
            utcDateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            let date = Date()
            let currentUtcTime = utcDateFormatter.string(from: date)
            var params = parameters
            params["timeStamp"] = currentUtcTime
            
            print(urlRequest)
            print(params)
            
            AF.request(urlRequest, method: .post, parameters: params , encoding: JSONEncoding.default, headers: headers  ).responseJSON { response in
                if isHideLoader
                {
                    Utility().hideActivityIndicator(view: viewController.view)
                }
                //                let result = try decoder.decode(T.self, from: response.data)
                //                print(result)
                switch response.result {
                case .success(_):
                    if let jsonData = response.data {
                        
                        let decoder = JSONDecoder()
                        do {
                            let result = try decoder.decode(T.self, from: jsonData)
                            completionBlock(result, nil)
                        }
                        catch let error{
                            completionBlock(nil, error as NSError)
                            debugPrint("error occured while decoding = \(error)")
                        }
                    }
                    else {
                        completionBlock(nil, response.error as NSError?)
                    }
                    break
                case .failure(_):
                    completionBlock(nil ,response.error as NSError?)
                    break
                }
            }
        }
        else
        {
            Utility().showAlert(Title: "Error", message: ErrorMSG.NO_Internet.rawValue, viewcontroller: viewController) {
                self.bindToController()
            }
        }
    }
    
    
    func callServiceMethodDELETE<T : Codable >(viewController : UIViewController , keyURL : String, isShowLoader:Bool, isHideLoader:Bool, loadingMsg:String, completionBlock : @escaping (T? ,  _ error : NSError?)-> Void )
    {
        
        firebaseLoggingAction(keyURL: keyURL)
        
        if Utility().isInternetAvailable(){
            if isShowLoader
            {
                Utility().showActivityIndicator(view: viewController.view, msg: loadingMsg, backColorChange: "no")
            }
            
            
            let urlRequest = BASE_URL + keyURL
            print(urlRequest)
            
            //        let header = "Bearer " + Utility().getUSER_DEFAULTS_String(key: "token")
            //        let headers:HTTPHeaders = [ "Authorization": header]
            //        print(headers)
            
            
            AF.request(urlRequest, method: .delete, encoding: JSONEncoding.default ).responseJSON { response in
                if isHideLoader
                {
                    Utility().hideActivityIndicator(view: viewController.view)
                }
                
                switch response.result {
                case .success(_):
                    if let jsonData = response.data {
                        
                        let decoder = JSONDecoder()
                        do {
                            let result = try decoder.decode(T.self, from: jsonData)
                            completionBlock(result, nil)
                        }
                        catch let error{
                            completionBlock(nil, error as NSError)
                            debugPrint("error occured while decoding = \(error)")
                        }
                    }
                    else {
                        completionBlock(nil, response.error as NSError?)
                    }
                    break
                case .failure(_):
                    completionBlock(nil ,response.error as NSError?)
                    break
                }
            }
        }
        else
        {
            Utility().showAlert(Title: "Error", message: ErrorMSG.NO_Internet.rawValue, viewcontroller: viewController) {
                self.bindToController()
            }
        }
    }
    
    func callServiceMethodPUT<T : Codable >(viewController : UIViewController , keyURL : String , parameters : [String : Any] , isShowLoader:Bool, isHideLoader:Bool, loadingMsg:String, completionBlock : @escaping (T? ,  _ error : NSError?)-> Void )
    {
        
        firebaseLoggingAction(keyURL: keyURL)
        
        if Utility().isInternetAvailable(){
            if isShowLoader
            {
                Utility().showActivityIndicator(view: viewController.view, msg: loadingMsg, backColorChange: "no")
            }
            
            let urlRequest = BASE_URL + keyURL
            print(urlRequest)
            print(parameters)
            
            //        let header = "Bearer " + Utility().getUSER_DEFAULTS_String(key: "token")
            //        let headers:HTTPHeaders = [ "Authorization": header]
            //        print(headers)
            
            
            AF.request(urlRequest, method: .put, parameters: parameters, encoding: JSONEncoding.default ).responseJSON { response in
                if isHideLoader
                {
                    Utility().hideActivityIndicator(view: viewController.view)
                }
                
                switch response.result {
                case .success(_):
                    if let jsonData = response.data {
                        
                        let decoder = JSONDecoder()
                        do {
                            let result = try decoder.decode(T.self, from: jsonData)
                            completionBlock(result, nil)
                        }
                        catch let error{
                            completionBlock(nil, error as NSError)
                            debugPrint("error occured while decoding = \(error)")
                        }
                    }
                    else {
                        completionBlock(nil, response.error as NSError?)
                    }
                    break
                case .failure(_):
                    completionBlock(nil ,response.error as NSError?)
                    break
                }
            }
        }
        else
        {
            Utility().showAlert(Title: "Error", message: ErrorMSG.NO_Internet.rawValue, viewcontroller: viewController) {
                self.bindToController()
            }
        }
    }
    
}


//
//  Request.swift
//  Gatekeyper
//
//  Created by Qirtas on 17/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData

protocol RequestsGenericDelegate:class{
    func onErrorResponse(forMode mode:String, msg:String)
    func onSuccessResponse(forMode mode:String, data: Any)
}


public class Request
{
     static var alamoFireManager : SessionManager?
    
    public static let getCustomerConfig_URL = "/api/mobile/customer/getCustomerConfiguration?customerId="
    public static let login_URL = "/api/mobile/login"

    class func getCustomerConfig(customerID:String , delegate:RequestsGenericDelegate)
    {
        guard var url = URL(string: "\(Constants.BASE_URL + getCustomerConfig_URL + customerID)" ) else{
            return
        }
        
        print("getCustomerConfig url  \(url)")
        url.removeAllCachedResourceValues()
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 45.0
        configuration.timeoutIntervalForResource = 45.0
        configuration.urlCache = nil
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)

        alamoFireManager!.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON
        { response in
                
                switch (response.result)
                {
                    case .success:
                        print("SUCESS CASE")
                    
                        print("\(Constants.TAG) getCustomerConfig response status code \(response.response?.statusCode)")
                        print("\(Constants.TAG) getCustomerConfig response \(response)")
                        
                        if(response.response?.statusCode == 200)
                        {
                            print("Success")
                            if let value = response.result.value
                            {
                                let json = JSON(value)
                                delegate.onSuccessResponse(forMode: "", data: json)
                            }
                        }
                        else
                        {
                            delegate.onErrorResponse(forMode: "" , msg: Constants.genericError)
                        }
                    
                    case .failure(let error):
                        print("\(Constants.TAG) getCustomerConfig failure")
                        
                        delegate.onErrorResponse(forMode: "" , msg: Constants.genericError)

                    
                }
        }
    }
    
    class func loginRequest(delegate:RequestsGenericDelegate, forData data:[String: Any] , isBackgroundCall:Bool)
    {
        guard var url = URL(string: "\(Constants.BASE_URL)\(Request.login_URL)") else{
                   print("Invalid URL")
                   return
        }
               
        print("loginRequest URL \(url.absoluteString)")
        
        url.removeAllCachedResourceValues()
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 45.0
        configuration.timeoutIntervalForResource = 45.0
        configuration.urlCache = nil
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
        
        let queue = DispatchQueue(label: "com.cnoon.response-queue", qos: .utility, attributes: [.concurrent])
        
        alamoFireManager!.request(url ,method: .post,  parameters: data)
        .response(
            queue: queue,
            responseSerializer: DataRequest.jsonResponseSerializer(),
            completionHandler: { response in
                
                switch (response.result)
                {
                    case .success:
                        print("SUCESS CASE")
                    
                        print("\(Constants.TAG) loginRequest response status code \(response.response?.statusCode)")
                        print("\(Constants.TAG) loginRequest response \(response)")
                        
                        if(isBackgroundCall)
                        {
                            print("user name from dict \(data["username"] as! String)")
                            
                            if let value = response.result.value
                            {
                                let json = JSON(value).rawString()
                                    
//                                let user = json["user"].rawString()
//                                print("\(Constants.TAG) user \(user)")

                                let jsonData = json?.data(using: .utf8)!
                                let userModel = try! JSONDecoder().decode(User.self, from: jsonData!)
                                userModel.updateUserInDB(userName: data["username"] as! String)
                            }
                        }
                        else
                        {
                            DispatchQueue.main.async
                           {
                               if(response.response?.statusCode == 200)
                               {
                                   print("Success")
                                   if let value = response.result.value
                                   {
                                       let json = JSON(value)
                                       delegate.onSuccessResponse(forMode: "", data: json)
                                   }
                               }
                               else
                               {
                                   delegate.onErrorResponse(forMode: "" , msg: Constants.genericError)
                               }
                           }
                        }
                    
                    case .failure(let error):
                        print("\(Constants.TAG) loginRequest failure")
                        
                        DispatchQueue.main.async
                        {
                            delegate.onErrorResponse(forMode: "" , msg: Constants.genericError)
                        }
                    
                }
            }
        )
        
    }
    
}

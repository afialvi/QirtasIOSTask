//
//  CustomerViewController.swift
//  Gatekeyper
//
//  Created by Qirtas on 09/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields
import SwiftyJSON
import MBProgressHUD
import CryptoSwift
import RYFloatingInput



class CustomerViewController: UIViewController, RequestsGenericDelegate , UITextFieldDelegate{
   
    
    //Outlets
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var customerIdTF: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var customerIDView: UIView!
    
     var navBar: UINavigationBar = UINavigationBar()
    
    //other props
    let userDefaults = UserDefaults.standard;
    var loadingNotif:MBProgressHUD! = nil
    
    override func viewDidLayoutSubviews() {
        self.topBarView.addHorizontalGradient()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.customerIdTF.text = ""
        let isFromInitial = self.userDefaults.object(forKey: Constants.isFromInitial) as? Bool
        let customerID = self.userDefaults.object(forKey: Constants.customerId) as? Int
        let isLanguageSet = self.userDefaults.object(forKey: Constants.isLanguageSet) as? Bool
        let isLoggedIn = self.userDefaults.object(forKey: Constants.isLoggedIn) as? Bool


        print("isFromInitial \(isFromInitial)")
        print("customerID \(customerID)")
        print("isLanguageSet \(isLanguageSet)")
        
        if(customerID != nil && customerID != -1 && isLanguageSet ?? false && isFromInitial ?? true && isLoggedIn ?? false)
        {
            self.userDefaults.setValue(true, forKey: Constants.isFromInitial)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc1 = storyboard.instantiateViewController(withIdentifier: "languageVC")
            let vc2 = storyboard.instantiateViewController(withIdentifier: "loginVC")
            let vc3 = storyboard.instantiateViewController(withIdentifier: "equipmentVC")

            let controllers = [vc1, vc2, vc3]
            self.navigationController!.setViewControllers(self.navigationController!.viewControllers + controllers, animated: true)
        }
        else if(customerID != nil && customerID != -1 && isLanguageSet == true && isLoggedIn == false  && isFromInitial ?? true)
        {
            self.userDefaults.setValue(true, forKey: Constants.isFromInitial)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc1 = storyboard.instantiateViewController(withIdentifier: "languageVC")
            let vc2 = storyboard.instantiateViewController(withIdentifier: "loginVC")

            let controllers = [vc1, vc2]
            self.navigationController!.setViewControllers(self.navigationController!.viewControllers + controllers, animated: true)
        }
        else if(customerID != nil && customerID != -1 && isLanguageSet == false && isFromInitial ?? true)
        {
            self.userDefaults.setValue(true, forKey: Constants.isFromInitial)
            self.performSegue(withIdentifier: "showLanguageSelectionScreen", sender: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.nextButton.roundCorners(radius: 4.0)
        
        print("viewDidAppear")
    }
    
    var iDTF: RYFloatingInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addStatusBarGradient()
        
        self.iDTF = RYFloatingInput(frame: CGRect(x: 0, y: 20, width: self.customerIDView.bounds.width + 20, height: 30))
//        self.customerIDView.backgroundColor = UIColor.black
               self.iDTF!.setup(setting: RYFloatingInputSetting.Builder.instance()
               .backgroundColor(.clear)
               .textColor(.darkText)
               .placeholderColor(.lightGray)
               .dividerColor(UIColor(displayP3Red: 2.0/255.0, green: 171.0/255.0, blue: 231.0/255.0, alpha: 1.0))
               .cursorColor(.black)
               .accentColor(UIColor(displayP3Red: 2.0/255.0, green: 171.0/255.0, blue: 231.0/255.0, alpha: 1.0))
                   .maxLength(10, onViolated: (message: "Limit exceeded", callback: {
                       print("Limit exceeded")
                   }))
                   .inputType(.number, onViolated: (message: "Invalid input, number only", callback: {
                          print("Invalid input, number only")
                      }))
               .warningColor(.red)
                .placeholer("Customer ID")
                
                
               .build())
        
        let cidVWidth = self.customerIDView.bounds.width
        print("Customer ID view width: \(cidVWidth)")
        print("Next button width: \(self.nextButton.bounds.width)")
        self.iDTF?.frame = CGRect(x: -12, y: 20, width: cidVWidth + 62, height: 30)
        self.customerIDView.addSubview(self.iDTF!)
        self.customerIDView.clipsToBounds = true
//        let idtfWidth = self.iDTF!.frame.width
//        print("Customer ID TF width: \(cidVWidth)")
        
//        self.customerIDView.addConstraint(NSLayoutConstraint(item: self.iDTF!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
//        self.customerIDView.addConstraint(NSLayoutConstraint(item: self.iDTF!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))

        
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        if(isValidated())
        {
            startSpinner()
            Request.getCustomerConfig(customerID: self.customerIdTF.text! , delegate: self)
        }
        else{
            let alertController = UIAlertController(title: "Error", message: "Please enter a valid customer ID. You can only enter minimum 1 and maximum 100 characters", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    return
            }))
            self.present(alertController, animated: false) {
                
            }
        }
        
        
    }
    
    func isValidated() -> Bool
    {
        
        if((self.iDTF?.text()!.count)! <= 0){
            
            return false
        }
        if((self.iDTF?.text()!.count)! > 100){
            
            return false
        }
        return true
    }
    
    
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }

    func addStatusBarGradient()
    {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = CGRect(x:0, y:-20, width:375, height:64)
        gradientLayer.frame = CGRect(x:0, y:-20, width:self.view.frame.width, height:self.view.frame.height * 0.075)
        //  gradientLayer.frame = CGRect(x:0, y:-20, width:375, height:self.view.frame.height * 0.06)
        
        let colorTop = UIColor(red: 2 / 255.0, green: 171 / 255.0, blue: 231 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 76 / 255.0, green: 181 / 255.0, blue: 171 / 255.0, alpha: 1.0).cgColor
        
        gradientLayer.colors = [colorTop,    colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        let window: UIWindow? = UIApplication.shared.keyWindow
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 0, y: 0, width: (window?.frame.width)!, height: self.view.frame.height * 0.07)
        view.layer.addSublayer(gradientLayer)
        window?.addSubview(view)
    }
    
    func onErrorResponse(forMode mode: String, msg: String)
    {
        print("onErrorResponse \(msg)")
        stopSpinner()
    }
       
    func onSuccessResponse(forMode mode: String, data: Any)
    {
        print("onSuccessResponse \(data)")
        
        let json = JSON(data)
        
        let configuration = json["configuration"].rawString()
        print("\(Constants.TAG) configuration \(configuration)")

        let jsonData = configuration?.data(using: .utf8)!
        let customerConfigModel = try! JSONDecoder().decode(CustomerConfigModel.self, from: jsonData!)

        print("\(customerConfigModel.id)   \(customerConfigModel.operator_shift_hours)   \(customerConfigModel.languages?.count)")

        CoreDataStack.deleteAllRecords(entityName: "ConfigEntity")
        customerConfigModel.saveToDB()
        
        self.userDefaults.setValue(customerConfigModel.id, forKey: Constants.customerId)
        
        stopSpinner()
        
        self.userDefaults.setValue(false, forKey: Constants.isLoggedIn)
        self.userDefaults.setValue(false , forKey: Constants.isLanguageSet)
        self.userDefaults.setValue(true, forKey: Constants.isFromInitial)
        self.performSegue(withIdentifier: "showLanguageSelectionScreen", sender: self)
    }
       
    
    func startSpinner()
    {
        loadingNotif = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotif.mode = MBProgressHUDMode.indeterminate
        
        loadingNotif.label.text = "Processing"
        
    }
    
    func stopSpinner()
    {
        self.loadingNotif.hide(animated: true)
    }
}

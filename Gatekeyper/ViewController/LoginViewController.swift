//
//  LoginViewController.swift
//  Gatekeyper
//
//  Created by Qirtas on 11/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields
import MBProgressHUD
import SwiftyJSON


class LoginViewController: UIViewController , UITextFieldDelegate, RequestsGenericDelegate{

    
    @IBOutlet weak var showHidePwdBtn: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userNameTF: MDCTextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var forgotPasswordTF: UIButton!
    
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    var textFieldControllerFloating: MDCTextInputControllerUnderline!

    @IBOutlet weak var topMessageLabel: UILabel!
    @IBOutlet weak var topCompanyLabel: UILabel!
    @IBOutlet weak var topChangeBtnLabel: UIButton!
    
    @IBOutlet weak var usernameLabelTopConst: NSLayoutConstraint!
    

    
    let userDefaults = UserDefaults.standard;
    var loadingNotif:MBProgressHUD! = nil
    
    override func viewDidLayoutSubviews() {
        self.topBarView.addHorizontalGradient()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillAppear() {
        print("keyboardWillAppear")
        
        self.topMessageLabel.isHidden = true
        self.topCompanyLabel.isHidden = true
        self.topChangeBtnLabel.isHidden = true
        
        self.userNameLabel.frame.origin.y = 110
        self.userNameTF.frame.origin.y = 130
        
        self.passwordLabel.frame.origin.y = 170
        self.passwordTF.frame.origin.y = 190
        
        self.loginButton.frame.origin.y = 250
        self.forgotPasswordTF.frame.origin.y = 290

        
    }
    
    @objc func keyboardWillDisappear() {
        print("keyboardWillDisappear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loginButton.roundCorners(radius: 4.0)
        
        let colorTop = UIColor(red: 2 / 255.0, green: 171 / 255.0, blue: 231 / 255.0, alpha: 1.0)

        
        let isFromInitial = self.userDefaults.object(forKey: Constants.isFromInitial) as? Bool
        print("isFromInitial \(isFromInitial)")
        
         self.userDefaults.setValue(false, forKey: Constants.isLoggedIn)
        
        self.userNameTF.text = "Morgan@Example.com"
        self.passwordTF.text = "bechtel"
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let txt = textView.text.trimmingCharacters(in: .whitespaces)
        textFieldControllerFloating.isFloatingEnabled = !txt.isEmpty
    }

    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func loginButtonClicked(_ sender: Any)
    {
        if(!self.isUsernameValidated()){
            let alertController = UIAlertController(title: "Error", message: "Please enter a valid username. You can only enter minimum 1 and maximum 100 characters", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    return
            }))
            self.present(alertController, animated: false) {
                
            }
            return
        }
        
        if(!self.isPasswordValidated()){
            let alertController = UIAlertController(title: "Error", message: "Please enter a valid password. You can only enter minimum 1 and maximum 100 characters", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    return
            }))
            self.present(alertController, animated: false) {
                
            }
            return
        }
        
        let user:[UserEntity] =  User.getUser(userName: self.userNameTF.text ?? "")
        print("userName \(user.count)")
        
        var shouldSentOnlinerequest:Bool = false
        let PostDict = getLoginPostParams()
        print("PostDict \(PostDict)")
        
        if(user.count > 0)
        {
            let userEntity = user[0]
            let salt = userEntity.salt!
            let passwordDB = userEntity.password
            
            let userEnteredPassword = (self.passwordTF.text!) + salt
            let userEnteredPasswordHash = userEnteredPassword.sha512()
//            print("userEnteredPasswordHash \(userEnteredPasswordHash)")
//            print("passwordDB \(passwordDB)")
            
            if(userEnteredPasswordHash == passwordDB)
            {
                print("logged in succesffuly")
                Request.loginRequest(delegate: self, forData: PostDict ?? [:], isBackgroundCall: true)
                performSegue(withIdentifier: "showHomeScreen", sender: nil)

            }
            else
            {
                print("Password doesnt match")
                
                if(ReachabilityManager.isConnectedToNetwork())
                {
                    shouldSentOnlinerequest = true
                }
                else
                {
                    print("Show error dialog")
                    self.showDialog(withMessage: "Could not find credentials")
                }
            }
        }
        else if(ReachabilityManager.isConnectedToNetwork())
        {
            shouldSentOnlinerequest = true
        }
        else
        {
            print("Show error dialog")
            self.showDialog(withMessage: "Could not find credentials")
        }
        
        if(shouldSentOnlinerequest)
        {
            startSpinner()
            Request.loginRequest(delegate: self, forData: PostDict ?? [:], isBackgroundCall: false)
        }
    }
    
    func isUsernameValidated() -> Bool{
        if((self.userNameTF.text!.count <= 0)  || (self.userNameTF.text!.count > 100)){
            return false
        }
        return true
        
    }
    
    func isPasswordValidated() -> Bool{
        if((self.passwordTF.text!.count <= 0)  || (self.passwordTF.text!.count > 100)){
            return false
        }
        return true
        
    }
    
    
    
    @IBAction func forgotPasswordBtnClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "showForgotPasswordScreen", sender: nil)
    }
    
    @IBAction func changeCustomerBtnClicked(_ sender: Any) {
        
        guard let vcList = self.navigationController?.viewControllers else{
                  return
              }
              if vcList[vcList.count - 3] is CustomerViewController {
                self.userDefaults.setValue(false, forKey: Constants.isFromInitial)
                  self.navigationController?.popToViewController(vcList[vcList.count - 3], animated: true)
              }
    }
    
    func getLoginPostParams() -> [String:Any]?
    {
        var PostDictionary = [String:Any]()
        
        PostDictionary["username"] = self.userNameTF.text
        PostDictionary["password"] = self.passwordTF.text
        
        return PostDictionary
    }
    
    func onErrorResponse(forMode mode: String, msg: String)
    {
        print("onErrorResponse \(msg)")
        stopSpinner()
        
        self.showDialog(withMessage: "Error occured. please try again")
    }
       
    func onSuccessResponse(forMode mode: String, data: Any)
    {
       // print("onSuccessResponse \(data)")
        
        let json = JSON(data).rawString()
        
       // let user = json["user"].rawString()
      //  print("\(Constants.TAG) user \(user)")

        let jsonData = json?.data(using: .utf8)!
        let userModel = try! JSONDecoder().decode(User.self, from: jsonData!)
        userModel.updateUserInDB(userName: self.userNameTF.text!)
        
        print("\(Constants.TAG) user \(userModel.first_name)   username \(userModel.username)")
        
        stopSpinner()
        
        performSegue(withIdentifier: "showHomeScreen", sender: nil)
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
    
    func showDialog(withMessage message:String)
      {
        let alert = UIAlertController(title:message, message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
              
          }))
          self.present(alert, animated: true, completion: nil)
      }
    @IBAction func showHidePassword(_ sender: Any) {
        if (self.passwordTF.isSecureTextEntry){
            self.passwordTF.isSecureTextEntry = false
            self.showHidePwdBtn.setTitle("Hide", for: .normal)
        }
        else{
            self.passwordTF.isSecureTextEntry = true
            self.showHidePwdBtn.setTitle("Show", for: .normal)
        }
        
    }
}

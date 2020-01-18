//
//  ChangePasswordViewController.swift
//  Gatekeyper
//
//  Created by Muhammad Alvi on 16/01/2020.
//  Copyright © 2020 Qirtas. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var updatePasswordBtn: UIButton!
    
    @IBOutlet weak var newPasswordTF: UITextField!
   
    
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updatePasswordBtn.layer.cornerRadius = 10.0
        self.updatePasswordBtn.clipsToBounds = true
    }
    

    @IBAction func changePassword(_ sender: Any) {
    }
    
    @IBAction func showHideConfirmPassword(_ sender: Any) {
    
    }
    
    @IBAction func showHideNewPassword(_ sender: Any) {
        
        
    }
}

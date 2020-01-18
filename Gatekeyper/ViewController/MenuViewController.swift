//
//  MenuViewController.swift
//  Gatekeyper
//
//  Created by Qirtas on 23/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var appVersionLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLayoutSubviews() {
        self.topBarView.addHorizontalGradient()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func homeBtnClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func settingsBtnClicked(_ sender: Any) {
    }
    
    
    @IBAction func signOutBtnClicked(_ sender: Any) {
        
       guard let vcList = self.navigationController?.viewControllers else{
                         return
                     }
                     if vcList[vcList.count - 3] is LoginViewController {
                         self.navigationController?.popToViewController(vcList[vcList.count - 3], animated: true)
                     }
    }
    
}

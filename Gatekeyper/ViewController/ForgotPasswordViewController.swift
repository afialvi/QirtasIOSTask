//
//  ForgotPasswordViewController.swift
//  Gatekeyper
//
//  Created by Qirtas on 11/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var topMessageLabel: UILabel!
    
    @IBOutlet weak var verifyUserBtn: UIButton!
    
    override func viewDidLayoutSubviews() {
        self.topBarView.addHorizontalGradient()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.verifyUserBtn.roundCorners(radius: 4.0)
        self.topMessageLabel.text = "Enter the Asplundh provided username for receiving a verification code."
      //  self.topMessageLabel.adjustsFontSizeToFitWidth = true
        
        topMessageLabel.numberOfLines = 0
        topMessageLabel.lineBreakMode = .byWordWrapping
        topMessageLabel.frame.size.width = 300
        topMessageLabel.sizeToFit()

    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func verifyUserBtnClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "showVerifyAccountScreen", sender: nil)
    }
}

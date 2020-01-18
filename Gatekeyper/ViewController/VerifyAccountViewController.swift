//
//  VerifyAccountViewController.swift
//  Gatekeyper
//
//  Created by Qirtas on 11/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import UIKit

class VerifyAccountViewController: UIViewController {
    
    
    @IBOutlet weak var topBarView: UIView!
    
    @IBOutlet weak var topMessageLabel: UILabel!
    @IBOutlet weak var continueBtn: UIButton!
    
    override func viewDidLayoutSubviews() {
        self.topBarView.addHorizontalGradient()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.continueBtn.roundCorners(radius: 4.0)
        self.topMessageLabel.text = "Verification code has been sent to"
        self.topMessageLabel.adjustsFontSizeToFitWidth = true
    }
    

    @IBAction func continueBtnClicked(_ sender: Any) {
    }
    
    
    @IBAction func resendCodeBtnClicked(_ sender: Any) {
    }
    
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

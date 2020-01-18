//
//  ShowMessageViewController.swift
//  Gatekeyper
//
//  Created by Muhammad Alvi on 13/01/2020.
//  Copyright © 2020 Qirtas. All rights reserved.
//

import UIKit

class ShowMessageViewController: UIViewController {
    @IBOutlet weak var enterOrExitLabel: UILabel!
    
    @IBOutlet weak var subMsgLbl: UILabel!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var successOrFailureMsgLbl: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var msgView: UIView!
    @IBOutlet weak var equipmentIDLbl: UILabel!
    
    @IBOutlet weak var successOrFailureImgV: UIImageView!
    
    var isSuccess = true
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowView.layer.cornerRadius = 15
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowRadius = 7.0
        shadowView.layer.masksToBounds =  false
        self.msgView.layer.cornerRadius = 5.0
        self.msgView.clipsToBounds = true
        self.homeBtn.layer.cornerRadius = 3.0
        self.homeBtn.clipsToBounds = true
        
        if(self.isSuccess){
            self.subMsgLbl.text = "You shift has started"
            self.successOrFailureMsgLbl.text = "Successfully Entered"
            self.successOrFailureImgV.image = UIImage(named: "Group 105.png")
            self.homeBtn.setTitle("Home", for: .normal)
        }
        else{
            self.subMsgLbl.text = "Test Failed"
             self.successOrFailureMsgLbl.text = "Remaining Attempts: 1"
             self.successOrFailureImgV.image = UIImage(named: "Group 141.png")
            self.homeBtn.setTitle("Retake Test", for: .normal)
        }
        
    }
    
    @IBAction func nextAction(_ sender: Any) {
    }
    
    @IBAction func goToHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

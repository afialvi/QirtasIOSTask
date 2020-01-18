//
//  ViewController.swift
//  Gatekeyper
//
//  Created by Qirtas on 09/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields
import RYFloatingInput


class ViewController: UIViewController , UITextViewDelegate{
    
    var textFieldControllerFloating: MDCTextInputControllerUnderline!
    
    @IBOutlet weak var mineView: UIView!
    @IBOutlet weak var shadowView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowView.layer.cornerRadius = 15
             shadowView.layer.shadowColor = UIColor.gray.cgColor
             shadowView.layer.shadowOffset = CGSize.zero
             shadowView.layer.shadowOpacity = 0.5
             shadowView.layer.shadowRadius = 7.0
             shadowView.layer.masksToBounds =  false
        
        
    }

    func textViewDidChange(_ textView: UITextView) {
        let txt = textView.text.trimmingCharacters(in: .whitespaces)
        textFieldControllerFloating.isFloatingEnabled = !txt.isEmpty
    }

}


//
//  OpenEndedView.swift
//  Gatekeyper
//
//  Created by Muhammad Alvi on 15/01/2020.
//  Copyright © 2020 Qirtas. All rights reserved.
//

import UIKit

class OpenEndedView: UIView {

    @IBOutlet weak var proceedBtn: UIButton!
    var delegate: NextQuestion?
    
    @IBAction func proceed(_ sender: Any) {
        self.delegate?.showNextQuestion()
    }
    
}

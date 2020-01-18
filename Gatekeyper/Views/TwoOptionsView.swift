//
//  TwoOptionsView.swift
//  Gatekeyper
//
//  Created by Muhammad Alvi on 15/01/2020.
//  Copyright © 2020 Qirtas. All rights reserved.
//

import UIKit

class TwoOptionsView: UIView {
    
    var delegate: NextQuestion?

    @IBOutlet weak var option2Lbl: UILabel!
    
    @IBOutlet weak var option1Lbl: UILabel!
    
    @IBAction func option2Selected(_ sender: Any) {
         self.delegate?.showNextQuestion()
    }
    
    @IBAction func option1Selected(_ sender: Any) {
         self.delegate?.showNextQuestion()
    }
}

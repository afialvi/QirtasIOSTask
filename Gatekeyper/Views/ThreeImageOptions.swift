//
//  ThreeImageOptions.swift
//  Gatekeyper
//
//  Created by Muhammad Alvi on 15/01/2020.
//  Copyright © 2020 Qirtas. All rights reserved.
//

import UIKit

class ThreeImageOptions: UIView {
    
    var delegate: NextQuestion?

    @IBOutlet weak var option3Lbl: UILabel!
    
    @IBOutlet weak var option3ImgV: UIImageView!
    
    @IBOutlet weak var option2Lbl: UILabel!
    @IBOutlet weak var option2ImgV: UIImageView!

    @IBOutlet weak var option1Lbl: UILabel!
    @IBOutlet weak var option1ImgV: UIImageView!
    

    @IBAction func option1Selected(_ sender: Any) {
         self.delegate?.showNextQuestion()
    }
    
    
    @IBAction func option2Selected(_ sender: Any) {
         self.delegate?.showNextQuestion()
    }
    
    
    @IBAction func option3Selected(_ sender: Any) {
         self.delegate?.showNextQuestion()
    }
    


}

//
//  EquipmentInnerTableViewCell.swift
//  Gatekeyper
//
//  Created by Qirtas on 24/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import UIKit

class EquipmentInnerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var vinLabel: UILabel!
    
    @IBOutlet weak var signalImageView: UIImageView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var actionView: UIView!
    
    @IBOutlet weak var actionLabel: UILabel!
    
    @IBOutlet weak var auxiliaryView: UIView!
    
    @IBOutlet weak var lockedStatusImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateAuxiliaryCell(isLast:Bool)
    {
        self.actionView.layer.cornerRadius = 4.0
        self.actionView.clipsToBounds = true
        
        self.auxiliaryView.layer.cornerRadius = 10.0
        self.auxiliaryView.clipsToBounds = true
        
        shadowView.layer.cornerRadius = 15
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowRadius = 7.0
        shadowView.layer.masksToBounds =  false
        
        print("isLast \(isLast)")
        
        if(isLast)
        {
            self.innerView.roundedBottomCorners()
            
//            innerView.clipsToBounds = true
//            innerView.layer.cornerRadius = 10

        }
        else
        {
           self.innerView.roundCorners(radius: 0.0)
            
//            innerView.clipsToBounds = true
//            innerView.layer.cornerRadius = 0
        }
    }

}

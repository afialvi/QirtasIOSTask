//
//  EquipmentOuterTableViewCell.swift
//  Gatekeyper
//
//  Created by Qirtas on 24/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import UIKit

class EquipmentOuterTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var vinLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var signalImageView: UIImageView!
    
    @IBOutlet weak var actionView: UIView!
    
    @IBOutlet weak var lockedStatusImageView: UIImageView!
    
    @IBOutlet weak var remainingAttemptsView: UIView!
    
    @IBOutlet weak var remainingAttemptsViewHeightConst: NSLayoutConstraint!
    
    @IBOutlet weak var blocked_imageView: UIImageView!
    
    @IBOutlet weak var emergency_label: UILabel!
    @IBOutlet weak var emergency_ic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateEquipmentCell(model: cellData)
    {
        self.innerView.roundedTopCorners()
        
        self.actionView.layer.cornerRadius = 4.0
        self.actionView.clipsToBounds = true
        
        shadowView.layer.cornerRadius = 15
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowRadius = 7.0
        shadowView.layer.masksToBounds =  false
        
        
        if(model.sectionData.count == 0)
        {
            self.innerView.roundCorners(radius: 10.0)
        }
        
        if(model.isRemainingAttemps)
        {
            self.remainingAttemptsView.isHidden = true
            self.remainingAttemptsViewHeightConst.constant = 0
        }
        else
        {
            self.remainingAttemptsView.isHidden = true
            self.remainingAttemptsViewHeightConst.constant = 0
        }
        
        if(model.isBlocked)
        {
            self.blocked_imageView.isHidden = false
            self.actionView.isHidden = true
            self.emergency_ic.isHidden = true
            self.emergency_label.isHidden = true
        }
        else
        {
            if(model.isEmergencyActivated)
            {
                self.blocked_imageView.isHidden = true
                self.actionView.isHidden = false
                self.emergency_ic.isHidden = false
                self.emergency_label.isHidden = false
            }
            else
            {
                self.blocked_imageView.isHidden = true
                self.actionView.isHidden = false
                self.emergency_ic.isHidden = true
                self.emergency_label.isHidden = true
            }
        }
        
    }

}

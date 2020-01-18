//
//  AuxTableViewCell.swift
//  Equipment
//
//  Created by Qirtas on 24/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import UIKit

class AuxTableViewCell: UITableViewCell {
    @IBOutlet weak var actionView: UIView!
    
    @IBOutlet weak var auxiliaryView: UIView!
    @IBOutlet weak var lockImageView: UIImageView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var actionLabel: UILabel!
    
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var serialNumber: UILabel!
    
    @IBOutlet weak var titleLbl: UILabel!
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(eqCellData: [String: Any], indexPath: IndexPath){
        self.indexPath = indexPath
        self.auxiliaryView.layer.cornerRadius = 11.0
        self.auxiliaryView.clipsToBounds = true
        let cellInfo = (eqCellData["Aux"] as! [[String: Any]])
        let rowIndex = self.indexPath!.row
        let auxInfo = cellInfo[rowIndex]
        self.titleLbl.text = auxInfo["title"] as! String
        self.serialNumber.text = auxInfo["VIN"] as! String
        let actionText = auxInfo["action"] as! String
        self.stateLbl.text = auxInfo["state"] as! String
        self.actionLabel.text = actionText
        self.actionView.layer.cornerRadius = 4.0
        self.actionView.clipsToBounds = true
        if(actionText == "Exit"){
            self.actionView.backgroundColor = UIColor(displayP3Red: 220.0/255.0, green: 32.0/255.0, blue: 33.0/255.0, alpha: 1.0)
        }
        else{
            self.actionView.backgroundColor = UIColor(displayP3Red: 0.0, green: 180.0/255.0, blue: 18.0/255.0, alpha: 1.0)
        }
        if(Int((auxInfo["remainingMinutes"] as! String))! > 0){
             self.stateLbl.text = "\(self.stateLbl.text!) - Remaining Minutes:  \(auxInfo["remainingMinutes"] as! String)"
        }
        if((auxInfo["state"] as! String) == "Locked"){
            self.lockImageView.image = UIImage(named: "locked_red.png")
            self.leftView.backgroundColor = UIColor(displayP3Red: 220.0/255.0, green: 32.0/255.0, blue: 33.0/255.0, alpha: 1.0)
        }
        else if((auxInfo["state"] as! String) == "Unclocked" || (auxInfo["state"] as! String) == "Unlocked" ||
            (auxInfo["state"] as! String) == "Scheduled Unlock"){
           self.lockImageView.image = UIImage(named: "locked_red.png")
            
            self.leftView.backgroundColor = UIColor(displayP3Red: 0.0, green: 180.0/255.0, blue: 18.0/255.0, alpha: 1.0)
        }
        self.bringSubviewToFront(self.lockImageView)
        
    }
    
    
    
}

//
//  AuxilaryTableViewCell.swift
//  Gatekeyper
//
//  Created by Qirtas on 23/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import UIKit

class AuxilaryTableViewCell: UITableViewCell {

    @IBOutlet weak var lockImageView: UIImageView!
    
    @IBOutlet weak var auxilayView: UIView!
    @IBOutlet weak var actionView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func updateCell(eqCellData: [String: Any], indexPath: IndexPath){
           
            self.auxilayView.layer.cornerRadius = 11.0
            self.auxilayView.clipsToBounds = true
        
         //   self.actionLabel.text = actionText
            self.actionView.layer.cornerRadius = 4.0
            self.actionView.clipsToBounds = true
        
          // self.bringSubviewToFront(self.lockImageView)
           
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           print("Aux cell selected at  \(indexPath)")
       }
    
}

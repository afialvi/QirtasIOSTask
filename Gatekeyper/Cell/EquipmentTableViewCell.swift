//
//  EquipmentTableViewCell.swift
//  Equipment
//
//  Created by Qirtas on 24/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import UIKit

class EquipmentTableViewCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var shadowLayerTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var shadowLayerLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var auxTableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var shadowLayerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var bottomSeparatorView: UIView!
    @IBOutlet weak var blockedImageView: UIImageView!
    @IBOutlet weak var shadowLayer: UIView!
    @IBOutlet weak var remainingAttemptsHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var remainingAttemptsView: UIView!
    
    @IBOutlet weak var remainingAttemptsLabel: UILabel!
    @IBOutlet weak var emergencyView: UIView!
    @IBOutlet weak var lockImageView: UIImageView!
    
    @IBOutlet weak var signalStateImageView: UIImageView!
    @IBOutlet weak var enterExitLbl: UILabel!
    
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var vinLbl: UILabel!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    var cellIndexPath : IndexPath?
    
    override var frame: CGRect {
      get {
          return super.frame
      }
      set (newFrame) {
          var frame =  newFrame
          frame.origin.y += 4
          frame.size.height -= 3 * 5
        frame.origin.x += 8
        frame.size.width -= 5 * 5
          super.frame = frame
      }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.cellIndexPath ==  nil){
            return 0
        }
        let cellInfo = Data.dataJson["Equipment"]?[self.cellIndexPath!.row]
        
        let auxArr = cellInfo!["Aux"]
        return auxArr == nil ? 0 : (auxArr as! [[String: Any]]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuxilaryTableViewCell", for: indexPath) as! AuxilaryTableViewCell
        cell.updateCell(eqCellData: (Data.dataJson["Equipment"]?[self.cellIndexPath!.row])!, indexPath: indexPath)
        return cell
    }
    
    func updateEquipmentCell(indexPath : IndexPath){
        
        let auxNib = UINib(nibName: "AuxilaryTableViewCell", bundle: nil)
        self.auxTableView.register(auxNib, forCellReuseIdentifier: "AuxilaryTableViewCell")
        self.cellIndexPath = indexPath
        self.auxTableView.delegate = self
        self.auxTableView.dataSource = self
        let cellInfo = Data.dataJson["Equipment"]?[self.cellIndexPath!.row]
        self.titleLabel.text = cellInfo!["title"] as! String
        self.vinLbl.text = cellInfo!["VIN"] as! String
        self.stateLbl.text = cellInfo!["state"] as! String
        let actionText = cellInfo!["action"] as! String
        self.enterExitLbl.text = actionText
        let auxInfo = Data.dataJson["Equipment"]![self.cellIndexPath!.row]["Aux"]
        let doesNotHaveAuxInfos = ((auxInfo == nil) || (auxInfo as! [[String: Any]]).count == 0)
        if (doesNotHaveAuxInfos){
            self.bottomSeparatorView.isHidden = true
        }
        else{
            self.bottomSeparatorView.isHidden = false
        }
        if(Int((cellInfo!["remainingMinutes"] as! String))! > 0){
             self.stateLbl.text = "\(self.stateLbl.text!) - Remaining Minutes:  \(cellInfo!["remainingMinutes"] as! String)"
        }
        
        if((cellInfo!["isUseAble"] as! String) == "false")
        {
                    self.lockImageView.image = UIImage(named: "locked_red.png")
                    
                    self.leftView.backgroundColor = UIColor.lightGray
                    self.actionView.backgroundColor = UIColor.lightGray
//                    self.blockedImageView.isHidden = false
                    self.signalStateImageView.image = UIImage(named: "wifi_blocked")
                    self.stateLbl.textColor = UIColor.lightGray
            if((cellInfo!["isBlocked"] as! String) == "true"){
                        self.lockImageView.image = UIImage(named: "locked_red.png")
                        
                        self.leftView.backgroundColor = UIColor.lightGray
                        self.actionView.isHidden = true
                        self.blockedImageView.isHidden = false
                        self.signalStateImageView.image = UIImage(named: "wifi_blocked")
            //            self.stateLbl.textColor = UIColor.lightGray
                        
            }
                    
        }
        else
        {
        if((cellInfo!["isBlocked"] as! String) == "true"){
            self.lockImageView.image = UIImage(named: "locked_red.png")
            
            self.leftView.backgroundColor = UIColor.lightGray
            self.actionView.isHidden = true
            self.blockedImageView.isHidden = false
            self.signalStateImageView.image = UIImage(named: "full_signal_ic")
            
        }
        else{
            if(actionText == "Exit"){
                self.actionView.backgroundColor = UIColor(displayP3Red: 220.0/255.0, green: 32.0/255.0, blue: 33.0/255.0, alpha: 1.0)
            }
            else{
                self.actionView.backgroundColor = UIColor(displayP3Red: 0.0, green: 180.0/255.0, blue: 18.0/255.0, alpha: 1.0)
            }
            self.actionView.layer.cornerRadius = 4.0
            self.actionView.clipsToBounds = true
            self.signalStateImageView.image = UIImage(named: "full_signal_ic.png")
            self.actionView.isHidden = false
            self.blockedImageView.isHidden = true
        if((cellInfo!["state"] as! String) == "Locked"){
            self.lockImageView.image = UIImage(named: "locked_red.png")
            
             self.leftView.backgroundColor = UIColor(displayP3Red: 220.0/255.0, green: 32.0/255.0, blue: 33.0/255.0, alpha: 1.0)
        }
        else if((cellInfo!["state"] as! String) == "Unclocked" || (cellInfo!["state"] as! String) == "Unlocked" || (cellInfo!["state"] as! String) == "Scheduled Unlock"){
            self.lockImageView.image = UIImage(named: "locked_red.png")
           self.leftView.backgroundColor = UIColor(displayP3Red: 0.0, green: 180.0/255.0, blue: 18.0/255.0, alpha: 1.0)
        }
        if((cellInfo!["isEmergencyActivated"] as! String) == "true"){
            self.emergencyView.isHidden = false
        }
        else if((cellInfo!["isEmergencyActivated"] as! String) == "false"){
            self.emergencyView.isHidden = true
        }
        }
        }
        if(Int(cellInfo!["remainingTestAttempts"] as! String)! <= 0){
            self.remainingAttemptsHeightConstraint.constant = 0
            self.remainingAttemptsView.isHidden = true
            self.remainingAttemptsLabel.text = ""
        }
        else{
            self.remainingAttemptsHeightConstraint.constant = 30
            self.remainingAttemptsView.isHidden = false
            self.remainingAttemptsLabel.text = "Remaining Test Attempts Left: : \(Int(cellInfo!["remainingTestAttempts"] as! String)!)"
        }
        
        
        self.shadowLayer.layer.shadowColor = UIColor.black.cgColor
        self.shadowLayer.layer.shadowOpacity = 0.5
        self.shadowLayer.layer.shadowOffset = .init(width: 0.0, height: 10.0)
        self.shadowLayer.layer.shadowRadius = 5
        self.shadowLayerHeightConstraint.constant = self.bounds.height - 20
        self.mainViewHeightConstraint.constant = self.bounds.height - 20
        self.shadowLayerLeadingConstraint.constant = 0
        self.shadowLayerLeadingConstraint.constant = 0
 
        if(doesNotHaveAuxInfos){
         self.auxTableViewHeightConstraint.constant = 0
        }
        else{
            self.auxTableViewHeightConstraint.constant = CGFloat((auxInfo as! [[String: Any]]).count * 100)
        }
        
        self.mainView.layer.cornerRadius = 8.0
        self.mainView.clipsToBounds = true
        self.shadowLayer.layer.cornerRadius = 8.0
//        self.shadowLayer.clipsToBounds = true
        self.auxTableView.clipsToBounds = false
        self.auxTableView.reloadData()
        
//        if(!doesNotHaveAuxInfos){
//            self.addAuxLockImages(auxInfo: auxInfo, cellInfo: cellInfo)
//        }
    }
    
    
    func addAuxLockImages(auxInfo: Any?, cellInfo: [String: Any]?){
        let auxArr = auxInfo as! [[String: Any]]
        for i in 0...(auxArr.count - 1){
            let yIndex = 34 + ((i + 1) * 100)
            let v = UIImageView(frame: CGRect(x: 4.0, y: CGFloat(yIndex), width: 35.0, height: 35.0))
            v.image = UIImage(named: "locked_red.png")
            
//            if((auxArr[i]["isUseAble"] as! String) == "false" || (auxArr[i]["isBlocked"] as! String) == "true" ||
//                (cellInfo!["isUseAble"] as! String) == "false" ||
//                (cellInfo!["isBlocked"] as! String) == "true"){
//                v.image = UIImage(named: "locked_red.png")
//            }
//            else{
//                if((auxArr[i]["state"] as! String) == "Locked"){
//                    v.image = UIImage(named: "locked_red.png")
//                }
//                else if((auxArr[i]["state"] as! String) == "Unclocked" || (auxArr[i]["state"] as! String) == "Unlocked" || (auxArr[i]["state"] as! String) == "Scheduled Unlock"){
//                    v.image = UIImage(named: "locked_red.png")
//
//                }
//            }
            v.contentMode = .scaleToFill
            self.addSubview(v)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return CGFloat(100.0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Equipment cell selected at  \(indexPath)")
    }

    @IBOutlet weak var auxTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}

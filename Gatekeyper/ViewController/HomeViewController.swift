//
//  HomeViewController.swift
//  Gatekeyper
//
//  Created by Qirtas on 22/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var user_button: UIButton!
    @IBOutlet weak var search_button: UIButton!
    
    @IBOutlet weak var equipmentsTableView: UITableView!
    
    let userDefaults = UserDefaults.standard;
    
    override func viewDidLayoutSubviews() {
        self.topBarView.addHorizontalGradient()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userDefaults.setValue(true, forKey: Constants.isLoggedIn)
        
        self.equipmentsTableView.delegate = self
       self.equipmentsTableView.dataSource = self
       let equipmentCellNib = UINib(nibName: "EquipmentTableViewCell", bundle: nil)
       self.equipmentsTableView.register(equipmentCellNib, forCellReuseIdentifier: "EquipmentTableViewCell")
       self.equipmentsTableView.backgroundColor = UIColor(displayP3Red: 250.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1.0)
       self.equipmentsTableView.clipsToBounds = false
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return Data.dataJson["Equipment"]!.count
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "EquipmentTableViewCell", for: indexPath) as! EquipmentTableViewCell
                cell.updateEquipmentCell(indexPath: indexPath)
    //            cell.layer.cornerRadius = 8.0
                cell.clipsToBounds = false
                cell.backgroundColor = UIColor.clear
        //        cell.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        //        cell.layer.shouldRasterize = true
                
                
                return cell
            }
            
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
                let auxInfo = Data.dataJson["Equipment"]![indexPath.row]["Aux"]
                let cellInfo = Data.dataJson["Equipment"]![indexPath.row]
                var attemptsViewHeight = 0
                if(Int(cellInfo["remainingTestAttempts"] as! String)! <= 0){
                    attemptsViewHeight = 0
                }
                else{
                    attemptsViewHeight = 30
                }
                let doesNotHaveAuxInfos = ((auxInfo == nil) || (auxInfo as! [[String: Any]]).count == 0)
                
                let rowHeight =  doesNotHaveAuxInfos ? CGFloat(100.0) + CGFloat(attemptsViewHeight) + 35: CGFloat(100.0) + (CGFloat((auxInfo as! [[String: Any]]).count) * CGFloat(100.0)) + CGFloat(attemptsViewHeight) + 35
                
                if((cellInfo["isEmergencyActivated"] as! String) == "true"){
                    print("Row Height: \(rowHeight)")
                }
                return rowHeight
            }
    
    @IBAction func user_btn_clicked(_ sender: Any) {
        
        performSegue(withIdentifier: "showMenuScreen", sender: nil)
    }
    
}

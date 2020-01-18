//
//  EquipmentViewController.swift
//  Gatekeyper
//
//  Created by Qirtas on 24/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import UIKit

struct cellData
{
    var title = String()
    var sectionData = [String]()
    var isRemainingAttemps:Bool
    var isEmergencyActivated:Bool
    var isBlocked:Bool
}

class EquipmentViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var topBarView: UIView!
    
     var tableViewData = [cellData]()
    
    override func viewDidLayoutSubviews() {
           self.topBarView.addHorizontalGradient()
           
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewData = [cellData(title: "Title1", sectionData: ["cell1 - Title 1" , "cell2" , "cell3" , "4"], isRemainingAttemps: false , isEmergencyActivated: true , isBlocked: false),
                         cellData( title: "Title2", sectionData: ["cell1 - Title 2" , "cell2" , "cell3"], isRemainingAttemps: true, isEmergencyActivated: true , isBlocked: false),
                         cellData(title: "Title3", sectionData: ["cell1" , "cell2" , "cell3"], isRemainingAttemps: false, isEmergencyActivated: true , isBlocked: false),
                         cellData( title: "Title4", sectionData: ["cell1" , "cell2" , "cell3 - last"], isRemainingAttemps: false, isEmergencyActivated: true , isBlocked: true),
                         cellData(title: "Mine", sectionData: [], isRemainingAttemps: true, isEmergencyActivated: true , isBlocked: false)
        ]
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
     //   tableView.allowsSelection = false

    }
    
    
    @IBAction func menuBtnClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "showMenuScreen", sender: nil)
    }
}


extension EquipmentViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return tableViewData[section].sectionData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0
        {
            print("*******")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? EquipmentOuterTableViewCell else {return EquipmentOuterTableViewCell()}
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            let cellModel = tableViewData[indexPath.section]
            
            var hasInnerData:Bool = true
            let secionCount = tableViewData[indexPath.section].sectionData.count

            if(secionCount == 0)
            {
                hasInnerData = false
            }
            else
            {
                hasInnerData = true
            }
            
            
            cell.updateEquipmentCell(model: cellModel)
            
          //  cell.setDataForMain(name: tableViewData[indexPath.section].title, hasInnerData: hasInnerData)

            return cell
        }
        else
        {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "innerCell")  as? EquipmentInnerTableViewCell else {return EquipmentInnerTableViewCell()}
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            let cellModel = tableViewData[indexPath.section]
            
            var isLastRow:Bool = false
            let secionCount = tableViewData[indexPath.section].sectionData.count
            if(dataIndex == secionCount - 1)
            {
                isLastRow = true
            }
            cell.updateAuxiliaryCell(isLast: isLastRow)
            
        //    cell.setDataInner(name: tableViewData[indexPath.section].sectionData[dataIndex], isLast: isLastRow)
            
//            cell.layoutIfNeeded()
//            cell.updateConstraintsIfNeeded()
            
            return cell
        }
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let cell = self.tableViewData[indexPath.row]
        let dataIndex = indexPath.row - 1

        if indexPath.row == 0
        {
            let cell = self.tableViewData[indexPath.section]
            let title = tableViewData[indexPath.section].title
            
            print("didSelectRowAt CELL \(cell.title)")
        }
        else
        {
            let secionCount = tableViewData[indexPath.section].sectionData.count
            
            let innerCell = self.tableViewData[indexPath.section].sectionData[dataIndex]
            print("didSelectRowAt INNER \(innerCell)")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
         return CGFloat(120)
        
        
//        let cellModel = tableViewData[indexPath.section]
//        if(cellModel.isRemainingAttemps)
//        {
//            return 150
//        }
//        else
//        {
//            return 120
//        }
    
    }
    
}

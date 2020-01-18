//
//  ThreeImageOptionsViewController.swift
//  Gatekeyper
//
//  Created by Muhammad Alvi on 13/01/2020.
//  Copyright © 2020 Qirtas. All rights reserved.
//

import UIKit

class ThreeImageOptionsViewController: UIViewController {
    @IBOutlet weak var option1ImgV: UIImageView!
    @IBOutlet weak var enterOrExitLbl: UILabel!
    
    @IBOutlet weak var option3Imgv: UIImageView!
    @IBOutlet weak var option2Imgv: UIImageView!
    @IBOutlet weak var option3Lbl: UILabel!
    @IBOutlet weak var option2Lbl: UILabel!
    @IBOutlet weak var option1Lbl: UILabel!
    @IBOutlet weak var questionNumberLbl: UILabel!
    @IBOutlet weak var equipmentCodeLbl: UILabel!
   
    @IBOutlet weak var questionLbl: UILabel!
    
    var question: [String: Any]?
    var questions: [[String: Any]]?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.populateData()
        
    }
    
    func populateData(){
        let options = self.question!["options"] as! [[String: Any]]
        let url = URL(string: options[0]["url"] as! String)
        self.option1ImgV.sd_setImage(with: url, completed: nil)
        let url2 = URL(string: options[1]["url"] as! String)
        self.option2Imgv.sd_setImage(with: url2, completed: nil)
        let url3 = URL(string: options[2]["url"] as! String)
        self.option3Imgv.sd_setImage(with: url3, completed: nil)
        
    }
    
    
    @IBAction func cancel(_ sender: Any) {
    }
    
    @IBAction func option3Selected(_ sender: Any) {
        let q = Utils.getNextQuestion(id: self.question!["id"] as! String)
        if (q == nil){
            return
        }
        if(q!["type"] as! String == "ImageAnswer"){
            performSegue(withIdentifier: "goToTakePhotoVC", sender: nil)
        }
        
    }
    @IBAction func option2Selected(_ sender: Any) {
        let q = Utils.getNextQuestion(id: self.question!["id"] as! String)
         if (q == nil){
             return
         }
         if(q!["type"] as! String == "ImageAnswer"){
             performSegue(withIdentifier: "goToTakePhotoVC", sender: nil)
         }
    }
    @IBAction func option1Selected(_ sender: Any) {
         let q = Utils.getNextQuestion(id: self.question!["id"] as! String)
         if (q == nil){
             return
         }
         if(q!["type"] as! String == "ImageAnswer"){
             performSegue(withIdentifier: "goToTakePhotoVC", sender: nil)
         }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTakePhotoVC" {
            if let destinationVC = segue.destination as? UploadPhotoViewController {
                destinationVC.question = Utils.getNextQuestion(id: self.question!["id"] as! String)
                destinationVC.questions = SampleJson.data["questions"] as! [[String: Any]]
            }
        }
    }
    
    
    
    
    
    
}

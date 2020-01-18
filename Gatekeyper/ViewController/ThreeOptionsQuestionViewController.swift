//
//  ThreeOptionsQuestionViewController.swift
//  Gatekeyper
//
//  Created by Muhammad Alvi on 12/01/2020.
//  Copyright © 2020 Qirtas. All rights reserved.
//

import UIKit

class ThreeOptionsQuestionViewController: UIViewController {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var option1Lbl: UILabel!
   
    @IBOutlet weak var option2Lbl: UILabel!
    
    @IBOutlet weak var option3Lbl: UILabel!
    var question: [String: Any]?
    var questions: [[String: Any]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.populateData()
        
        shadowView.layer.cornerRadius = 15
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowRadius = 7.0
        shadowView.layer.masksToBounds =  false
    
    }
    func populateData(){
        let options = question!["options"] as! [[String: Any]]
        self.option1Lbl.text = options[0]["title"] as! String
        self.option2Lbl.text = options[1]["title"] as! String
        self.option3Lbl.text = options[0]["title"] as! String
        self.questionLbl.text = self.question!["text"] as! String
    }
    
    @IBAction func help(_ sender: Any) {
    }
    @IBAction func option1Selected(_ sender: Any) {
        if(Utils.getNextQuestion(id: self.question!["id"] as! String) != nil){
            performSegue(withIdentifier: "goToTwoOptionsVC", sender: nil)
        }
        
        
    }
    @IBAction func option2Selected(_ sender: Any) {
        if(Utils.getNextQuestion(id: self.question!["id"] as! String) != nil){
            performSegue(withIdentifier: "goToTwoOptionsVC", sender: nil)
        }
        
    }
    
    @IBAction func option3Selected(_ sender: Any) {
        if(Utils.getNextQuestion(id: self.question!["id"] as! String) != nil){
            performSegue(withIdentifier: "goToTwoOptionsVC", sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTwoOptionsVC" {
            if let destinationVC = segue.destination as? TwoOptionsViewController {
                destinationVC.question = Utils.getNextQuestion(id: self.question!["id"] as! String)
                destinationVC.questions = SampleJson.data["questions"] as! [[String: Any]]
            }
        }
    }
    
    
}

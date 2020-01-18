//
//  TwoOptionsViewController.swift
//  Gatekeyper
//
//  Created by Muhammad Alvi on 14/01/2020.
//  Copyright © 2020 Qirtas. All rights reserved.
//

import UIKit

class TwoOptionsViewController: UIViewController {

    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var equipmentIDLbl: UILabel!
    @IBOutlet weak var enterExitLbl: UILabel!
    @IBOutlet weak var option2Lbl: UILabel!
    @IBOutlet weak var option1Lbl: UILabel!
    
    var question: [String: Any]?
    var questions: [[String: Any]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.populateData()
        // Do any additional setup after loading the view.
    }
    
    func populateData(){
        let options = self.question!["options"]! as! [[String: Any]]
        self.option1Lbl.text = options[0]["title"] as! String
        self.option2Lbl.text = options[1]["title"] as! String
        self.questionText.text = self.question!["text"] as! String
        self.questionLbl.text = "\(self.question!["id"]!)" + "/" + "\(self.questions!.count)"
    }
    

    @IBAction func option1Selected(_ sender: Any) {
        let q = Utils.getNextQuestion(id: self.question!["id"] as! String)
        if(q!["type"] as! String == "Text"){
            performSegue(withIdentifier: "goToOpenQuestionVC", sender: nil)
        }
    }
    
    @IBAction func option2Selected(_ sender: Any) {
        let q = Utils.getNextQuestion(id: self.question!["id"] as! String)
        if(q!["type"] as! String == "Text"){
            performSegue(withIdentifier: "goToOpenQuestionVC", sender: nil)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToOpenQuestionVC" {
            if let destinationVC = segue.destination as? OpenQuestionViewController {
                destinationVC.question = Utils.getNextQuestion(id: self.question!["id"] as! String)
                destinationVC.questions = SampleJson.data["questions"] as! [[String: Any]]
            }
        }
    }
    
}

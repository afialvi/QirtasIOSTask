//
//  OpenQuestionViewController.swift
//  Gatekeyper
//
//  Created by Muhammad Alvi on 13/01/2020.
//  Copyright © 2020 Qirtas. All rights reserved.
//

import UIKit

class OpenQuestionViewController: UIViewController {

    @IBOutlet weak var equipmentIDLbl: UILabel!
    @IBOutlet weak var enterOrExitLbl: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    
    @IBOutlet weak var questionNumberLbl: UILabel!
    @IBOutlet weak var answerTF: UITextField!
    var question: [String: Any]?
    var questions : [[String: Any]]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.questionLbl.text = self.question!["text"] as! String
       
    }
    
    @IBAction func cancel(_ sender: Any) {
    }
    @IBAction func proceed(_ sender: Any) {
        let q = Utils.getNextQuestion(id: self.question!["id"] as! String)
        if(q == nil){
            return
        }
        if(q!["type"] as! String == "MCQ-Image"){
            performSegue(withIdentifier: "goToMCQImageVC", sender: nil)
        }
        else if (q!["type"] as! String == "Text"){
            self.updateNextQuestionDataInCurrentView()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "goToMCQImageVC" {
                   if let destinationVC = segue.destination as? ThreeImageOptionsViewController {
                       destinationVC.question = Utils.getNextQuestion(id: self.question!["id"] as! String)
                       destinationVC.questions = SampleJson.data["questions"] as! [[String: Any]]
                   }
               }
    }
    
    
    func updateNextQuestionDataInCurrentView(){
        let q = Utils.getNextQuestion(id: self.question!["id"] as! String)
         self.questionLbl.text = q!["text"] as! String
    }
    
}

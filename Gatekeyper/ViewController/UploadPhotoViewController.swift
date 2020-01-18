//
//  UploadPhotoViewController.swift
//  Gatekeyper
//
//  Created by Muhammad Alvi on 13/01/2020.
//  Copyright © 2020 Qirtas. All rights reserved.
//

import UIKit

class UploadPhotoViewController: UIViewController {
    @IBOutlet weak var descriptionTV: UITextView!
    
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var imageSelectedView: UIView!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var questionNumberLbl: UILabel!
    @IBOutlet weak var equipmentIdLbl: UILabel!
    @IBOutlet weak var enterOrExitLbl: UILabel!
    var question: [String: Any]?
    var questions: [[String: Any]]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.populateData()
        // Do any additional setup after loading the view.
    }
    
    func populateData(){
        self.questionLbl.text = self.question!["text"] as! String
    }
    
    @IBAction func cancel(_ sender: Any) {
    }
    
   
    @IBAction func takePhoto(_ sender: Any) {
    }
    
    @IBAction func uploadFromGallery(_ sender: Any) {
    }
    @IBAction func proceed(_ sender: Any) {
        let q = Utils.getNextQuestion(id: self.question!["id"] as! String)
        if(q == nil){
            return
        }
        if(q!["type"] as! String == "Text"){
            performSegue(withIdentifier: "goToOpenFromTakePhoto", sender: nil)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToOpenFromTakePhoto" {
                   if let destinationVC = segue.destination as? OpenQuestionViewController {
                       destinationVC.question = Utils.getNextQuestion(id: self.question!["id"] as! String)
                       destinationVC.questions = SampleJson.data["questions"] as! [[String: Any]]
                   }
               }
    }
}

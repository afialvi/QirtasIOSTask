//
//  QuestionsViewController.swift
//  Gatekeyper
//
//  Created by Muhammad Alvi on 15/01/2020.
//  Copyright © 2020 Qirtas. All rights reserved.
//

import UIKit


protocol NextQuestion {
    func showNextQuestion()
}
protocol TakePhotoController {
    func takePhotoFromCamera()
    func uploadFromGallery()
}
enum ImageSource {
    case photoLibrary
    case camera
}
class QuestionsViewController: UIViewController, NextQuestion, TakePhotoController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    @IBOutlet weak var questionsProgressView: UIView!
    
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var bottomViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var questionCountLbl: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    let questions = SampleJson.data["questions"] as! [[String: Any]]
    var currQuestionNumber = -1
    var takePhotoView: TakePhotoView?
    var imagePicker: UIImagePickerController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.questionsProgressView.layer.cornerRadius = 10.0
        self.questionsProgressView.clipsToBounds = true
        self.showNextQuestion()
        shadowView.layer.cornerRadius = 15
               shadowView.layer.shadowColor = UIColor.gray.cgColor
               shadowView.layer.shadowOffset = CGSize.zero
               shadowView.layer.shadowOpacity = 0.5
               shadowView.layer.shadowRadius = 7.0
               shadowView.layer.masksToBounds =  false
        self.addSeparatorsInQuestionView()
        
    }
    

    func showNextQuestion(){
        if(currQuestionNumber >= (questions.count - 1) ){
//            self.dismiss(animated: true, completion: nil)
            performSegue(withIdentifier: "showResultMessage", sender: nil)
            return
        }
        
        
        currQuestionNumber = currQuestionNumber + 1
        self.fillProgress(i: currQuestionNumber + 1)
        self.questionCountLbl.text = "Question: \(currQuestionNumber + 1)/\(questions.count)"
        let question = questions[currQuestionNumber] as! [String: Any]
        let type = question["type"] as! String
        self.questionLbl.text = question["text"] as! String
        self.removeBottomViewSubviews()
        switch type{
        case "MCQ":
            let options = question["options"] as! [[String: Any]]
            if(options.count == 2){
                self.load2OptionsView(question: question)
            }
            else if(options.count == 3){
                self.load3OptionsView(question: question)
            }
            break
        case "Text":
            self.loadOpenEndedView(question: question)
            break
        case "MCQ-Image":
            self.load3ImageOptionsView(question: question)
            break
        case "ImageAnswer":
            self.loadTakePhotoView(question: question)
            break
        default:
            break
        }
    }
    
    func removeBottomViewSubviews(){
        for sv in self.bottomView.subviews{
            sv.removeFromSuperview()
        }
        
//        print("Bottom View Frame: \(self.bottomView.frame)")
    }
    
    func load2OptionsView(question: [String: Any]){
        self.bottomViewHeightConstraint.constant = 104
        self.bottomView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.bottomViewHeightConstraint.constant)
//        print("Bottom View Frame2: \(self.bottomView.frame)")
        let twoOptionsView = Bundle.main.loadNibNamed("TwoOptionsView", owner: self, options: nil)![0] as! TwoOptionsView
        
        twoOptionsView.delegate = self
        
        let options = question["options"] as! [[String: Any]]
        twoOptionsView.option1Lbl.text = options[0]["title"] as! String
        twoOptionsView.option2Lbl.text = options[1]["title"] as! String
        
        twoOptionsView.frame = CGRect(x: 0, y: 0, width: self.bottomView.bounds.width, height: self.bottomViewHeightConstraint.constant)
        self.bottomView.addSubview(twoOptionsView)
        
    }
    
    func load3OptionsView(question: [String: Any]){
        self.bottomViewHeightConstraint.constant = 156
        self.bottomView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.bottomViewHeightConstraint.constant)
//        print("Bottom View Frame2: \(self.bottomView.frame)")
        let threeoptionsView = Bundle.main.loadNibNamed("ThreeOptionsView", owner: self, options: nil)![0] as! ThreeoptionsView
        threeoptionsView.delegate = self
        let options = question["options"] as! [[String: Any]]
        threeoptionsView.option1Lbl.text = options[0]["title"] as! String
        threeoptionsView.option2Lbl.text = options[1]["title"] as! String
        threeoptionsView.option3Lbl.text = options[2]["title"] as! String
        threeoptionsView.frame = CGRect(x: 0, y: 0, width: self.bottomView.bounds.width, height: self.bottomViewHeightConstraint.constant)
        self.bottomView.addSubview(threeoptionsView)
    }
    
    func load3ImageOptionsView(question: [String: Any]){
        self.bottomViewHeightConstraint.constant = 156
        self.bottomView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.bottomViewHeightConstraint.constant)
//        print("Bottom View Frame2: \(self.bottomView.frame)")
        let threeImageOptions = Bundle.main.loadNibNamed("ThreeImageOptions", owner: self, options: nil)![0] as! ThreeImageOptions
        threeImageOptions.delegate = self
        let options = question["options"] as! [[String: Any]]
        threeImageOptions.option1Lbl.text = "A"
        threeImageOptions.option2Lbl.text = "B"
        threeImageOptions.option3Lbl.text = "C"
        let url1 = URL(string: options[0]["url"] as! String)
        threeImageOptions.option1ImgV.sd_setImage(with: url1, completed: nil)
        let url2 = URL(string: options[1]["url"] as! String)
        threeImageOptions.option2ImgV.sd_setImage(with: url2, completed: nil)
        let url3 = URL(string: options[2]["url"] as! String)
        threeImageOptions.option3ImgV.sd_setImage(with: url3, completed: nil)
        
        
        threeImageOptions.frame = CGRect(x: 0, y: 0, width: self.bottomView.bounds.width, height: self.bottomViewHeightConstraint.constant)
        self.bottomView.addSubview(threeImageOptions)
        
    }
    
    func loadTakePhotoView(question: [String: Any]){
        self.bottomViewHeightConstraint.constant = 220
        self.bottomView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.bottomViewHeightConstraint.constant)
//        print("Bottom View Frame2: \(self.bottomView.frame)")
        let takePhotoView = Bundle.main.loadNibNamed("TakePhotoView", owner: self, options: nil)![0] as! TakePhotoView
        takePhotoView.delegate = self
        takePhotoView.frame = CGRect(x: 0, y: 0, width: self.bottomView.bounds.width, height: self.bottomViewHeightConstraint.constant)
        takePhotoView.proceedBtn.layer.cornerRadius = 5.0
        takePhotoView.proceedBtn.clipsToBounds = true
        takePhotoView.takePhotoDelegate = self
        self.takePhotoView = takePhotoView
        self.bottomView.addSubview(takePhotoView)
    }
    
    func loadOpenEndedView(question: [String: Any]){
        self.bottomViewHeightConstraint.constant = 52
        self.bottomView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.bottomViewHeightConstraint.constant)
//        print("Bottom View Frame2: \(self.bottomView.frame)")
        let openEndedView = Bundle.main.loadNibNamed("OpenEndedView", owner: self, options: nil)![0] as! OpenEndedView
        openEndedView.delegate = self
        openEndedView.frame = CGRect(x: 0, y: 0, width: self.bottomView.bounds.width, height: self.bottomViewHeightConstraint.constant)
        openEndedView.proceedBtn.layer.cornerRadius = 5.0
        openEndedView.proceedBtn.clipsToBounds = true
        self.bottomView.addSubview(openEndedView)
    }
    
    
    @IBAction func cancel(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func addSeparatorsInQuestionView(){
        let width = self.questionsProgressView.bounds.width
        let separatorInitialX = width/CGFloat(self.questions.count)
        for i in 1 ... self.questions.count - 1{
            let x =  Int(separatorInitialX) * Int(i)
            let v = UIView(frame: CGRect(x:CGFloat(x), y: 0, width: 1.0, height: self.questionsProgressView.bounds.height))
            v.backgroundColor = UIColor.white
            self.questionsProgressView.addSubview(v)
        }
    }
    
    func fillProgress(i : Int){
        let width = self.questionsProgressView.bounds.width
        let separatorInitialX = width/CGFloat(self.questions.count)
        print("Separator Value : \(separatorInitialX)")
        let x1 = CGFloat(Int(CGFloat(i-1) * CGFloat(separatorInitialX)))
        let x2 = CGFloat(Int(CGFloat(i) * CGFloat(separatorInitialX)))
        let v = UIView(frame: CGRect(x:  x1 + 1, y: 0, width: x2 - x1 - 1, height: self.questionsProgressView.bounds.height))
        v.backgroundColor = UIColor(displayP3Red: 2.0/255.0, green: 171.0/255.0, blue: 231.0/255.0, alpha: 1.0)
        self.questionsProgressView.addSubview(v)
    }
    
    
    func takePhotoFromCamera(){
        selectImageFrom(.camera)
        
    }
    func uploadFromGallery(){
//        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            selectImageFrom(.photoLibrary)
      
        
    }
    
    func selectImageFrom(_ source: ImageSource){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        let image = selectedImage
        self.takePhotoView?.showUploadedImage(image: image)
    }
    
    
}

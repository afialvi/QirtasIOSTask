//
//  TakePhotoView.swift
//  Gatekeyper
//
//  Created by Muhammad Alvi on 15/01/2020.
//  Copyright © 2020 Qirtas. All rights reserved.
//

import UIKit

class TakePhotoView: UIView {

    @IBOutlet weak var photoTakeView: UIView!
    @IBOutlet weak var photoImage: UIImageView!
    var delegate: NextQuestion?
    var takePhotoDelegate: TakePhotoController?
    
    @IBOutlet weak var proceedBtn: UIButton!
    @IBAction func proceed(_ sender: Any) {
         self.delegate?.showNextQuestion()
    }
     
    @IBAction func takePhoto(_ sender: Any) {
        self.takePhotoDelegate?.takePhotoFromCamera()
    }
    @IBAction func uploadFromGallery(_ sender: Any) {
        self.takePhotoDelegate?.uploadFromGallery()
    }
    
    func showUploadedImage(image:UIImage){
        self.photoTakeView.isHidden = false
        self.photoImage.image = image
    }
    @IBAction func discardImage(_ sender: Any) {
        self.photoTakeView.isHidden = true
        self.photoImage.image = nil
    }

}

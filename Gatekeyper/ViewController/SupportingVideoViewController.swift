//
//  SupportingVideoViewController.swift
//  Gatekeyper
//
//  Created by Muhammad Alvi on 12/01/2020.
//  Copyright © 2020 Qirtas. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit
import Alamofire
import CoreData


class SupportingVideoViewController: UIViewController {
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var fileView: UIView!
    @IBOutlet weak var proceedBtn: UIButton!
    @IBOutlet weak var videoFileTitleLbl: UILabel!
    @IBOutlet weak var viewTitleLbl: UILabel!
    @IBOutlet weak var videoThumbnail: UIImageView!
    
    @IBOutlet weak var equipmentCodeLbl: UILabel!
    @IBOutlet weak var supportingMaterialDescriptionLbl: UILabel!
    
    @IBOutlet weak var filenameLbl: UILabel!
    var ques: [String: Any]?
    var videoUrlStr: String?
    var videoTitle: String?
    let coreDataHelper = CoreDataHelper()
    var pdfTitle: String?
    var pdfPath: String?
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.coreDataHelper.deleteAllPaths()
        self.loadData()
        shadowView.layer.cornerRadius = 15
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowRadius = 7.0
        shadowView.layer.masksToBounds =  false
        self.fileView.layer.cornerRadius = 8.0
        self.fileView.clipsToBounds = true
        self.proceedBtn.layer.cornerRadius = 5.0
        self.proceedBtn.clipsToBounds = true
        
    }
    
    func loadData(){
        let supportingMaterial = SampleJson.data["supportingMaterial"] as! [[String: Any]]
        for material in supportingMaterial{
            if (material["type"] as! String == "video"){
                let thumnailStr = material["thumbnail"] as! String
                if thumnailStr.count <= 0{
                    continue
                }
                self.videoUrlStr = material["url"] as! String
                self.videoTitle = material["title"] as! String
                let url = URL(string: thumnailStr)
                self.videoThumbnail.sd_setImage(with: url) { (image, error, SDImageCacheType, u) in
                    
                }
            }
            else if (material["type"] as! String == "pdf"){
                self.pdfTitle = material["title"] as! String
                self.filenameLbl.text = material["title"] as! String
                self.downloadFileFromUrl(title: material["title"] as! String, urlStr: material["url"] as! String)
            }
            
        }
        
    }
    
    

    @IBAction func cancel(_ sender: Any) {
    }
    
    @IBAction func download(_ sender: Any) {
        
    }
    @IBAction func proceed(_ sender: Any) {
        performSegue(withIdentifier: "showQuestionsVC", sender: nil)
    }
    
    
    @IBAction func playVideo(_ sender: Any) {
        let videoPathObj = self.coreDataHelper.getVideoUrl(title: self.videoTitle!)
        if(videoPathObj == nil){
            print("Video Path Object is nil")
        }
        let path = videoPathObj?.value(forKey: "path") as! String
        
        
        let splittedPath = path.split(separator: "/")
                   let fn = splittedPath[splittedPath.count - 1]
                   let documentsUrl = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask).first!
                   let fnStr = String(fn)
                   let urlWithFile = documentsUrl.appendingPathComponent(fnStr)
        
        
//        let url = URL(string: urlWithFile)
        let player = AVPlayer(url: urlWithFile)

        let vc = AVPlayerViewController()
        vc.player = player

        self.present(vc, animated: true) { vc.player?.play() }
    }
    
    @IBAction func downloadFile(_ sender: Any) {
        
       let pathObjects = self.coreDataHelper.getPaths()
        if(pathObjects == nil){
            return
        }
        for po in pathObjects!{
            let ttl = po.value(forKey: "title")
            let ttlStr = ttl == nil ? "" : ttl as! String
            if(ttlStr == self.pdfTitle!){
                let filePath = po.value(forKey: "path") as! String
                self.pdfPath = filePath
                performSegue(withIdentifier: "openPDF", sender: nil)
                return
            }
        }
    }
    
    
    func downloadFileFromUrl(title: String, urlStr: String){
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)

        Alamofire.download(
            urlStr,
            method: .get,
            parameters: nil,
            encoding: JSONEncoding.default,
            headers: nil,
            to: destination).downloadProgress(closure: { (progress) in
                //progress closure
            }).response(completionHandler: { (DefaultDownloadResponse) in
                let storagePath = DefaultDownloadResponse.destinationURL!.absoluteString
                self.coreDataHelper.savePath(title: title, pathOfFile: storagePath)
                print("Storage Path: \(storagePath)")
                
            })
    }
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "openPDF" {
              if let destinationVC = segue.destination as? PDFViewController {
                destinationVC.path = self.pdfPath
                destinationVC.titleStr = self.pdfTitle
              }
          }
      }
    
    
}

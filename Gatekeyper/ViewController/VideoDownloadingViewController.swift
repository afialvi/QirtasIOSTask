//
//  VideoDownloadingViewController.swift
//  Gatekeyper
//
//  Created by Muhammad Alvi on 19/01/2020.
//  Copyright © 2020 Qirtas. All rights reserved.
//

import UIKit
import Alamofire

class VideoDownloadingViewController: UIViewController {
    @IBOutlet weak var progressPercentageLbl: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    let coreDataHelper = CoreDataHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.coreDataHelper.deleteAllPaths()
        self.loadData()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        performSegue(withIdentifier: "goToSupportingMaterialVC", sender: nil)
    }
    func loadData(){
        let supportingMaterial = SampleJson.data["supportingMaterial"] as! [[String: Any]]
        for material in supportingMaterial{
            if (material["type"] as! String == "video"){
                let thumnailStr = material["thumbnail"] as! String
                if thumnailStr.count <= 0{
                    continue
                }
                let videoUrl = material["url"] as! String
                let title = material["title"] as! String
                self.downloadFileFromUrl(title: title, urlStr: videoUrl)
                break
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
                if #available(iOS 11.0, *) {
                    let count = progress.fractionCompleted
                    print("Count: \(count)")
                    self.progressView.progress = Float(count)
                    self.progressPercentageLbl.text = "Downloading Video: \(String(format: " %.2f", count * 100.0)) %"
                } else {
                    // Fallback on earlier versions
                }
            }).response(completionHandler: { (DefaultDownloadResponse) in
                let storagePath = DefaultDownloadResponse.destinationURL!.absoluteString
                self.coreDataHelper.savePath(title: title, pathOfFile: storagePath)
                print("Storage Path: \(storagePath)")
                self.performSegue(withIdentifier: "goToSupportingMaterialVC", sender: nil)
            })
    }
}

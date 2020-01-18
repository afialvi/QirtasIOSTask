//
//  PDFViewController.swift
//  Gatekeyper
//
//  Created by Muhammad Alvi on 17/01/2020.
//  Copyright © 2020 Qirtas. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    var path: String?
    var titleStr: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            let pdfView = PDFView(frame: self.view.bounds)
            self.view.addSubview(pdfView)

                          // Fit content in PDFView.
            pdfView.autoScales = true

                          // Load Sample.pdf file.
            
            let splittedPath = self.path!.split(separator: "/")
            let fn = splittedPath[splittedPath.count - 1]
            let documentsUrl = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask).first!
            let fnStr = String(fn)
            let urlWithFile = documentsUrl.appendingPathComponent(fnStr)
//            let fileURL = Bundle.main.url(forResource: self.titleStr, withExtension: "pdf")//URL(fileURLWithPath: path!)
            pdfView.document = PDFDocument(url: urlWithFile)
//            pdfView.backgroundColor = UIColor.green
        } else {
            // Fallback on earlier versions
        }
              
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

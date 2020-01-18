//
//  Utils.swift
//  Gatekeyper
//
//  Created by Qirtas on 27/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import UIKit
import RYFloatingInput


class Utils: NSObject {
    static func getFloatingTextFieldForView(v: UIView, placeholder: String) -> RYFloatingInput{
        let tf1 = RYFloatingInput(frame: CGRect(x: 0, y: 20, width: v.bounds.width, height: 30))
        tf1.setup(setting: RYFloatingInputSetting.Builder.instance()
        .backgroundColor(.clear)
        .textColor(.darkText)
        .placeholderColor(.lightGray)
        .dividerColor(UIColor(displayP3Red: 2.0/255.0, green: 171.0/255.0, blue: 231.0/255.0, alpha: 1.0))
        .cursorColor(.black)
        .accentColor(UIColor(displayP3Red: 2.0/255.0, green: 171.0/255.0, blue: 231.0/255.0, alpha: 1.0))
            .maxLength(10, onViolated: (message: "Limit exceeded", callback: {
                print("Limit exceeded")
            }))
            .inputType(.number, onViolated: (message: "Invalid input, number only", callback: {
                   print("Invalid input, number only")
               }))
        .warningColor(.red)
            .placeholer(placeholder)
            
        .build())
        
        
        return tf1
    }
    
    
    static func getNextQuestion(id: String) -> [String: Any]?{
        let questions = SampleJson.data["questions"] as! [[String: Any]]
        for i in 0...questions.count - 1{
            if(questions[i]["id"] as! String == id){
                if(i < questions.count - 1){
                    return questions[i+1]
                }
            }
        }
        return nil
    }
    
}

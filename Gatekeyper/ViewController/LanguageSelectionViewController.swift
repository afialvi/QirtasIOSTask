//
//  LanguageSelectionViewController.swift
//  Gatekeyper
//
//  Created by Qirtas on 09/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import UIKit

class LanguageSelectionViewController: UIViewController {

    
    @IBOutlet weak var mainShadowView: UIView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var languagesMainView: UIView!
    
    @IBOutlet weak var english_view: UIView!
    @IBOutlet weak var french_view: UIView!
    @IBOutlet weak var spanish_view: UIView!
    
    
     let userDefaults = UserDefaults.standard;
    
    override func viewDidLayoutSubviews() {
        self.topBarView.addHorizontalGradient()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
                       
//        languagesMainView.layer.cornerRadius = 15
//        languagesMainView.layer.shadowColor = UIColor.gray.cgColor
//        languagesMainView.layer.shadowOffset = CGSize.zero
//        languagesMainView.layer.shadowOpacity = 0.5
//        languagesMainView.layer.shadowRadius = 7.0
//        languagesMainView.layer.masksToBounds =  false
        
        languagesMainView.layer.cornerRadius = 15
        languagesMainView.clipsToBounds = true
        
        mainShadowView.layer.cornerRadius = 15
       mainShadowView.layer.shadowColor = UIColor.gray.cgColor
       mainShadowView.layer.shadowOffset = CGSize.zero
       mainShadowView.layer.shadowOpacity = 0.5
       mainShadowView.layer.shadowRadius = 7.0
       mainShadowView.layer.masksToBounds =  false
        
        english_view.layer.cornerRadius = 4
        english_view.layer.shadowColor = UIColor.gray.cgColor
        english_view.layer.shadowOffset = CGSize.zero
        english_view.layer.shadowOpacity = 0.5
        english_view.layer.shadowRadius = 4.0
        english_view.layer.masksToBounds =  false
        
        spanish_view.layer.cornerRadius = 4
        spanish_view.layer.shadowColor = UIColor.gray.cgColor
        spanish_view.layer.shadowOffset = CGSize.zero
        spanish_view.layer.shadowOpacity = 0.5
        spanish_view.layer.shadowRadius = 4.0
        spanish_view.layer.masksToBounds =  false
        
        french_view.layer.cornerRadius = 4
        french_view.layer.shadowColor = UIColor.gray.cgColor
        french_view.layer.shadowOffset = CGSize.zero
        french_view.layer.shadowOpacity = 0.5
        french_view.layer.shadowRadius = 4.0
        french_view.layer.masksToBounds =  false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.userDefaults.setValue(false, forKey: Constants.isFromInitial)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func englishButtonClicked(_ sender: Any) {
        
        self.userDefaults.setValue(true , forKey: Constants.isLanguageSet)
        performSegue(withIdentifier: "showLoginScreen", sender: nil)
    }
}

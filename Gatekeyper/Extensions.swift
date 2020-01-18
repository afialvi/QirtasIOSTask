//
//  Extensions.swift
//  Gatekeyper
//
//  Created by Qirtas on 09/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(radius: CGFloat) {
        
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func roundedTopCorners(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
            byRoundingCorners: [.topLeft , .topRight],
            cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    
    func roundedBottomCorners(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
            byRoundingCorners: [.bottomLeft , .bottomRight],
            cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func addVerticalGradient(){
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        
        let colorTop = UIColor(red: 2 / 255.0, green: 171 / 255.0, blue: 231 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 76 / 255.0, green: 181 / 255.0, blue: 171 / 255.0, alpha: 1.0).cgColor
        
        gradientLayer.colors = [colorTop,    colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        
        //
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    

    func addHorizontalGradient()
    {
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        
        let colorTop = UIColor(red: 2 / 255.0, green: 171 / 255.0, blue: 231 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 76 / 255.0, green: 181 / 255.0, blue: 171 / 255.0, alpha: 1.0).cgColor
        
        gradientLayer.colors = [colorTop,    colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

      //  gradientLayer.locations = [gradTopStart, gradTopEnd, gradBottomStart, gradBottomEnd]
        gradientLayer.frame = self.bounds
        
        //
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func applyBGGradient(rect: CGRect) {
        var gl:CAGradientLayer!
        let colorTop = UIColor(red: 105.0 / 255.0, green: 121.0 / 255.0, blue: 186.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 146.0 / 255.0, green: 153.0 / 255.0, blue: 194.0 / 255.0, alpha: 1.0).cgColor
        
        gl = CAGradientLayer()
        gl.colors = [colorTop, colorBottom]
        gl.locations = [0.0, 1.0]
        gl.frame = rect
        self.layer.sublayers?.removeAll();
        self.layer.addSublayer(gl)
    }
    
    func applyBGGradientWithTopColorOnly(rect: CGRect) {
        var gl:CAGradientLayer!
        let colorTop = UIColor(red: 105.0 / 255.0, green: 121.0 / 255.0, blue: 186.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom =  UIColor(red: 105.0 / 255.0, green: 121.0 / 255.0, blue: 186.0 / 255.0, alpha: 1.0).cgColor
        
        gl = CAGradientLayer()
        gl.colors = [colorTop, colorBottom]
        gl.locations = [0.0, 1.0]
        gl.frame = rect
        self.layer.sublayers?.removeAll();
        self.layer.addSublayer(gl)
    }
}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}

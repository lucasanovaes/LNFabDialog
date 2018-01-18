//
//  UIViewExtension.swift
//  Pods
//
//  Created by iCasei Site on 17/01/2018.
//
//

import UIKit

extension UIView{
    
    /// Fade in a view with a duration
    ///
    /// Parameter duration: custom animation duration
    func fadeInWith(_ duration: TimeInterval = 0.3, completion: @escaping () -> ()) {
        self.alpha = 0
        
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        }) { (control) in
            completion()
        }
    }
    
    /// Fade out a view with a duration
    ///
    /// - Parameter duration: custom animation duration
    func fadeOutWith(_ duration: TimeInterval = 0.3, completion: @escaping () -> ()) {
        self.alpha = 1
        
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        }) { (control) in
            completion()
        }
    }
    
}

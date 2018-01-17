//
//  File.swift
//  Pods
//
//  Created by iCasei Site on 17/01/2018.
//
//

import Foundation

@objc public protocol LNFabDialogButtonDelegate: class{
    
    /**
     User tapped on a FAB
     - parameter fab: The selected FAB.
     */
    @objc func buttonTouchesBegan(_ fab: LNFabDialogButton)
    @objc func buttonTouchesEnded(_ fab: LNFabDialogButton)
    
    /**
     Indicates that the user tapped on a FAB and the alert is instanced.
     - parameter fab: the selected FAB.
     - parameter alert: the selected LNFabAlertView
     */
    @objc func alertWillOpen(_ fab: LNFabDialogButton)
    @objc func alertDidOpen(_ fab: LNFabDialogButton)
    @objc func alertWillClose(_ fab: LNFabDialogButton)
    @objc func alertDidClose(_ fab: LNFabDialogButton)
    
}

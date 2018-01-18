//
//  File.swift
//  Pods
//
//  Created by iCasei Site on 17/01/2018.
//
//

import Foundation

@objc public protocol LNFabDialogButtonDelegate{
    
    /**
     User tapped on a FAB
     - parameter fab: The selected FAB.
     */
    @objc optional func buttonTouchesBegan(_ fab: LNFabDialogButton)
    @objc optional func buttonTouchesEnded(_ fab: LNFabDialogButton)
    
    /**
     Indicates that the user tapped on a FAB and the alert is instanced.
     - parameter fab: the selected FAB.
     - parameter alert: the selected LNFabAlertView
     */
    @objc optional func alertWillOpen(_ fab: LNFabDialogButton)
    @objc optional func alertDidOpen(_ fab: LNFabDialogButton)
    @objc optional func alertWillClose(_ fab: LNFabDialogButton)
    @objc optional func alertDidClose(_ fab: LNFabDialogButton)
    
    @objc optional func didSelect(_ tableView: UITableView, at indexPath: IndexPath)
    
}

//
//  LNFabDialog.swift
//  LNFabDialog

//  Created by Lucas Novaes Site on 15/01/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import UIKit
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


@IBDesignable
open class LNFabDialogButton: UIView {
    
    weak var delegate: LNFabDialogButtonDelegate?
    
    /** Button size */
    open var size: CGFloat = 56 {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    /** Button icon */
    @IBInspectable open var buttonImage: UIImage? = nil{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable open var buttonColor: UIColor = UIColor.red
    @IBInspectable open var buttonIconColor: UIColor = UIColor.white

    fileprivate var buttonImageView: UIImageView = UIImageView()
    
    // Button shape layer
    fileprivate var circleLayer: CAShapeLayer = CAShapeLayer()
    
    fileprivate var lnFabAlertView: LNFabAlertView = LNFabAlertView()
    
    fileprivate var alertIsOpen = false
    
    
    /** LNFabItemTableViewCell Layout */
    open var lnFabItemLayout = LNFabItemLayout(font: UIFont(), textColor: UIColor.black.withAlphaComponent(0.87))
    
    
    // MARK: Initializers
    
    /** Default init */
    public init(){
        super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
        backgroundColor = UIColor.clear
        layer.cornerRadius = size / 2
    }
    
    /** Initialization with custom size */
    public init(size: CGFloat){
        super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
        backgroundColor = UIColor.clear
        layer.cornerRadius = size / 2
    }

    /** Initialization with custom frame */
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        layer.cornerRadius = size / 2
    }
    
    /** Initialize from storyboard. */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        size = min(frame.size.width, frame.size.height)
        backgroundColor = UIColor.clear

        clipsToBounds = false
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setButtonLayer()
        setButtonImage()
        setButtonShadow()
    }
    
    // MARK: Prepare Methods
    fileprivate func setButtonImage(){
        buttonImageView.removeFromSuperview()
        buttonImageView = UIImageView(image: buttonImage)
        buttonImageView.tintColor = buttonIconColor
        buttonImageView.frame = CGRect(
            x: (size / 2 - buttonImageView.frame.size.width / 2),
            y: (size / 2 - buttonImageView.frame.size.height / 2),
            width: buttonImageView.frame.size.width,
            height: buttonImageView.frame.size.height
        )
        
        addSubview(buttonImageView)
        bringSubview(toFront: buttonImageView)
    }
    
    fileprivate func setButtonLayer() {
        circleLayer.removeFromSuperlayer()
        circleLayer.frame = CGRect(x: 0, y: 0, width: size, height: size)
        circleLayer.backgroundColor = buttonColor.cgColor
        circleLayer.cornerRadius = size / 2
        layer.addSublayer(circleLayer)
    }
    
    fileprivate func setButtonShadow() {
        circleLayer.shadowOffset = CGSize(width: 1, height: 3)
        circleLayer.shadowRadius = 2
        circleLayer.shadowColor = UIColor.black.cgColor
        circleLayer.shadowOpacity = 0.4
    }
    
    fileprivate func setAlertView(onComplete: () -> ()){
        lnFabAlertView.removeFromSuperview()
        
        if alertIsOpen{
            delegate?.alertWillClose(self)
            
            
            
            
        }else{
            delegate?.alertWillOpen(self)
            
            lnFabAlertView = LNFabAlertView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            lnFabAlertView.backgroundColor = UIColor.blue
            
            superview?.addSubview(lnFabAlertView)
        }
    }
    
    // MARK: LNFabDialogButtonDelegate
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.buttonTouchesBegan(self)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setAlertView {
            alertIsOpen = !alertIsOpen
            delegate?.buttonTouchesEnded(self)
        }
    }

    
}


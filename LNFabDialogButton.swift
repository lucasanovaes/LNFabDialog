//
//  LNFabDialog.swift
//  LNFabDialog

//  Created by Lucas Novaes Site on 15/01/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import UIKit
import Foundation

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

    fileprivate var overlayView : UIControl = UIControl()
    
    @IBInspectable open var overlayColor: UIColor = UIColor.black.withAlphaComponent(0.5)

    fileprivate var lnFabAlertView: LNFabAlertView!
    
    fileprivate var alertIsOpen = false{
        didSet{
            self.isHidden = alertIsOpen
            self.lnFabAlertView.isHidden = !alertIsOpen
        }
    }

    
    // MARK: Initializers
    
    /** Default init */
    public init(){
        super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
        backgroundColor = UIColor.clear
    }
    
    /** Initialization with custom size */
    public init(size: CGFloat){
        super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
        backgroundColor = UIColor.clear
    }

    /** Initialization with custom frame */
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
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
    
    open func setup(model: [LNFabItemModel], delegate: LNFabDialogButtonDelegate? = nil){
        self.lnFabAlertView = LNFabAlertView(delegate: self, models: model)
        self.delegate = delegate
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
    
    fileprivate func showOverlayView() {
        if let superview = superview {
            overlayView.frame = CGRect(x: 0,y: 0, width: superview.bounds.width, height: superview.bounds.height)
        }
        
        overlayView.backgroundColor = overlayColor
        overlayView.isUserInteractionEnabled = true
        
        self.superview?.addSubview(self.overlayView)
        
        self.alertIsOpen = !self.alertIsOpen
        self.overlayView.fadeInWith {
            self.delegate?.alertDidOpen?(self)
        }
        
        overlayView.addTarget(self, action: #selector(closeOverlayView), for: .touchUpInside)
    }
    
    fileprivate dynamic func closeOverlayView(){
        self.overlayView.fadeOutWith {
            self.alertIsOpen = !self.alertIsOpen

            self.overlayView.removeFromSuperview()

            self.delegate?.alertDidClose?(self)
        }
    }
    
    fileprivate func showAlertView(){
    
        delegate?.alertWillOpen?(self)
        
        showOverlayView()
        
        superview?.addSubview(lnFabAlertView)
        superview?.bringSubview(toFront: lnFabAlertView)
    }
    
    fileprivate func closeAlertView(){
        delegate?.alertWillClose?(self)
        
        closeOverlayView()
        // remover alerta
    }
    
    // MARK: LNFabDialogButtonDelegate
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.buttonTouchesBegan?(self)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.buttonTouchesEnded?(self)

        showAlertView()
    }

    
}


// MARK: LNFabAlertViewDelegate
extension LNFabDialogButton: LNFabAlertViewDelegate{
    
    func didSelectRow(_ tableView: UITableView, at indexPath: IndexPath) {
        delegate?.didSelect?(tableView, at: indexPath)
    }
    
}

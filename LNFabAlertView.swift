//
//  LNFabItemAlertView.swift
//  LNFabDialog
//
//  Created by iCasei Site on 15/01/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import UIKit

protocol LNFabAlertViewDelegate: class{
    func didSelectRow(_ tableView: UITableView, at indexPath: IndexPath)
}

class LNFabAlertView: UIView{
    
    fileprivate var tableView = UITableView()
    
    weak var delegate: LNFabAlertViewDelegate?

    var models: [LNFabItemModel]
    
    var alertLayer = CAShapeLayer()
    
    fileprivate let tableViewCellIdentifier = "LNFabItem"
    
    init(delegate: LNFabAlertViewDelegate, models: [LNFabItemModel]) {
        self.delegate = delegate
        self.models = models
        
        super.init(frame: LNFabAlertView.alertFrame(models: models))

        setTableView()
        setAlertShadowLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setTableView(){
        tableView = UITableView(frame: self.bounds)
        addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.layer.masksToBounds = true
        tableView.register(UINib(nibName: "LNFabItemTableViewCell", bundle: Bundle(for: LNFabItemTableViewCell.self)), forCellReuseIdentifier: tableViewCellIdentifier)
        tableView.reloadData()
    }
    
    // Issue #1 - Implement dynamic LNFabAlertView item (UITableViewCell) size.
    private static func alertFrame(models: [LNFabItemModel]) -> CGRect{
        let screenSize = UIScreen.main.bounds
        
        let maxAlertWidth: CGFloat = 336
        let sideSpace: CGFloat = 20
        
        let alertWidth = screenSize.width - CGFloat(sideSpace * 2) // Calculating alert width base on side spaces and screen width
        let finalAlertWidth = alertWidth > maxAlertWidth ? maxAlertWidth : alertWidth
        
        let alertHeight: CGFloat = CGFloat(models.count * 56)
        
        return CGRect(x: (screenSize.width / 2) - finalAlertWidth / 2, y: (screenSize.height / 2) - alertHeight, width: finalAlertWidth, height: alertHeight)
    }
    
    fileprivate func setAlertShadowLayer() {
        alertLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        alertLayer.backgroundColor = UIColor.white.cgColor
        alertLayer.cornerRadius = 2
        layer.addSublayer(alertLayer)
        bringSubview(toFront: tableView)
        
        alertLayer.shadowOffset = CGSize(width: 1, height: 10)
        alertLayer.shadowRadius = 8
        alertLayer.shadowColor = UIColor.black.cgColor
        alertLayer.shadowOpacity = 0.4
        
    }
    
}

// MARK: TableView Delegate & DataSource
extension LNFabAlertView: UITableViewDelegate, UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier) as! LNFabItemTableViewCell
        cell.fill(model: models[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRow(tableView, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
}


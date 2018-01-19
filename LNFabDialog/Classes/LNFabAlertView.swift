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

internal class LNFabAlertView: UIView{
    
    fileprivate var tableView = UITableView()
    fileprivate var tableViewHeader = UIView()
    fileprivate var tableViewFooter = UIView()
    
    weak var delegate: LNFabAlertViewDelegate?

    var model: LNFabItemModel
    
    var alertLayer = CAShapeLayer()
    
    fileprivate let tableViewCellIdentifier = "LNFabItem"
    
    init(delegate: LNFabAlertViewDelegate, model: LNFabItemModel) {
        self.delegate = delegate
        self.model = model
    
        super.init(frame: LNFabAlertView.alertFrame(model: model))

        // Refatorar o model para um unico objeto com uma propriedade [LNFabItemModel] que tem como um dos parametros o TITLE do alert
        
        setTableViewHeader(title: model.sectionTitle, font: model.sectionFont)
        setTableView()
        setAlertShadowLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setTableView(){
        tableView = UITableView(frame: self.bounds, style: .grouped)
        addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "LNFabItemTableViewCell", bundle: Bundle(for: LNFabItemTableViewCell.self)), forCellReuseIdentifier: tableViewCellIdentifier)
        tableView.reloadData()
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
    
    private func setTableViewHeader(title: String, font: UIFont?){
        tableViewHeader = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
        
        let supportText = UILabel(frame: CGRect(x: 24, y: 24, width: UIScreen.main.bounds.width - 48, height: 24))
        supportText.text = title
        supportText.font = font
        tableViewHeader.addSubview(supportText)
    }
    
    // Issue #1 - Implement dynamic LNFabAlertView item (UITableViewCell) size.
    private static func alertFrame(model: LNFabItemModel) -> CGRect{
        let screenSize = UIScreen.main.bounds
        
        let maxAlertWidth: CGFloat = 336
        let sideSpace: CGFloat = 20
        
        let alertWidth = screenSize.width - CGFloat(sideSpace * 2) // Calculating alert width base on side spaces and screen width
        let finalAlertWidth = alertWidth > maxAlertWidth ? maxAlertWidth : alertWidth
        
        let alertFinalHeight = LNFabAlertView.alertHeight(model: model)
        
        return CGRect(x: (screenSize.width / 2) - finalAlertWidth / 2, y: (screenSize.height / 2) - (alertFinalHeight / 2), width: finalAlertWidth, height: alertFinalHeight)
    }
    
    private static func alertHeight(model: LNFabItemModel) -> CGFloat{
        let itemSize: CGFloat = 56.0
        
        let maxNumberOfItensInAlert: CGFloat = 5
        
        let alertInitialHeight = CGFloat(model.itens.count * Int(itemSize)) + 68
        
        if alertInitialHeight > itemSize * maxNumberOfItensInAlert{
            return (itemSize * maxNumberOfItensInAlert) + 68
        }
        
        return alertInitialHeight
    }
    
}

// MARK: TableView Delegate & DataSource
extension LNFabAlertView: UITableViewDelegate, UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.itens.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier) as! LNFabItemTableViewCell
        cell.fill(model: model.itens[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableViewHeader.backgroundColor = UIColor.white
        return tableViewHeader
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        tableViewFooter.backgroundColor = UIColor.white
        return tableViewFooter
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectRow(tableView, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
}


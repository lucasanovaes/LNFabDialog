//
//  LNFabItemTableViewCell.swift
//  LNFabDialog
//
//  Created by iCasei Site on 15/01/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import UIKit

internal class LNFabItemTableViewCell: UITableViewCell {
    
    @IBOutlet private var icon: UIImageView!
    @IBOutlet private var titleText: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        icon.layer.masksToBounds = true
        icon.layer.cornerRadius = icon.frame.size.width / 2
    }
    
    func fill(model: LNFabItemModel.Item){
    
        titleText.font = model.layout?.font
        titleText.textColor = model.layout?.textColor
        
        titleText.text = model.title
        
        // If parameter `image` is passed in model, use it to fill the icon imageView, otherwise, download image from url
        if model.image != nil{
            icon.image = model.image
        }
        
        guard model.imageUrl != nil else {
            activityIndicator.isHidden = true
            return
        }
        
        if model.image == nil && model.imageUrl == nil{
            if model.placeholderImage != nil{
                self.icon.image = model.placeholderImage!
            }
        }
        
        URLSession.shared.dataTask(with: model.imageUrl!) { [weak self] (data, response, error) in
            if error == nil && data != nil{
                DispatchQueue.main.async {
                    self?.icon.image = UIImage(data: data!)
                    self?.activityIndicator.isHidden = true
                }
            }
        }.resume()
    
    }

}

 

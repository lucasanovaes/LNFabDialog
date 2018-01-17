//
//  LNFabItemTableViewCell.swift
//  LNFabDialog
//
//  Created by iCasei Site on 15/01/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import UIKit

class LNFabItemTableViewCell: UITableViewCell {
    
    @IBOutlet private var icon: UIImageView!
    @IBOutlet private var titleText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fill(model: LNFabItemModel){
    
        titleText.font = model.layout?.font
        titleText.textColor = model.layout?.textColor
        
        titleText.text = model.title
        
        // If parameter `image` is passed in model, use it to fill the icon imageView, otherwise, download image from url
        if model.image != nil{
            icon.image = model.image
        }
        
        guard model.imageUrl != nil else { return }
        
        URLSession.shared.dataTask(with: model.imageUrl!) { [weak self] (data, response, error) in
            if error == nil && data != nil{
                self?.icon.image = UIImage(data: data!)
            }
        }
    
    }

}

 

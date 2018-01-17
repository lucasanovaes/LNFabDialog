//
//  LNFabItem.swift
//  LNFabDialog
//
//  Created by iCasei Site on 15/01/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import Foundation

/// parameters: - title - Used to fill the text label
///             - image - UIImage object to fill UIImageView
///             - imageUrl - URL to download the image
///             - layout - Used to configure the style of the label

open class LNFabItemModel{
    
    var title: String
    var image: UIImage?
    var imageUrl: URL?
    
    var layout: LNFabItemLayout?
    
    public init(title: String, image: UIImage, layout: LNFabItemLayout? = LNFabItemLayout(font: UIFont(name: "Arial", size: 16)!, textColor: UIColor.black.withAlphaComponent(0.87))) {
        self.title = title
        self.image = image
    }
    
    public init(title: String, imageUrl: URL, layout: LNFabItemLayout? = LNFabItemLayout(font: UIFont(name: "Arial", size: 16)!, textColor: UIColor.black.withAlphaComponent(0.87))){
        self.title = title
        self.imageUrl = imageUrl
    }
    
    
}

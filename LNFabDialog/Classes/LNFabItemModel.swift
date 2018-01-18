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
    
    public struct Item{
        public var title: String
        public var image: UIImage?
        public var imageUrl: URL?
        public var placeholderImage: UIImage?
        public var layout: LNFabItemLayout?
        
        public init(title: String, image: UIImage?, placeholderImage: UIImage?, layout: LNFabItemLayout? = LNFabItemLayout(font: UIFont(name: "Arial", size: 16)!, textColor: UIColor.black.withAlphaComponent(0.87))) {
            self.title = title
            self.image = image
            self.placeholderImage = placeholderImage
            self.layout = layout
        }
        
        public init(title: String, imageUrl: URL?, placeholderImage: UIImage?, layout: LNFabItemLayout? = LNFabItemLayout(font: UIFont(name: "Arial", size: 16)!, textColor: UIColor.black.withAlphaComponent(0.87))){
            self.title = title
            self.imageUrl = imageUrl
            self.placeholderImage = placeholderImage
            self.layout = layout
        }
    }
    
    public var itens: [Item]
    public var sectionTitle: String
    public var sectionFont: UIFont? = UIFont(name: "Arial", size: 20)
    
    public init(itens: [Item], sectionTitle: String, sectionFont: UIFont?){
        self.itens = itens
        self.sectionTitle = sectionTitle
        self.sectionFont = sectionFont
    }

}

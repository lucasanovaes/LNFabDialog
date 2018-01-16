//
//  LNFabItem.swift
//  LNFabDialog
//
//  Created by iCasei Site on 15/01/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import Foundation

open class LNFabItemModel{
    
    var title: String
    var image: UIImage?
    
    var imageUrl: URL?{
        didSet{
            guard let url = imageUrl else { return }
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                if error == nil && data != nil{
                    self?.image = UIImage(data: data!)!
                }
            }
        }
    }
    
    init(title: String, image: UIImage) {
        self.title = title
        self.image = image
    }
    
    init(title: String, imageUrl: URL){
        self.title = title
        self.imageUrl = imageUrl
    }
    
    
}

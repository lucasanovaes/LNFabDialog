//
//  ViewController.swift
//  LNFabDialog
//
//  Created by lanovaes1@gmail.com on 01/16/2018.
//  Copyright (c) 2018 lanovaes1@gmail.com. All rights reserved.
//

import UIKit
import LNFabDialog

class ViewController: UIViewController {
    
    @IBOutlet weak var lnFabDialogButton: LNFabDialogButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lnItemModel = LNFabItemModel(itens: [LNFabItemModel.Item(title: "Lucas", imageUrl: URL(string: "https://www.icasei.com.br/images/thumb/1/0/public/150/150/0/d/dinalvaeaugustoapp/imagens/home/T279pe0xiArNz2mQ.jpeg"), placeholderImage: #imageLiteral(resourceName: "icon_avatar_statusnull")), LNFabItemModel.Item(title: "Gaby", image: #imageLiteral(resourceName: "icon_edit_white"), placeholderImage: #imageLiteral(resourceName: "icon_avatar_statusnull"))], sectionTitle: "Publicar no evento de:", sectionFont: nil)
        
        lnFabDialogButton.setup(model: lnItemModel, delegate: self)
    }

}


extension ViewController: LNFabDialogButtonDelegate{
    
    func didSelect(_ tableView: UITableView, at indexPath: IndexPath) {
        print(indexPath)
    }
    
}

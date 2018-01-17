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

        lnFabDialogButton.setup(model: [LNFabItemModel(title: "Lucas", image: #imageLiteral(resourceName: "icon_edit_white")), LNFabItemModel(title: "Gaby", image: #imageLiteral(resourceName: "icon_edit_white"))], delegate: self)
    }


}


extension ViewController: LNFabDialogButtonDelegate{
    
    func didSelect(_ tableView: UITableView, at indexPath: IndexPath) {
        print(indexPath)
    }
    
    
}

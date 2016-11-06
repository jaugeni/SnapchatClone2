//
//  ViewSnapVC.swift
//  SnapchatClone2
//
//  Created by YAUHENI IVANIUK on 11/6/16.
//  Copyright © 2016 be connected club. All rights reserved.
//

import UIKit

class ViewSnapVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = snap.descrip
        
    }
    
    
}

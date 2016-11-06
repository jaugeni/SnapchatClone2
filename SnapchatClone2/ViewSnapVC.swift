//
//  ViewSnapVC.swift
//  SnapchatClone2
//
//  Created by YAUHENI IVANIUK on 11/6/16.
//  Copyright © 2016 be connected club. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class ViewSnapVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = snap.descrip
        
        imageView.sd_setImage(with: URL(string: snap.imageURL))
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").child(snap.key).removeValue()
        FIRStorage.storage().reference().child("images").child("\(snap.uuid).jpg").delete { (error) in
            print("we deleted the pic")
        }
    }
}

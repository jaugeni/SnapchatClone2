//
//  PictureVC.swift
//  SnapchatClone2
//
//  Created by YAUHENI IVANIUK on 11/5/16.
//  Copyright © 2016 be connected club. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class PictureVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var nextBtnOutlet: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    var uuid = NSUUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        nextBtnOutlet.isEnabled = false
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        
        imageView.backgroundColor = UIColor.clear
        
                nextBtnOutlet.isEnabled = true
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func cameraBtm(_ sender: Any) {
        
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        
        nextBtnOutlet.isEnabled = false
        
        let imagesFolder = FIRStorage.storage().reference().child("images")
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
        
        
        
        imagesFolder.child("\(uuid).jpg").put(imageData, metadata: nil, completion: {(metadata, error) in
            print("We tried to upload!")
            if error != nil {
                print("We had an error:\(error)")
            } else {
                
                
                
                self.performSegue(withIdentifier: "selectUserSegue", sender: metadata?.downloadURL()!.absoluteString)
            }
        })
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let nextVC = segue.destination as! SelectUserVC
        nextVC.imageURL = sender as! String
        nextVC.descrip = descriptionTextField.text!
        nextVC.uuid = uuid
        
    }
    
}

//
//  SignInVC.swift
//  SnapchatClone2
//
//  Created by YAUHENI IVANIUK on 11/5/16.
//  Copyright © 2016 be connected club. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignInVC: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var turnUpBtnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    @IBAction func turnUpBtn(_ sender: Any) {
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("We tried to sign in")
            if error != nil {
                print("Hey we have an error: \(error)")
                
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We tried to create a user")
                    
                    if error != nil {
                        print("Hey we have an error: \(error)")
                    } else {
                        print("Created User successfully!")
                        
                        FIRDatabase.database().reference().child("users").child(user!.uid).child("email").setValue(user?.email!)
                        
                        self.performSegue(withIdentifier: "signInSegue", sender: nil)
                    }
                })
                
            } else {
                print("Signed in Succesfully")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
        })
        
    }
    
    
}


//
//  LogInViewController.swift
//  ChattApp
//
//  Created by Володимир Смульський on 8/20/18.
//  Copyright © 2018 Володимир Смульський. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    
    // MARK: @IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var register: UIButton?
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: @IBAction
    @IBAction func registrationButton(_ sender: UIButton) {
        handleRegister(on: sender)
        
    }
    
    // MARK: RegisterFunc
    func handleRegister(on button:UIButton){
        
        guard let email = emailTextfield.text, let password = passwordTextField.text, let name = nameTextField.text else { print("Form is not valid")
            return
            
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult , error) in
            if error != nil {
                print(error)
            }
            let user = Auth.auth().currentUser
            guard let uid = user?.uid else {
                return
            }
            
            // if seccessfuly authenticated user
            var ref: DatabaseReference! = Database.database().reference(fromURL: "https://chatapp-df9b7.firebaseio.com/")
            let userReference = ref.child("users").child(uid)
            
            let values = ["name": name, "email": email]
            userReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err)
                    return
                }
                print("Saved user successfuly into Firabase DB")
                
            })
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

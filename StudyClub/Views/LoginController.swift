//
//  ViewController.swift
//  StudyClub
//
//  Created by Victor Miranda de Melo on 14/05/18.
//  Copyright © 2018 Victor Miranda de Melo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var registrarBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        if(emailTextField.text != "" && passwordTextField.text != ""){
            loginAction(self)
        } else if (emailTextField.text == "") {
            emailTextField.becomeFirstResponder()
        } else if(passwordTextField.text == "") {
            passwordTextField.becomeFirstResponder()
        }

        return true
    }
    
    @IBAction func loginAction(_ sender: Any) {
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "", message: "Por favor, preencha seu email e senha.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
//                    print (user.)
//                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "studentArea") as! QuestionsViewController
//                    self.present(newViewController, animated: true, completion: nil)
                    
                    // Present modally segue! by gabriel bandeira
                    if(self.emailTextField.text == "hpbl@cin.ufpe.br") {
                            self.performSegue(withIdentifier: "showTeacherArea", sender: self)
                    } else {
                        self.performSegue(withIdentifier: "showStudentArea", sender: self)
                    }
                    
            
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Erro!", message: "Email ou senha inválidos.", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
}

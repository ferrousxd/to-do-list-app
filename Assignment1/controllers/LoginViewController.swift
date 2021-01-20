//
//  LoginViewController.swift
//  Assignment1
//
//  Created by Чингиз Азимбаев on 18.01.2021.
//

import UIKit

extension UIViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginField.delegate = self
        passwordField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func signIn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "TableViewController") as! TableViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}

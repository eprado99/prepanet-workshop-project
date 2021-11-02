//
//  ViewController.swift
//  AppPrepanet
//
//  Created by Alumno on 22/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    // tfUsuario
    // tfPassword
    // btEntrar
    
    @IBOutlet weak var tfUser: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btSignIn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btSignIn.layer.cornerRadius = 15
        
        //poner el tap por programa
        let tap = UITapGestureRecognizer(target: self, action: #selector(quitaTeclado))
        
        view.addGestureRecognizer(tap)
    }

    @IBAction func quitaTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let user = tfUser.text,
           let pass = tfPassword.text{
            let vistaIni = segue.destination as! ViewControllerAlumnos
            vistaIni.matricula = tfUser.text ?? ""
            
        }
        
    }
    
}


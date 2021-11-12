//
//  ViewController.swift
//  AppPrepanet
//
//  Created by Alumno on 22/10/21.
//

import UIKit

import FirebaseFirestore

class ViewController: UIViewController {
    
    // tfUsuario
    // tfPassword
    // btEntrar
    var db: Firestore!
    var rol: String!
    @IBOutlet weak var tfUser: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btSignIn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        
        db = Firestore.firestore()
        
        btSignIn.layer.cornerRadius = 15
        
        //poner el tap por programa
        let tap = UITapGestureRecognizer(target: self, action: #selector(quitaTeclado))
        
        view.addGestureRecognizer(tap)
    }

    private func getUserRole(key: String){
        
    }
    @IBAction func quitaTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let user = tfUser.text,
           let pass = tfPassword.text{
            getRol(matricula: tfUser.text!)
            if rol == "Alumno" {
                self.performSegue(withIdentifier: "vistaAlumno", sender: nil)
                let vistaIni = segue.destination as! ViewControllerAlumnos
                vistaIni.matriculaA = tfUser.text ?? ""
        
    }*/
    
    
    @IBAction func btLogin(_ sender: UIButton) {
        if let user = tfUser.text,
           let pass = tfPassword.text{
            getRol(matricula: tfUser.text!)
            if rol == "Alumno" {
                self.performSegue(withIdentifier: "vistaAlumno", sender: self)

            }
            else if rol == "Coord"{
                self.performSegue(withIdentifier: "vistaProfesor",sender: self)
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if rol == "Alumno"{
            let vistaIni = segue.destination as! ViewControllerAlumnos
            vistaIni.matriculaA = tfUser.text ?? ""
        }
        else{
            let vistaIni = segue.destination as! ViewControllerVistaInicial
            vistaIni.nomina = tfUser.text ?? ""
        }
    }
    
    private func getRol(matricula : String) {
            // let key = UserDefaults.standard.value(forKey: "uid") as? String ?? "Null"
            let key = matricula
            let userDoc = db.collection("Usuarios").whereField("email", isEqualTo: key)
            userDoc.getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("ERROR! No user with such ID. \(err)")
                } else if querySnapshot!.documents.count != 1 {
                    print("more than 1 doc")
                } else {
                    if let document = querySnapshot!.documents.first {
                        let userData = document.data()
                        let rol = userData["rol"] as? String ?? ""
                        self.rol = rol
                    }
                }
            }
        
    }
    
}


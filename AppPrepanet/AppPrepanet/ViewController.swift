//
//  ViewController.swift
//  AppPrepanet
//
//  Created by Alumno on 22/10/21.
//

import UIKit

import FirebaseFirestore
import FirebaseAuth

class ViewController: UIViewController {

    
    var user: User!
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
        tfPassword.isSecureTextEntry = true
        //poner el tap por programa
        let tap = UITapGestureRecognizer(target: self, action: #selector(quitaTeclado))
        
        view.addGestureRecognizer(tap)
        
    }
    
    @IBAction func quitaTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // MARK: - Navigation
    @IBAction func btEntrar(_ sender: UIButton) {
        if let user = tfUser.text,
           let pass = tfPassword.text{
            // TODO: FORMAT EMAIL
            let cleanUser = user.trimmingCharacters(in: .whitespacesAndNewlines)
            let cleanPass = pass.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().signIn(withEmail: cleanUser, password: cleanPass) { (authRes, err) in
                if let err = err {
                    print("There was an error")
                    print(err)
                    let alerta = UIAlertController(title: "Error", message: "Email o password incorrecto", preferredStyle: .alert)
                    let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alerta.addAction(accion)
                    self.present(alerta, animated: true, completion: nil)
                    
                } else {
                    print("Successful login")
                    guard let userID = Auth.auth().currentUser?.uid else { return }
                    print(userID)
                    
                    self.getRol(matricula: userID){
                        if self.rol == "Alumno" {
                            self.tfUser.text = ""
                            self.tfPassword.text = ""
                            self.performSegue(withIdentifier: "vistaAlumno", sender: self)

                        }
                        else if self.rol == "Coord"{
                            self.performSegue(withIdentifier: "vistaProfesor",sender: self)
                        }
                        else {
                            print("mm")
                        }
                    }
                }

            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if rol == "Alumno"{
            let vistaIni = segue.destination as! ViewControllerAlumnos
            //vistaIni.matriculaA = tfUser.text ?? ""
            print("nom: \(user.nombre) mat: \(user.matricula) rol: \(user.rol)")
            vistaIni.user = user
        }
        else{
            let vistaIni = segue.destination as! ViewControllerVistaInicial
            //vistaIni.nomina = tfUser.text ?? ""
            vistaIni.user = user
        }
    }
    
    // MARK: - Database
    private func getRol(matricula : String, completion: @escaping () -> Void) {
            // let key = UserDefaults.standard.value(forKey: "uid") as? String ?? "Null"
            let key = matricula
            let userDoc = db.collection("Usuarios").whereField("UID", isEqualTo: key)
            userDoc.getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("ERROR! No user with such ID. \(err)")
                } else if querySnapshot!.documents.count != 1 {
                    print("more than 1 doc")
                } else {
                    if let document = querySnapshot!.documents.first {
                        
                        print(document.documentID)
                        let userData = document.data()
                        let nomBD = userData["nombre"] as? String ?? ""
                        let campusBD = userData["campus"] as? String ?? ""
                        let emailBD = userData["email"] as? String ?? ""
                        //let matBD = userData["matricula"] as? String ?? ""
                        let matBD = document.documentID as? String ?? ""
                        let rolBD = userData["rol"] as? String ?? ""
                        self.user = User(nombre: nomBD, email: emailBD, matricula: matBD, campus: campusBD, rol: rolBD)
                        self.rol = rolBD

                        completion()
                    }
                }
            }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.portrait
    }
    override var shouldAutorotate: Bool {
    return false
    }
}


// podria ser un obj tambien user { name, matricula, campus }
/*
func getUser(documentId: String) {
  let docRef = db.collection("Usuarios").document(documentId)
    docRef.getDocument { (querySnapshot, error) in
        if let error = error {
            print(error)
        } else {
            let userData = querySnapshot!.data()
            let nombreDB = userData!["nombre"] as? String ?? ""
            let emailDB = userData!["email"] as? String ?? ""
            let campusDB = userData!["campus"] as? String ?? ""
        }
    }
}
 
 // registros dummy agarras arreglo -> string separado con commas
 // usar funcionalidad share
 */

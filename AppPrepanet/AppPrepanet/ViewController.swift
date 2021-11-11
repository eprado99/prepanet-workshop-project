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

    private func getUserRole(key: String){
        
    }
    @IBAction func quitaTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let user = tfUser.text,
           let pass = tfPassword.text{
            let vistaIni = segue.destination as! ViewControllerAlumnos
            vistaIni.matriculaA = tfUser.text ?? ""
            
        }
        
    }
    
}

/*
 
 let alerta = UIAlertController(title: "Error", message: "usuario o password incorrectos", preferredStyle: .alert)
             let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
             alerta.addAction(accion)
             present(alerta, animated: true, completion: nil)

 */


/*
 Auth.auth().signIn(withEmail: user, password: pass) { [self]
     (res, error) in
     if error != nil {
         // agregar label de error
         
     }
     else{
         // guard let userID = res.id else { return }/
         // var rol = getUserRole(key)
         // if rol = Alumno
         let vistaIni = segue.destination as! ViewControllerAlumnos
         let userDoc = db.collection("Usuarios").whereField("email", isEqualTo: user)
         userDoc.getDocuments {
             (querySnapshot, err) in
             if let err = err {
                 print("ERROR! No user with such email. \(err)")
             } else if querySnapshot!.documents.count != 1 {
                 print("more than 1 doc")
             } else {
                 if let document = querySnapshot!.documents.first {
                     let userData = document.data()
                     let nombreDB = userData["nombre"] as? String ?? ""
                     let matriculaDB = userData["matricula"] as? String ?? ""
                     let campusDB = userData["campus"] as? String ?? ""
                     // handle user nav from here? let rolDB = userData["rol"]...
                     vistaIni.nombreAlumno.text = nombreDB
                     vistaIni.matriculaAlumno.text = matriculaDB
                     vistaIni.campusAlumno.text = campusDB
                 }
             }
         }
 */


/*
  private func getUserData(key : String) {
      let userDoc = db.collection("Usuarios").whereField("matricula", isEqualTo: key)
      userDoc.getDocuments {
          (querySnapshot, err) in
          if let err = err {
              print("ERROR! No user with such email. \(err)")
          } else if querySnapshot!.documents.count != 1 {
              print("more than 1 doc")
          } else {
              if let document = querySnapshot?.documents.first {
                  let userData = document.data()
                  let matriculaDB = userData["matricula"] as? String ?? ""
                  let nombreDB = userData["nombre"] as? String ?? ""
                  let campusDB = userData["campus"] as? String ?? ""
                  // handle user nav from here? let rolDB = userData["rol"]...
                  let rolDB = userData["rol"] as? String ?? ""
                  self.userDB = User(nombre: nombreDB, matriculaID: matriculaDB, campus: campusDB, rol: rolDB)
                  print("\(nombreDB), \(matriculaDB), \(campusDB), \(rolDB)")
              }
          }
      }
  }
*/

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

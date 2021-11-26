//
//  ViewControllerArchivo.swift
//  AppPrepanet
//
//  Created by Jose Andres Villarreal Montemayor on 11/10/21.
//

import FirebaseFirestore
import UIKit

class ViewControllerArchivo: UIViewController {
    
    let db = Firestore.firestore()
    
    var arregloUsuarios : [String] = []
    var campus = ""
    var email = ""
    var matricula = ""
    var nombre = ""
    var rol = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db.collection("Usuarios").whereField("rol", isEqualTo: "Alumno")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        //print("\(document.documentID) => \(document.data())")
                        //self.arregloUsuarios.append(document.data())
                        self.nombre = document.data()["nombre"] as? String ?? " "
                        self.matricula = document.data()["matricula"] as? String ?? " "
                        self.email = document.data()["email"] as? String ?? " "
                        self.campus = document.data()["campus"] as? String ?? " "
                        self.rol = document.data()["rol"] as? String ?? " "
                        self.arregloUsuarios.append(self.nombre)
                        self.arregloUsuarios.append(self.matricula)
                        self.arregloUsuarios.append(self.email)
                        self.arregloUsuarios.append(self.campus)
                        self.arregloUsuarios.append(self.rol)
                        //generaReporte(nom: nombre, mat: matricula, mail: email, camp: campus, r: rol)
                    }
                }
                print(self.arregloUsuarios)
        }
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func buttShare(_ sender: UIButton) {
        //let datosUsuario = arregloUsuarios.joined(separator: ",")
        let share = [arregloUsuarios] as [Any]
        let activityViewController = UIActivityViewController(activityItems: share, applicationActivities: nil)
        
        //para iPhone y iPod
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

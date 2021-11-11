//
//  ViewControllerAlumnos.swift
//  AppPrepanet
//
//  Created by Emilio Fernando Prado Chible on 27/10/21.
//

import UIKit
import FirebaseFirestore

class ViewControllerAlumnos: UIViewController {
    
    var db: Firestore!
    var userDB : User!
    var matriculaA: String!
    var campusA: String!
    @IBOutlet weak var nombreAlumno: UILabel!
    @IBOutlet weak var matriculaAlumno: UILabel!
    @IBOutlet weak var campusAlumno: UILabel!
    @IBOutlet weak var BtTalleres: UIButton!
    @IBOutlet weak var BtPerfil: UIButton!
    
    
    // let user : User = getAlumno(matricula)
    // var contra : String = "prueba123"
    @IBOutlet weak var btWorkshop: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        
        db = Firestore.firestore()
        print(matriculaA)
        getAlumno(matricula: self.matriculaA)
        
        BtTalleres.layer.cornerRadius = 40
        BtPerfil.layer.cornerRadius = 40
        // Do any additional setup after loading the view.
        /*
        nombreAlumno.text = userDB.nombre
        matriculaAlumno.text = userDB.matriculaID
        campusAlumno.text = "Campus " + userDB.campus
        campusA = userDB.campus
 */
    }
    
    private func getAlumno(matricula : String) {
        // let key = UserDefaults.standard.value(forKey: "uid") as? String ?? "Null"
        let key = matricula
        let userDoc = db.collection("Usuarios").whereField("matricula", isEqualTo: key)
        userDoc.getDocuments { (querySnapshot, err) in
            if err != nil {
                if let document = querySnapshot!.documents.first {
                    let userData = document.data()
                    let nombre = userData["nombre"] as? String ?? ""
                    let matricula = userData["matricula"] as? String ?? ""
                    let campus = userData["campus"] as? String ?? ""
                    self.nombreAlumno.text = nombre
                    self.matriculaAlumno.text = matricula
                    self.campusAlumno.text = "Campus " + campus
                    self.campusA = campus
                }

                
            } else {
                print("error \(err)")
            }
            
        }
    }
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Checa si el destino es la vista ViewControllerPerfil y le comparte el nombre del alumno
        if segue.identifier == "perfilAlum"{
            let vcNavC = segue.destination as! UINavigationController
            let vcPerfil = vcNavC.topViewController as! ViewControllerPerfil
            vcPerfil.nombre = nombreAlumno.text
            vcPerfil.matricula = matriculaAlumno.text
            vcPerfil.campus = campusA
        } else {
            let vcNavC = segue.destination as! UINavigationController
            let vcWorkshop = vcNavC.topViewController as! TableViewControllerAWorkshop
            vcWorkshop.matricula = matriculaAlumno.text
        }
    }
    

}

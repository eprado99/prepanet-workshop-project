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
    var matricula: String!
    @IBOutlet weak var nombreAlumno: UILabel!
    @IBOutlet weak var matriculaAlumno: UILabel!
    
    // let user : User = getAlumno(matricula)
    // var contra : String = "prueba123"
    @IBOutlet weak var btWorkshop: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        
        db = Firestore.firestore()
        
        getAlumno(matricula: self.matricula)
        // Do any additional setup after loading the view.
    }
    
    private func getAlumno(matricula : String) {
        // let key = UserDefaults.standard.value(forKey: "uid") as? String ?? "Null"
        let key = matricula
        let userDoc = db.collection("Estudiantes").whereField("matricula", isEqualTo: key)
        userDoc.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("ERROR! No user with such ID. \(err)")
            } else if querySnapshot!.documents.count != 1 {
                print("more than 1 doc")
            } else {
                if let document = querySnapshot!.documents.first {
                    let userData = document.data()
                    let nombre = userData["nombre"] as? String ?? ""
                    let matricula = userData["matricula"] as? String ?? ""
                    let campus = userData["campus"] as? String ?? ""
                    let tallA = userData["talleresAprobados"] as? Int ?? 0
                    print("nombre: \(nombre) \nmatricula: \(matricula) \ncampus: \(campus) \ntallA \(tallA)")
                    // self.alumno = User(nombre: nombre, matricula: matricula, campus: campus, talleresAprobados: tallA)
                    self.nombreAlumno.text = nombre
                    self.matriculaAlumno.text = matricula
                  }
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "perfilAlum"{
            let vcNavC = segue.destination as! UINavigationController
            let vcPerfil = vcNavC.topViewController as! ViewControllerPerfil
            vcPerfil.nombre = nombreAlumno.text
        } else {
            
        }
    }
    

}

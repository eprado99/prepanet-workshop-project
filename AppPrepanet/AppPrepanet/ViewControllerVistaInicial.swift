//
//  ViewControllerVistaInicial.swift
//  AppPrepanet
//
//  Created by Alumno on 22/10/21.
//

import UIKit
import FirebaseFirestore
class ViewControllerVistaInicial: UIViewController {
    
    var db: Firestore!
    var campus: String!
    @IBOutlet weak var btTalleres: UIButton!
    @IBOutlet weak var btPerfil: UIButton!
    @IBOutlet weak var btAlumnos: UIButton!
    @IBOutlet weak var btArchivo: UIButton!
    
    @IBOutlet weak var nombreCoord: UILabel!
    @IBOutlet weak var matriculaCoord: UILabel!
    @IBOutlet weak var campusCoord: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        btTalleres.layer.cornerRadius = 40
        btPerfil.layer.cornerRadius = 40
        btAlumnos.layer.cornerRadius = 40
        btArchivo.layer.cornerRadius = 40
        
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        
        db = Firestore.firestore()
        
        getCoordinador(campus: campus)
    }
    
    // registros dummy agarras arreglo -> string separado con commas
    // usar funcionalidad share
    private func getCoordinador(campus : String) {
        // let key = UserDefaults.standard.value(forKey: "uid") as? String ?? "Null"
        let key = campus
        let userDoc = db.collection("Coordinadores").whereField("campus", isEqualTo: key)
        userDoc.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("ERROR! No user with such ID. \(err)")
            } else if querySnapshot!.documents.count != 1 {
                print("more than 1 doc")
            } else {
                if let document = querySnapshot!.documents.first {
                    let userData = document.data()
                    let nombreCoordDB = userData["nombre"] as? String ?? ""
                    let matriculaCoordDB = userData["matricula"] as? String ?? ""
                    
                    self.nombreCoord.text = nombreCoordDB
                    self.matriculaCoord.text = matriculaCoordDB
                    self.campusCoord.text = "Campus " + campus
                  }
            }
        }
    }
    @IBAction func Talleres(_ sender: UIButton) {
    }
    
    @IBAction func Perfil(_ sender: UIButton) {
    }
    
    @IBAction func RevisaAlumnos(_ sender: UIButton) {
    }
    
    @IBAction func ObtenArchivo(_ sender: UIButton) {
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

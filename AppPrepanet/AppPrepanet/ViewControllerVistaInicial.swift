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
    var nomina: String!
    var user: User!
    @IBOutlet weak var btTalleres: UIButton!
    @IBOutlet weak var btAlumnos: UIButton!
    @IBOutlet weak var btArchivo: UIButton!
    @IBOutlet weak var btPerfil: UIButton!
    @IBOutlet weak var btLogout: UIButton!
    
    
    
    @IBOutlet weak var nombreCoord: UILabel!
    @IBOutlet weak var matriculaCoord: UILabel!
    @IBOutlet weak var campusCoord: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        btTalleres.layer.cornerRadius = 40	
        btAlumnos.layer.cornerRadius = 40
        //btArchivo.layer.cornerRadius = 40
        btLogout.layer.cornerRadius = 5
        
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        
        db = Firestore.firestore()
        
        // getCoordinador(nomina: self.nomina)
        setUIData()
    }
    
    private func setUIData(){
        self.nombreCoord.text = user.nombre
        self.matriculaCoord.text = user.matricula
        self.campusCoord.text = "Campus " + user.campus
        
    }
    private func getCoordinador(nomina : String) {
        // let key = UserDefaults.standard.value(forKey: "uid") as? String ?? "Null"
        let key = nomina
        let userDoc = db.collection("Usuarios").whereField("email", isEqualTo: key)
        userDoc.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("ERROR! No user with such ID. \(err)")
            } else if querySnapshot!.documents.count != 1 {
                print("more than 1 doc")
            } else {
                if let document = querySnapshot!.documents.first {
                    let userData = document.data()
                    let nombreCoordDB = userData["nombre"] as? String ?? ""
                    // let matriculaCoordDB = document.documentID????
                    let matriculaCoordDB = userData["matricula"] as? String ?? ""
                    let campus = userData["campus"] as? String ?? ""

                    
                    self.nombreCoord.text = nombreCoordDB
                    self.matriculaCoord.text = matriculaCoordDB
                    self.campusCoord.text = "Campus " + campus
                  }
            }
        }
    }

    
    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
         // Checa si el destino es la vista ViewControllerPerfil y le comparte el nombre del alumno
         if segue.identifier == "talleres" {
             let vcNavC = segue.destination as! UINavigationController
             let vcTalleres = vcNavC.topViewController as! TableViewControllerAWorkshop
            vcTalleres.user = user
         } else if segue.identifier == "alumnos"{
             let vcNavC = segue.destination as! UINavigationController
             let vcWorkshop = vcNavC.topViewController as! TableViewControllerCampus
            
         } else if segue.identifier == "creditos" {
            let vistaSig = segue.destination as! ViewControllerCreditos
         }
     }
    
    
    @IBAction func logOut(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.portrait
    }
    override var shouldAutorotate: Bool {
    return false
    }
}

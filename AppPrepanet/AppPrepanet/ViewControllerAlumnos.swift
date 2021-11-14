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
    var user: User!
    var matriculaA: String!
    // var campusA: String!
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
        
        // getAlumno(matricula: self.matriculaA)
        print("\(user.nombre)")
        BtTalleres.layer.cornerRadius = 40
        BtPerfil.layer.cornerRadius = 40
        // Do any additional setup after loading the view.
        setUIData()
        
    }
    
    private func setUIData(){
        self.nombreAlumno.text = user.nombre
        self.matriculaAlumno.text = user.matricula
        self.campusAlumno.text = "Campus " + user.campus
    }
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Checa si el destino es la vista ViewControllerPerfil y le comparte el nombre del alumno
        if segue.identifier == "perfilAlum" {
            let vcNavC = segue.destination as! UINavigationController
            let vcPerfil = vcNavC.topViewController as! ViewControllerPerfil
            vcPerfil.nombre = nombreAlumno.text
            vcPerfil.matricula = matriculaAlumno.text
            vcPerfil.campus = user.campus
        } else {
            let vcNavC = segue.destination as! UINavigationController
            let vcWorkshop = vcNavC.topViewController as! TableViewControllerAWorkshop
            vcWorkshop.user = user
        }
    }
    

}

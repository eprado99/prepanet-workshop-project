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
    
    @IBOutlet weak var nombreAlumno: UILabel!
    @IBOutlet weak var matriculaAlumno: UILabel!
    @IBOutlet weak var campusAlumno: UILabel!
    @IBOutlet weak var BtTalleres: UIButton!
    @IBOutlet weak var BtPerfil: UIButton!
    @IBOutlet weak var btLogout: UIButton!
    
    
    @IBOutlet weak var btWorkshop: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        
        db = Firestore.firestore()
        

        print("\(user.nombre)")
        BtTalleres.layer.cornerRadius = 40
        BtPerfil.layer.cornerRadius = 40
        btLogout.layer.cornerRadius = 5

        setUIData()
        
    }
    
    @IBAction func logOut(sender: UIButton){
        dismiss(animated: true, completion: nil)
        print("logout")
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
            vcPerfil.user = user
            vcPerfil.nombre = nombreAlumno.text
            vcPerfil.matricula = matriculaAlumno.text
            vcPerfil.campus = user.campus
        }else if segue.identifier == "creditos" {
            let vistsSig = segue.destination as! ViewControllerCreditos
        }
        else {
            let vcNavC = segue.destination as! UINavigationController
            let vcWorkshop = vcNavC.topViewController as! TableViewControllerAWorkshop
            vcWorkshop.user = user
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.portrait
    }
    override var shouldAutorotate: Bool {
    return false
    }
}

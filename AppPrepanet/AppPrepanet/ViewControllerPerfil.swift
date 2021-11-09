//
//  ViewControllerPerfil.swift
//  AppPrepanet
//
//  Created by Emilio Fernando Prado Chible y Jose Andres Villarreal on 28/10/21.
//

import UIKit
import FirebaseFirestore

class ViewControllerPerfil: UIViewController {
    
    var db: Firestore!
    var nombre: String!
    var matricula: String!
    var campus: String!
    
    @IBOutlet weak var nomCoord: UILabel!
    @IBOutlet weak var correoCoord: UILabel!
    @IBOutlet weak var nombrePerf: UILabel!
    @IBOutlet weak var campusPerf: UILabel!
    

    @IBOutlet weak var backButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Perfil"
        nombrePerf.text = nombre
        // navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        
        // Database
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        getAlumno(campus: campus)
        
        // Styling
        drawSeparator(xCoor: 10, yCoor: 260)
        drawSeparator(xCoor: 10, yCoor: 420)
        
        
        campusPerf.text = "Campus " + campus
    }
    
    // MARK: - Styling
    private func drawSeparator(xCoor: Int, yCoor: Int) {
        let sepView = UIView(frame: CGRect(x: xCoor, y: yCoor, width: Int(self.view.frame.size.width)-20, height: 1))
        sepView.backgroundColor = UIColor.gray
        self.view.addSubview(sepView)
    }
    
    // MARK: - Database
    private func getAlumno(campus : String) {
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
                    let correoCoordDB = userData["correo"] as? String ?? ""
                    
                    self.nomCoord.text = nombreCoordDB
                    self.correoCoord.text = correoCoordDB
                  }
            }
        }
    }
    // MARK: - Navigation
    
    
    @IBAction func dismissVCP(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

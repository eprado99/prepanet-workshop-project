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
    
    var arregloUsuarios : [[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db.collection("Usuarios").whereField("rol", isEqualTo: "Alumno")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        //print("\(document.documentID) => \(document.data())")
                        self.arregloUsuarios.append(document.data())
                    }
                }
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

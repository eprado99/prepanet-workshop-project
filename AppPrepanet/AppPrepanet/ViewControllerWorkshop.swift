//
//  ViewControllerWorkshop.swift
//  AppPrepanet
//
//  Created by Emilio Fernando Prado Chible on 31/10/21.
//

import UIKit
import FirebaseFirestore

class ViewControllerWorkshop: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbAbout: UILabel!
    @IBOutlet weak var lbEstado: UILabel!
    @IBOutlet weak var lbDescEstado: UILabel!
    @IBOutlet weak var btInscripcion: UIButton!
    
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    
    var workshop : Workshop!
    var user: User!
    var inscripcion: Inscripcion!
    var userWks : [String:Any]!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbTitle.text = workshop.title
        lbAbout.text = workshop.descr
        // Check workshops enrolled by user
        isEnrolled()
        lbTitle.textAlignment = .center
        if user.rol == "Coord"{
            lbEstado.isHidden = true
            lbDescEstado.isHidden = true
            btInscripcion.isHidden = true
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .long
        dateFormatter1.timeStyle = .medium

        startDate.text = dateFormatter.string(from: workshop.startDate)
        endDate.text = dateFormatter.string(from: workshop.endDate)
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workshop.req.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = workshop.req[indexPath.row]
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func enrollBt(_ sender: UIButton){
        // Verificar si estamos "En Proceso" o "Aprobado" para el workshop actual
        enrollStudent()
        print("\(self.inscripcion.wkID)")
        lbDescEstado.text = "En proceso"
    }
    
    
    private func isEnrolled(){
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        // mejor jalar datos de Inscripciones
        let userStatus = db.collection("Inscripciones").whereField("matricula", isEqualTo: user.matricula)
        userStatus.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("There was an error \(err) or Didn't find any documents where matricula is  \(self.user.matricula)")
            } else {
                for document in querySnapshot!.documents {
                    let wkIDDB = document.get("tallerID") as! String
                    let campusIDDB = document.get("campusID") as! String
                    let matriculaAlumID = document.get("matricula") as! String
                    let statusDB = document.get("status") as! String
                    let dateDB = document.get("Date") as! Timestamp
                    let dateSwift : Date = dateDB.dateValue()
                    
                    self.inscripcion = Inscripcion(wkID: wkIDDB, campusID: campusIDDB, matriculaAlum: matriculaAlumID, status: statusDB, date: dateSwift)
                }
            }
        }
    }
    
    private func enrollStudent(){
        var db: Firestore!
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        // tallerID, campusID, matricula, status, Date
        let enrollData: [String: Any] = [
            
            "Date" : workshop.startDate,
            "tallerID" : workshop.wkID,
            "campusID" : user.campus,
            "matricula" : user.matricula,
            "status" : "En Proceso"
            
        ]
        
        var ref: DocumentReference? = nil
        ref = db.collection("InscripcionesDummy").addDocument(data: enrollData) { (err) in
            if let err = err {
                print("There was an error adding your doc \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        /*
        let enrollUserData: [String:Any] = [
            
            "status" : "En Proceso",
            "tallerID" : workshop.wkID
            
        ]
        
        var refAlumno  = db.collection("UsuariosDummy").document(user.matricula)
        refAlumno.updateData([
            "wkInscritos": FieldValue.arrayUnion([enrollUserData])
        ])
        */
    }
    
}

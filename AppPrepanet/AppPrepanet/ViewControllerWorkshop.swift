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
    var reqs : [Requerimiento] = []
    var user: User!
    var inscripciones: [Inscripcion] = []
    var userWks : [String:Any]!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbTitle.text = workshop.title
        lbAbout.text = workshop.descr
        btInscripcion.layer.cornerRadius = 4
        
        // Check workshops enrolled by user
        getEnrollmentStatus(){
            
            if(self.canEnroll()){
                self.btInscripcion.isEnabled = true
            } else {
                self.btInscripcion.isEnabled = false
            }
            self.isEnrolled()
            
        }
        
        initializeReqObject()
        
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
        
    }
    
    // MARK: - Table View
    
    func initializeReqObject(){
        var requerimiento : Requerimiento!
        for req in self.workshop.req {
            requerimiento = Requerimiento(req: req)
            self.reqs.append(requerimiento)
        }
        for inscripcion in inscripciones {
            for requerimiento in reqs{
                if(inscripcion.wkTitle == requerimiento.req){
                    requerimiento.status = inscripcion.status
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reqs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewSingleWorkshopCell
        cell.lbWkTitle?.text = reqs[indexPath.row].req
        
        print(reqs[indexPath.row].req)
        print(reqs[indexPath.row].status)
        if(reqs[indexPath.row].status == "En Proceso"){
            cell.imgStatus.image = UIImage(systemName: "checkmark")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
            
        } else if(reqs[indexPath.row].status == "Inscrito"){
            cell.imgStatus.image = UIImage(systemName: "checkmark.circle")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
        } else if(reqs[indexPath.row].status == "Aprobado"){
            cell.imgStatus.image = UIImage(systemName: "checkmark.circle")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
            
        } else {
            cell.imgStatus.image = nil
        }
        //cell.imgStatus.image = getSystemImage(status: inscripciones[indexPath.row].status ?? nil)
        return cell
    }
    
    func getSystemImage(status : String) -> UIImage {
        var image: UIImage!
        if(status == "En Proceso"){
            image = UIImage(systemName: "confirmation")
        }
        if(status == "Inscrito"){
            image = UIImage(systemName: "confirmation")
        }
        if(status == "Aprobado"){
            image = UIImage(systemName: "checkmark")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
            
        }
        return image
    }

    @IBAction func enrollBt(_ sender: UIButton){
        // Verificar si estamos "En Proceso" o "Aprobado" para el workshop actual
        enrollStudent(){
            self.isEnrolled()
        }
    }

    private func canEnroll() -> Bool {
        var enroll : Bool = false
        //print(inscripciones.count)
        //print(workshop.req.count)
        if(workshop.req.count == 0) {
            return true
        }
        for inscripcion in inscripciones{
            if(workshop.req.count == Int(inscripcion.wkID) && inscripcion.status == "Aprobado"){
                enroll = true
            }
        }
        //print(enroll)
        return enroll
    }
    
    private func getWkTitle(wkID:String){
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        let wkTitle = db.collection("Taller").document(wkID)
        wkTitle.getDocument { (querySnapshot, error) in
            if let error = error {
                print(error)
            } else {
                let wkData = querySnapshot!.data()
                let titleDB = wkData!["titulo"] as? String ?? ""
                print(titleDB)
            }
        }
        
    }
 
    private func getEnrollmentStatus(completion: @escaping () -> Void){
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        let userStatus = db.collection("Inscripciones").whereField("matricula", isEqualTo: user.matricula)
        userStatus.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("There was an error \(err) or Didn't find any documents where matricula is  \(self.user.matricula)")
            } else {
                for document in querySnapshot!.documents {
                    let wkIDDB = document.get("tallerID") as! String
                    let wkTitleDB = document.get("tallerTitle") as! String
                    let campusIDDB = document.get("campusID") as! String
                    let matriculaAlumID = document.get("matricula") as! String
                    let statusDB = document.get("status") as! String
                    let dateDB = document.get("Date") as! Timestamp
                    let dateSwift : Date = dateDB.dateValue()
                    
                    // print("\(wkIDDB) \(campusIDDB) \(matriculaAlumID) \(statusDB) \(dateSwift)")
                    let inscripcion = Inscripcion(wkTitle: wkTitleDB, wkID: wkIDDB, campusID: campusIDDB, matriculaAlum: matriculaAlumID, status: statusDB, date: dateSwift)
                    self.inscripciones.append(inscripcion)
                    
                    
                }
                completion()
            }
        }
    }
    
    private func isEnrolled(){
        for inscripcion in inscripciones {
            if(inscripcion.wkID == workshop.wkID){
                if(inscripcion.status == "En Proceso"){
                    self.btInscripcion.isEnabled = false
                }
                if(inscripcion.status == "Inscrito"){
                    self.btInscripcion.isEnabled = false
                    self.btInscripcion.backgroundColor = UIColor.systemGreen
                    self.btInscripcion.setTitle(inscripcion.status, for: .normal)
                }
                if(inscripcion.status == "Aprobado"){
                    self.btInscripcion.isEnabled = false
                    self.btInscripcion.backgroundColor = UIColor.systemGreen
                    self.btInscripcion.setTitle(inscripcion.status, for: .normal)
                }
                self.lbDescEstado.text = inscripcion.status
            }
        }
    }

    private func enrollStudent(completion: @escaping () -> Void){
        var db: Firestore!
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        // tallerID, campusID, matricula, status, Date
        let enrollData: [String: Any] = [
            "tallerTitle" : workshop.title,
            "Date" : workshop.startDate,
            "tallerID" : workshop.wkID,
            "campusID" : user.campus,
            "matricula" : user.matricula,
            "status" : "En Proceso"
            
        ]
        
        var ref: DocumentReference? = nil
        ref = db.collection("Inscripciones").addDocument(data: enrollData) { (err) in
            if let err = err {
                print("There was an error adding your doc \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                self.lbDescEstado.text = "En Proceso"
            }
        }

        btInscripcion.isEnabled = false
    }
    
}

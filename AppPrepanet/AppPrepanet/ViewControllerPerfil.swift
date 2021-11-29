//
//  ViewControllerPerfil.swift
//  AppPrepanet
//
//  Created by Emilio Fernando Prado Chible on 28/10/21.
//

import UIKit
import FirebaseFirestore

class ViewControllerPerfil: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    var titWK: String!
    var user: User!
    var db: Firestore!
    var nombre: String!
    var matricula: String!
    var campus: String!
    var inscripciones: [Inscripcion] = []
    @IBOutlet weak var nomCoord: UILabel!
    @IBOutlet weak var correoCoord: UILabel!
    @IBOutlet weak var nombrePerf: UILabel!
    @IBOutlet weak var campusPerf: UILabel!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var lbCampus: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let origen1 = self.nomCoord.frame.origin.y
        let altura1 = self.nomCoord.frame.height
        let ubicacion1 = origen1 + altura1 - 70
        
        print(Int(ubicacion1))
        
        let origen2 = self.correoCoord.frame.origin.y
        let altura2 = self.correoCoord.frame.height
        let ubicacion2 = origen2 + altura2 + 10
        
        drawSeparator(xCoor: 10, yCoor: Int(ubicacion1))
        drawSeparator(xCoor: 10, yCoor: Int(ubicacion2))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Perfil"
        nombrePerf.text = nombre
        campusPerf.text = "Campus " + campus
        // navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        // Database
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        getAlumno(campus: campus)
        getEnrollmentStatus { [self] in
            for inscripcion in inscripciones{
                print(inscripcion.wkID)
            }
        }
        print("USER EN PERFIL \(user.matricula)")

        // Styling
        
        
        tableView.reloadData()
        
    }
    
    // MARK: - Styling
    private func drawSeparator(xCoor: Int, yCoor: Int) {
        let sepView = UIView(frame: CGRect(x: xCoor, y: yCoor, width: Int(self.view.frame.size.width)-20, height: 1))
        sepView.backgroundColor = UIColor.gray
        self.view.addSubview(sepView)
    }
    
    // MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inscripciones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewPerfilCell
        let inscripcion = inscripciones[indexPath.row]
        cell.wkTitle.text = inscripcion.wkTitle
        if(inscripcion.status == "En Proceso"){
            cell.imgStatus.image = UIImage(systemName: "checkmark")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
            
        }
        if(inscripcion.status == "Inscrito"){
            cell.imgStatus.image = UIImage(systemName: "checkmark.circle")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
        }
        if(inscripcion.status == "Aprobado"){
            cell.imgStatus.image = UIImage(systemName: "checkmark.circle")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
            
        }
        return cell
        
    }
    
    // MARK: - Database
    private func getAlumno(campus : String) {
        let key = campus
        let userDoc = db.collection("Usuarios").whereField("campus", isEqualTo: key)
            .whereField("rol", isEqualTo: "Coord")
        userDoc.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("ERROR! No user with such ID. \(err)")
            } else if querySnapshot!.documents.count != 1 {
                print("more than 1 doc")
            } else {
                if let document = querySnapshot!.documents.first {
                    let userData = document.data()
                    let nombreCoordDB = userData["nombre"] as? String ?? ""
                    let correoCoordDB = userData["email"] as? String ?? ""
                    
                    self.nomCoord.text = nombreCoordDB
                    self.correoCoord.text = correoCoordDB
                  }
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
                    let wkTitleDB = document.get("tallerTitle") as! String
                    let wkIDDB = document.get("tallerID") as! String
                    let campusIDDB = document.get("campusID") as! String
                    let matriculaAlumID = document.get("matricula") as! String
                    let statusDB = document.get("status") as! String
                    let dateDB = document.get("Date") as! Timestamp
                    let dateSwift : Date = dateDB.dateValue()
                    let inscripcion = Inscripcion(wkTitle: wkTitleDB, wkID: wkIDDB, campusID: campusIDDB, matriculaAlum: matriculaAlumID, status: statusDB, date: dateSwift)
                    self.inscripciones.append(inscripcion)
                    
                    
                }
                self.tableView.reloadData()
                completion()
            }
        }
    }
    
    private func getWkTitle(wkID:String, completion: @escaping () -> Void){
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        var titleDB : String = ""
        let wkTitle = db.collection("Taller").document(wkID)
        wkTitle.getDocument { (querySnapshot, error) in
            if let error = error {
                print(error)
            } else {
                let wkData = querySnapshot!.data()
                titleDB = wkData!["titulo"] as? String ?? ""
                // print(titleDB) // silence warning
                print(titleDB)
            }
        }
        self.titWK = titleDB
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

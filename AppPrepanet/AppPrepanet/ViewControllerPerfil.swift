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
        isEnrolled()
        // Styling
        drawSeparator(xCoor: 10, yCoor: 260)
        drawSeparator(xCoor: 10, yCoor: 420)
        
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
        //cell.textLabel?.text = inscripcion.wkID
        cell.wkTitle?.text = inscripcion.wkID
        cell.imgStatus.image = UIImage(systemName: "checkmark")
        // get wk name by wk id
        
        // get image by status
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
    
    private func isEnrolled(){
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        // mejor jalar datos de Inscripciones
        let userStatus = db.collection("Inscripciones").whereField("matricula", isEqualTo: self.matricula)
        userStatus.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("There was an error \(err) or Didn't find any documents where matricula is  \(self.matricula)")
            } else {
                for document in querySnapshot!.documents {
                    let wkIDDB = document.get("tallerID") as! String
                    let campusIDDB = document.get("campusID") as! String
                    let matriculaAlumID = document.get("matricula") as! String
                    let statusDB = document.get("status") as! String
                    let dateDB = document.get("Date") as! Timestamp
                    let dateSwift : Date = dateDB.dateValue()
                    self.inscripciones.append(Inscripcion(wkID: wkIDDB, campusID: campusIDDB, matriculaAlum: matriculaAlumID, status: statusDB, date: dateSwift))
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

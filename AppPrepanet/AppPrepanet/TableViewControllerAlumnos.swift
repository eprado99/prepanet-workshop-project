//
//  TableViewControllerAlumnos.swift
//  AppPrepanet
//
//  Created by user195312 on 11/15/21.
//

import UIKit

import FirebaseFirestore

class TableViewControllerAlumnos: UITableViewController {

    var user: User!
    var db: Firestore!
    var campus: String!
    var nombreAlumno: String!
    var campusAlumno: String!
    var matriculaAlumno: String!
    
    var AlumnosArr : [User] = []
    
    @IBOutlet weak var btBack: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Alumnos"
        btBack.title = "Back"
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        getAlumnos(campus: campus)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AlumnosArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row%2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "celdaAlumno", for: indexPath) as! TableViewAlumnoCell
            let alumno = AlumnosArr[indexPath.row]
            cell.lbMatriculaAlumno.text = alumno.matricula
            let color = UIColor(red: 206/255, green: 235/255, blue: 255/255, alpha: 1)
            cell.View.backgroundColor = color
            cell.View.layer.cornerRadius = cell.View.frame.height/2
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "celdaAlumno", for: indexPath) as! TableViewAlumnoCell
            let alumno = AlumnosArr[indexPath.row]
            cell.lbMatriculaAlumno.text = alumno.matricula
            let color = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
            cell.View.backgroundColor = color
            cell.View.layer.cornerRadius = cell.View.frame.height/2

            return cell
        }
    }
    
    // MARK: - Database
    private func getAlumnos(campus: String) {
        let userDoc = db.collection("Usuarios").whereField("campus", isEqualTo: campus).whereField("rol", isEqualTo: "Alumno")
        userDoc.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("ERROR! \(err)")
            } else {
                for document in querySnapshot!.documents{
                    let userData = document.data()
                    self.nombreAlumno = userData["nombre"] as? String ?? ""
                    self.campusAlumno = userData["campus"] as? String ?? ""
                    let emailBD = userData["email"] as? String ?? ""
                    //let matBD = userData["matricula"] as? String ?? ""
                    self.matriculaAlumno = document.documentID as? String ?? ""
                    let rolBD = userData["rol"] as? String ?? ""
                    self.user = User(nombre: self.nombreAlumno, email: emailBD, matricula: self.matriculaAlumno, campus: self.campusAlumno, rol: rolBD)
                    
                    self.AlumnosArr.append(self.user)
                }
            }
            self.tableView.reloadData()
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vistaPerfilAlumno = segue.destination as! ViewControllerPerfil
        let index = tableView.indexPathForSelectedRow!
        vistaPerfilAlumno.nombre = self.AlumnosArr[index.row].nombre
        vistaPerfilAlumno.campus = self.AlumnosArr[index.row].campus
        vistaPerfilAlumno.matricula = self.AlumnosArr[index.row].matricula
        vistaPerfilAlumno.user = self.user
    }
    
    @IBAction func regresarTablaCampus(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}

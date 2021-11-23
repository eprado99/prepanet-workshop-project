//
//  TableViewControllerAlumnos.swift
//  AppPrepanet
//
//  Created by user195312 on 11/15/21.
//

import UIKit

import FirebaseFirestore

class TableViewControllerAlumnos: UITableViewController {

    var db: Firestore!
    var campus: String!
    var nombreAlumno: String!
    var campusAlumno: String!
    var matriculaAlumno: String!
    
    var AlumnosArr : [String] = []
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaAlumno", for: indexPath) as! TableViewAlumnoCell
        let alumno = AlumnosArr[indexPath.row]
        cell.lbMatriculaAlumno.text = alumno

        return cell
    }
    
    // MARK: - Database
    private func getAlumnos(campus: String) {
        let userDoc = db.collection("Usuarios").whereField("campus", isEqualTo: campus).whereField("rol", isEqualTo: "Alumno")
        userDoc.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("ERROR! \(err)")
            } else {
                for document in querySnapshot!.documents{
                    //document.documentID
                    let matricula = document.get("matricula") as! String
                    self.nombreAlumno = document.get("nombre") as? String
                    self.campusAlumno = document.get("campus") as? String
                    self.matriculaAlumno = document.get("matricula") as? String
                    self.AlumnosArr.append(matricula)
                }
            }
            self.tableView.reloadData()
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vistaPerfilAlumno = segue.destination as! ViewControllerPerfil
        vistaPerfilAlumno.nombre = self.nombreAlumno
        vistaPerfilAlumno.campus = self.campus
        vistaPerfilAlumno.matricula = self.matriculaAlumno
    }
    
    @IBAction func regresarTablaCampus(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}

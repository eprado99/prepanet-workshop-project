//
//  TableViewControllerCampus.swift
//  AppPrepanet
//
//  Created by user195312 on 11/15/21.
//

import UIKit
import FirebaseFirestore

class TableViewControllerCampus: UITableViewController {
    
    var db: Firestore!
    
    var campusArr : [String] = []

    @IBOutlet weak var btBack: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Campus"
        btBack.title = "Back"
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        getCampus()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return campusArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! TableViewCampusCell
            let campus = campusArr[indexPath.row]
            
            
            cell.lbNombreCampus.text = campus
            let color = UIColor(red: 206/255, green: 235/255, blue: 255/255, alpha: 1)
            cell.View.backgroundColor = color
            cell.View.layer.cornerRadius = cell.View.frame.height/2
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! TableViewCampusCell
            let campus = campusArr[indexPath.row]
            
            
            cell.lbNombreCampus.text = campus
            let color = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
            cell.View.backgroundColor = color
            cell.View.layer.cornerRadius = cell.View.frame.height/2
            return cell
        }
    }
    
    // MARK: - Database
    
    private func getCampus(){
        db.collection("Campus").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let nombreCampus = document.get("campus") as! String
                    
                    self.campusArr.append(nombreCampus)
                }
            }
            self.tableView.reloadData()
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vistaTablaAlumnos = segue.destination as! UINavigationController
        let vcAlumnos = vistaTablaAlumnos.topViewController as! TableViewControllerAlumnos
        let index = tableView.indexPathForSelectedRow!
        vcAlumnos.campus = campusArr[index.row]
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func regresarVistaCoord(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}

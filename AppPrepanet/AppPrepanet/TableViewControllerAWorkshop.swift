//
//  TableViewControllerAWorkshop.swift
//  AppPrepanet
//
//  Created by Emilio Fernando Prado Chible on 28/10/21.
//

import UIKit

import FirebaseFirestore

class TableViewControllerAWorkshop: UITableViewController {
    
    var db: Firestore!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    var workshopArr : [Workshop] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.title = "Back"
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        
        db = Firestore.firestore()
        
        getWorkshops()
        
        
    }
    
    private func getWorkshops() {
        db.collection("Talleres").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let titBD = document.get("titulo") as! String
                    let desBD = document.get("descripcion") as! String
                    let reqBD = document.get("requerimientos") as! [String]
                    //print("\(document.documentID) => \(document.data())")
                    /*
                    if let data = document.data() as? [String: Any]{
                        for wk in data {
                            guard let validWK = wk as? Dictionary<String, Any> else {
                                continue
                            }
                            let tit = validWK["titulo"] as? String ?? "hola"
                            let des = validWK["descripcion"] as? String ?? "hola"
                            print("titulo: \(tit), descripcion: \(des)")
                        }
                        */
                    print(reqBD)
                    self.workshopArr.append(Workshop(title: titBD, descr: desBD, req: reqBD))
                    
                }
                    
            }
            self.tableView.reloadData()
    }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return workshopArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewWorkshopCell
        let workshop = workshopArr[indexPath.row]
        cell.lbTitle.text = workshop.title
        cell.lbDescription.text = workshop.descr
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    
    @IBAction func regresarVCA(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "vistaAlumFromWk"){
            let vistaAlumWk = segue.destination as! ViewControllerAlumnos
        } else{
            
            let vistaWorkshop = segue.destination as! ViewControllerWorkshop
            let index = tableView.indexPathForSelectedRow!
            vistaWorkshop.workshop = workshopArr[index.row]
            
        }

        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

/*
 private var restaurants: [Restaurant] = []
   private var documents: [DocumentSnapshot] = []

   fileprivate var query: Query? {
     didSet {
       if let listener = listener {
         listener.remove()
         observeQuery()
       }
     }
   }

   private var listener: ListenerRegistration?

   fileprivate func observeQuery() {
     guard let query = query else { return }
     stopObserving()

     // Display data from Firestore, part one
     listener = query.addSnapshotListener { [unowned self] (snapshot, error) in
       guard let snapshot = snapshot else {
         print("Error fetching snapshot results: \(error!)")
         return
       }
       let models = snapshot.documents.map { (document) -> Restaurant in
         if let model = Restaurant(dictionary: document.data()) {
           return model
         } else {
           // Don't use fatalError here in a real app.
           fatalError("Unable to initialize type \(Restaurant.self) with dictionary \(document.data())")
         }
       }
       self.restaurants = models
       self.documents = snapshot.documents

       if self.documents.count > 0 {
         self.tableView.backgroundView = nil
       } else {
         self.tableView.backgroundView = self.backgroundView
       }

       self.tableView.reloadData()
     }
   }

   fileprivate func stopObserving() {
     listener?.remove()
   } */

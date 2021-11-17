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
    var user: User!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    var workshopArr : [Workshop] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Talleres"
        backButton.title = "Back"
        
        // Database
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        getWorkshops()
        
    }
    


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workshopArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewWorkshopCell
        let workshop = workshopArr[indexPath.row]
        cell.lbTitle.text = workshop.title
        cell.lbDescription.text = workshop.descr
        cell.viewFondo.layer.cornerRadius = cell.viewFondo.frame.height / 2
        return cell
    }

    // MARK: - Navigation
    @IBAction func regresarVCA(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vistaWorkshop = segue.destination as! ViewControllerWorkshop
        let index = tableView.indexPathForSelectedRow!
        vistaWorkshop.workshop = workshopArr[index.row]
        vistaWorkshop.user = user
    }
    
    // MARK: - Database
    private func getWorkshops() {
        db.collection("Talleres").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let idBD = document.documentID
                    let titBD = document.get("titulo") as! String
                    let desBD = document.get("descripcion") as! String
                    let reqBD = document.get("requerimientos") as! [String]
                    let dates = document.get("wkDate") as! [Timestamp]
                    let startDateBD : Date = dates[0].dateValue()
                    let endDateBD : Date = dates[1].dateValue()

                    // Formatting objects
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = .medium
                    dateFormatter.timeStyle = .short
                    
                    let dateFormatter1 = DateFormatter()
                    dateFormatter1.dateStyle = .long
                    dateFormatter1.timeStyle = .medium
                    
                    let dateFormatter2 = DateFormatter()
                    dateFormatter2.dateStyle = .medium
                    dateFormatter2.timeStyle = .none
                    
                    let dateFormatter3 = DateFormatter()
                    dateFormatter3.dateStyle = .none
                    dateFormatter3.timeStyle = .short
                    
                    // Formatting examples
                    print("-----------------------------------")
                    print(dateFormatter.string(from: startDateBD))
                    print(dateFormatter1.string(from: startDateBD))
                    print(dateFormatter2.string(from: startDateBD), dateFormatter3.string(from: startDateBD))
                    print(dateFormatter2.string(from: endDateBD), dateFormatter3.string(from: endDateBD))
                    /*
                     Todos los metodos asumen por default el current timeZone del usuario
                     Feb 14, 2022 at 9:00 AM (dateFormatter)
                     February 14, 2022 at 9:00:00 AM (dateFormatter1)
                     dateFormatter2 y dateFormatter3 se usan para obtener la fecha y la hora por separado
                     Feb 14, 2022 9:00 AM (dateFormatter2, dateFormatter3)
                     Feb 18, 2022 1:00 PM (dateFormatter2, dateFormatter3)
                    */

                    // print data
                    // print("\(idBD) \(titBD) \(desBD)")
                    self.workshopArr.append(Workshop(wkID: idBD, title: titBD, descr: desBD, req: reqBD, startDate: startDateBD, endDate: endDateBD))
                    
                }
                    
            }
            self.tableView.reloadData()
    }
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

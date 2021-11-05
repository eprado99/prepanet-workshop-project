//
//  ViewControllerWorkshop.swift
//  AppPrepanet
//
//  Created by Emilio Fernando Prado Chible on 31/10/21.
//

import UIKit

class ViewControllerWorkshop: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbAbout: UILabel!
    
    var workshop : Workshop!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbTitle.text = workshop.title
        lbAbout.text = workshop.descr
        lbTitle.textAlignment = .center
        
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
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

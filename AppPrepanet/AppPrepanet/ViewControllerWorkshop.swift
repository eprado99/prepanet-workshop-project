//
//  ViewControllerWorkshop.swift
//  AppPrepanet
//
//  Created by Emilio Fernando Prado Chible on 31/10/21.
//

import UIKit

class ViewControllerWorkshop: UIViewController {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbAbout: UILabel!
    @IBOutlet weak var lbReq: UILabel!
    
    var workshop : Workshop!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbTitle.text = workshop.title
        lbAbout.text = workshop.descr
        lbTitle.textAlignment = .center
        
        // Do any additional setup after loading the view.
    }
    
    
    // logica de inscripcion
    // vars:
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

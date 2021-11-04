//
//  ViewControllerPerfil.swift
//  AppPrepanet
//
//  Created by Emilio Fernando Prado Chible on 28/10/21.
//

import UIKit

class ViewControllerPerfil: UIViewController {
    var nombre : String!
    @IBOutlet weak var nombrePerf: UILabel!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Perfil"
        nombrePerf.text = nombre
        //let button = backButton.customView as! UIButton
        //button.setTitle("Back", for: .normal)
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "Something Else", style: .plain, target: nil, action: nil)
        // Do any additional setup after loading the view.
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

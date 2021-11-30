//
//  ViewControllerArchivo.swift
//  AppPrepanet
//
//  Created by Jose Andres Villarreal Montemayor on 11/10/21.
//

import UIKit

class ViewControllerArchivo: UIViewController {
    
    var arregloDummy : [String] = ["Nombre", "Matricula", "Campus"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "prueba"

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func buttShare(_ sender: UIButton) {
        let datosUsuario = arregloDummy.joined(separator: ",")
        let share = [datosUsuario] as [Any]
        let activityViewController = UIActivityViewController(activityItems: share, applicationActivities: nil)
        
        //para iPhone y iPod
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.portrait
    }
    override var shouldAutorotate: Bool {
    return false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

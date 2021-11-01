//
//  ViewControllerVistaInicial.swift
//  AppPrepanet
//
//  Created by Alumno on 22/10/21.
//

import UIKit

class ViewControllerVistaInicial: UIViewController {
    
    @IBOutlet weak var btTalleres: UIButton!
    @IBOutlet weak var btPerfil: UIButton!
    @IBOutlet weak var btAlumnos: UIButton!
    @IBOutlet weak var btArchivo: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btTalleres.layer.cornerRadius = 40
        btPerfil.layer.cornerRadius = 40
        btAlumnos.layer.cornerRadius = 40
        btArchivo.layer.cornerRadius = 40
        
    }
    

    @IBAction func Talleres(_ sender: UIButton) {
    }
    
    @IBAction func Perfil(_ sender: UIButton) {
    }
    
    @IBAction func RevisaAlumnos(_ sender: UIButton) {
    }
    
    @IBAction func ObtenArchivo(_ sender: UIButton) {
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

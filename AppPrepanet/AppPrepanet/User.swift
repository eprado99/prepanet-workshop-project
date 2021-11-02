//
//  User.swift
//  AppPrepanet
//
//  Created by Emilio Fernando Prado Chible on 02/11/21.
//

import UIKit

class User: NSObject {
    
    var nombre : String
    var matricula : String
    var campus : String
    var talleresAprobados : Int
    /*
    init() {
        self.nombre = ""
        self.matricula = ""
        self.campus = ""
        self.talleresAprobados = 0
    }
    */
    init(nombre: String, matricula: String, campus: String, talleresAprobados: Int){
        self.nombre = nombre
        self.matricula = matricula
        self.campus = campus
        self.talleresAprobados = talleresAprobados
    }
}

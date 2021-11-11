//
//  User.swift
//  AppPrepanet
//
//  Created by Emilio Fernando Prado Chible on 02/11/21.
//

import UIKit

class User: NSObject {
    var nombre : String
    var matriculaID : String
    var campus : String
    var rol : String
    /*
    init() {
        self.nombre = ""
        self.matricula = ""
        self.campus = ""
        self.talleresAprobados = 0
    }
    */
    init(nombre: String, matriculaID: String, campus: String, rol: String){
        self.nombre = nombre
        self.matriculaID = matriculaID
        self.campus = campus
        self.rol = rol
    }
}

// MARK: - Docs
// El ID del usuario es la matricula
// Un usuario contiene "nombre", "campus", "email" y "rol"
// Roles de usuario: ["Alumno", "Coord", "Admin"]

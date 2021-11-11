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
    var email : String
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
    init(nombre: String, email: String, matricula: String, campus: String, rol: String){
        self.nombre = nombre
        self.matricula = matricula
        self.campus = campus
        self.email = email
        self.rol = rol
    }
}

// MARK: - Docs
// El ID del usuario es la matricula
// Un usuario contiene "nombre", "matricula", "campus", "email" y "rol"
// Roles de usuario: ["Alumno", "Coord", "Admin"]

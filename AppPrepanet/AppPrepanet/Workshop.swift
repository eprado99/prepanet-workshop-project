//
//  Workshop.swift
//  AppPrepanet
//
//  Created by Emilio Fernando Prado Chible on 30/10/21.
//

import UIKit

class Workshop: NSObject {

    var title: String
    var descr: String
    var req: [String]
    
    init(title: String, descr: String, req: [String]) {
        self.title = title
        self.descr = descr
        self.req = req
    }
    
}

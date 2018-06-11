//
//  MenuController.swift
//  Esqueleto
//
//  Created by Jair Moreno Gaspar on 07/06/18.
//  Copyright © 2018 Jair Moreno Gaspar. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAnalytics
import QuartzCore

class MenuController: UIViewController {
    
    let botonCerrarSesion: UIButton = UIButton()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.darkGray
        
        
        
        
        botonCerrarSesion.backgroundColor = UIColor.blue
        botonCerrarSesion.frame = CGRect(x: self.view.frame.width * 0.1, y: self.view.frame.height
            * 0.4, width: self.view.frame.width * 0.2, height: self.view.frame.height * 0.1)
        botonCerrarSesion.setTitle("Cerrar Sesión", for: .normal)
        botonCerrarSesion.addTarget(self, action: #selector(self.cerrarSesion), for: .touchUpInside)
        self.view.addSubview(botonCerrarSesion)
        
    }
    
    @objc
    func cerrarSesion(){
        self.performSegue(withIdentifier: "menutologin", sender: self)
    }
    
}

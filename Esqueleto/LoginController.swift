//
//  LoginController.swift
//  Esqueleto
//
//  Created by Jair Moreno Gaspar on 07/06/18.
//  Copyright © 2018 Jair Moreno Gaspar. All rights reserved.
//




/*
 A tomar en cuenta:
 
 
 Se comento en el Esqueleto-Bridging-Header el encryption util
 Se comento en funciones generales la funcion extraerTexto que utilizaba la encriptacion
 Si se quiere utilizar la encriptación se requiere agregar el framework
 Se requiere cambiar la licencia de google maps que esta en el archivo GoogleService-Info.plist
 Se requiere cambiar la llave de google en didfinishlau.. en el appdelegate
 Para que funcione el buscador descomentar esta linea en el archivo menuInferior: botonBusqueda.addTarget(self, action:#selector(iraBuscar), for: .touchUpInside)
 Hace falta importar la tipografía y cambiarla en funciones generales
 hace falta ponerle un target al texto que tiene el menu inferior para que cambie de controller al presionarlo
 
 
 
 */

import Foundation
import UIKit
import FirebaseAnalytics
import QuartzCore

class LoginController: UIViewController {
    
    let irAMenu: UIButton = UIButton()
    
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.white
        
        irAMenu.frame = CGRect(x: self.view.frame.width * 0.3, y: self.view.frame.height * 0.4, width: self.view.frame.width * 0.4, height: self.view.frame.height * 0.1)
        irAMenu.setTitle("Ir a Menu", for: .normal)
        irAMenu.backgroundColor = UIColor.blue
        irAMenu.addTarget(self, action: #selector(self.irAInicio), for: .touchUpInside)
        self.view.addSubview(irAMenu)
    }
    
    @objc
    func irAInicio(){
        self.performSegue(withIdentifier: "logintoinicio", sender: self)
    }
    
}

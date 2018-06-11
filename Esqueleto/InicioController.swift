//
//  InicioController.swift
//  Esqueleto
//
//  Created by Jair Moreno Gaspar on 07/06/18.
//  Copyright © 2018 Jair Moreno Gaspar. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAnalytics
import QuartzCore


class InicioController: UIViewController {
    
    var barraTitulo: UIView = UIView()
    var barraMenu: UIView = UIView()
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.gray
        
        
        
        ultimoController = self
        seccionActual = 1
        
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().rearViewRevealWidth = self.view.frame.width * 0.80
            self.revealViewController().frontViewShadowColor = UIColor.clear
        }
        
        barraTitulo = menuSuperior.inicializarComponentes(vista: self.view, tituloTexto: "Tab1")
        self.view.addSubview(barraTitulo)
        barraMenu = menuInferior.inicializarComponentes(vista: self.view)
        self.view.addSubview(barraMenu)
        
        
    }
}
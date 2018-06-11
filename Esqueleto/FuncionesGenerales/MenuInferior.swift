//
//  MenuInferior.swift
//  TelmexConmigoPlusPlus
//
//  Created by Mac Hitss on 3/26/18.
//  Copyright © 2018 MAC2. All rights reserved.
//

import Foundation
import UIKit

class MenuInferior: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    let NUM_BOTONES = 5
    let NOTICIAS = 0
    let CONMIGO = 1
    let MIS_SERVICIOS = 2
    let CORREO = 3
    let WIFI = 4
    
    var seccion = -1
    
    var menuColeccion:UICollectionView!
    
    
    func inicializarComponentes(vista: UIView, seccion: Int=1) -> UIView{
        self.seccion = seccion
        let menuVista: UIView = UIView()
        
        menuVista.frame = CGRect(x: 0, y: vista.frame.height * 0.925, width: vista.frame.width, height: vista.frame.height * 0.075)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //layout.itemSize = CGSize(width: vista.frame.width / (CGFloat)(NUM_BOTONES), height: altoStatusBar * 0.5)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        let posicionGrid = CGRect(x: 0, y: 0, width: menuVista.frame.width, height: menuVista.frame.height)
        menuColeccion = UICollectionView(frame: posicionGrid, collectionViewLayout: layout)
        menuColeccion.dataSource = self
        menuColeccion.delegate = self
        menuColeccion.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        menuColeccion.backgroundColor = colorGrisBgCollections
        
        menuVista.addSubview(menuColeccion)
        
        return menuVista
    }
    
    // MARK: Delegados
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NUM_BOTONES
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath)
        let auxImagen:UIButton = UIButton()
        let textoSeccion:UIButton = UIButton()
        
        for subvista in cell.subviews {
            subvista.removeFromSuperview()
        }
        let q = indexPath.row + 1
        
        let botonMenu1:UIButton = UIButton()
        botonMenu1.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
        
        let imagenPresionada = (UIImage(named:"iconoMenu\(q)Gris"))?.resize2(targetSize: CGSize(width: 34, height: 28))
        auxImagen.setImage(imagenPresionada, for: .normal)
        auxImagen.frame = botonMenu1.frame
        textoSeccion.frame = CGRect(x: 0, y: botonMenu1.frame.origin.y + botonMenu1.frame.height * 0.8, width: botonMenu1.frame.width, height: botonMenu1.frame.height * 0.2)
        textoSeccion.backgroundColor = nil
        textoSeccion.setTitleColor(UIColor(rgba:"#C2C2C2"), for: .normal)
        textoSeccion.setTitle(traerTituloSeccion(indice: indexPath.row), for: .normal)
        textoSeccion.titleLabel?.font = UIFont(name: "Arial", size: tamanoLetra * 0.6)
        
        auxImagen.isUserInteractionEnabled = false
        textoSeccion.isUserInteractionEnabled = false
        botonMenu1.isUserInteractionEnabled = false
        
        botonMenu1.addSubview(auxImagen)
        botonMenu1.addSubview(textoSeccion)
        
        
        switch q {
        case 4:
            break
        default:
            //auxImagen.addTarget(accionesMenu, action:#selector(accionesMenu.mover), for: .touchUpInside)
            print("")
        }
   
        if (indexPath.row + 1) == self.seccion {
            
            //Gradient
            let gradient:CAGradientLayer = CAGradientLayer()
            let colorTop = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
            let colorBottom = UIColor(red: 0.0/255.0, green: 151.0/255.0, blue: 254.0/255.0, alpha: 1.0).cgColor
            gradient.colors = [colorTop, colorBottom]
            gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
            gradient.frame = botonMenu1.bounds
            botonMenu1.layer.addSublayer(gradient)
            
            //Se hizo esto porque el gradiente tapaba la imagen de boton
            let imagenPresionada = (UIImage(named:"iconoMenu\(q)Azul"))?.resize2(targetSize: CGSize(width: 34, height: 28))
            auxImagen.setImage(imagenPresionada, for: .normal)
            auxImagen.frame = botonMenu1.frame
            textoSeccion.setTitleColor(UIColor.white, for: .normal)
            //botonMenu1.setImage(auxImagen.resize2(targetSize: CGSize(width: 32, height: 32)), for: .normal)
            botonMenu1.addSubview(auxImagen)
            botonMenu1.addSubview(textoSeccion)
        }
        
        botonMenu1.tag = q
        auxImagen.tag = q
        botonMenu1.titleLabel?.font = botonMenu1.titleLabel?.font.withSize(2)
        
        cell.addSubview(botonMenu1)
        
        return cell
    }
    
    func traerTituloSeccion(indice: Int) -> String{
        switch indice {
        case 0:
            return "Noticias"
        case 1:
            return "Conmigo"
        case 2:
            return "Mis servicios"
        case 3:
            return "Correo"
        case 4:
            return "Wifi Móvil"
        default:
            return ""
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let vistaActual = UIApplication.topViewController()
        return CGSize(width: collectionView.frame.width / (CGFloat)(NUM_BOTONES), height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
            
            switch indexPath.row + 1{
                
            case 1:
                siguienteController = InicioController()
                print("Mover a inicioController")
                 moverPantalla()
            case 2:
                siguienteController = LoNuestroController()
                print("Mover a LoNuestroController")
                 moverPantalla()
            case 3:
                siguienteController = ServiciosController()
                print("Mover a ServiciosController")
                 moverPantalla()
            case 4:
                break
            case 5:
                siguienteController = WifiController()
                print("Mover a WifiController")
                 moverPantalla()
                
            default:
                print("No se pudo cambiar de controller")
        }
        
        
        
       
    }
    
 
}












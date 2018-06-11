//
//  MenuSuperior.swift
//  TelmexConmigoPlusPlus
//
//  Created by Mac Hitss on 3/26/18.
//  Copyright © 2018 MAC2. All rights reserved.
//

import Foundation

class MenuSuperior: UIView{//}, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    let BOTON_ATRAS = 0
    let MENU_ATRAS = 1
    let MENU_BUSCADOR = 2
    let MENU_HAMBURGUESA = 3
    let GRADIENTE = 4
    
    let configuracion:UIView = UIView()
    var nombreSeccion = ""
    var tipoMenu = -1
    
    func inicializarComponentes(vista: UIView, tipo: Int?=nil, tituloTexto: String) -> UIView{
        let barraTitulo:UIView = UIView()
        let altoStatusBar = UIApplication.shared.statusBarFrame.height
        
        barraTitulo.frame = CGRect(x: 0, y: altoStatusBar, width: vista.frame.width, height: (vista.frame.height * 0.1) - altoStatusBar)
        //barraTitulo.backgroundColor = UIColor(rgba:"#e1e2e3")
        barraTitulo.layer.shadowOffset = CGSize(width: 0, height: 3)
        barraTitulo.layer.shadowOpacity = 0.6
        barraTitulo.layer.shadowRadius = 3.0
        barraTitulo.layer.shadowColor = UIColor(rgba:"#000000").cgColor
        barraTitulo.addSubview(crearGradiente(vista: barraTitulo))
        
        let titulo:UIButton = UIButton()
        let anchoTitulo = barraTitulo.frame.width * 0.75
        titulo.frame = CGRect(x: (barraTitulo.frame.width * 0.5) - (anchoTitulo * 0.5), y: 0, width: anchoTitulo, height: barraTitulo.frame.height)
        titulo.setTitle(tituloTexto, for: .normal)
        titulo.titleLabel?.font = UIFont(name: fontFamiliaBold, size: tamanoLetraTitulo)
        titulo.setTitleColor(UIColor(rgba:"#FFFFFF"), for: .normal)
        titulo.contentMode = .scaleAspectFit
        titulo.contentVerticalAlignment = .center
        titulo.contentHorizontalAlignment = .center
        barraTitulo.addSubview(titulo)
        
        let botonMenu:UIButton = UIButton()
        botonMenu.tag = -3
        botonMenu.frame = CGRect(x: 0, y: 0, width: barraTitulo.frame.width * 0.15, height: barraTitulo.frame.height)
        
        if (tipo != nil){
            if tipo! == 2 {
                titulo.removeFromSuperview()
                
                let fondoblanco: UIView = UIView()
                fondoblanco.frame = CGRect(x: barraTitulo.frame.width * 0.025, y: barraTitulo.frame.height * 0.13, width: barraTitulo.frame.width * 0.7, height: barraTitulo.frame.height * 0.73)
                fondoblanco.backgroundColor = UIColor(rgba:"#FFFFFF")
                fondoblanco.layer.cornerRadius = 5
                fondoblanco.tag = -5
                
                let campoBuscador:UITextField = UITextField()
                campoBuscador.tag = -5
                campoBuscador.frame = CGRect(x: fondoblanco.frame.origin.x + fondoblanco.frame.width * 0.08, y: fondoblanco.frame.origin.y + fondoblanco.frame.height * 0.055, width: fondoblanco.frame.width - fondoblanco.frame.width * 0.11, height: fondoblanco.frame.height * 0.73)
                campoBuscador.borderStyle = .none
                campoBuscador.returnKeyType = .search
                campoBuscador.autocapitalizationType = .none
                campoBuscador.attributedPlaceholder = NSAttributedString(string: "Buscar", attributes: [NSAttributedStringKey.foregroundColor: UIColor(rgba: "#6f757a"), NSAttributedStringKey.font: UIFont(name: fontFamilia, size: tamanoLetra) as Any])
                //campoBuscador.placeholder = "Buscar"
                
                let imagenLupa: UIButton = UIButton()
                imagenLupa.frame = CGRect(x: fondoblanco.frame.origin.x - fondoblanco.frame.width * 0.02, y: fondoblanco.frame.origin.y, width: fondoblanco.frame.width * 0.09, height: fondoblanco.frame.height * 0.65)
                imagenLupa.contentMode = .scaleAspectFit
                imagenLupa.setImage(UIImage(named:"search")?.resize2(targetSize: CGSize(width: 14, height: 14)), for: .normal)
                imagenLupa.contentHorizontalAlignment = .fill
                imagenLupa.contentVerticalAlignment = .fill
                //logoTelmex.titleEdgeInsets = UIEdgeInsets(top: anchoLogo * 0.75, left: 0, bottom: 0, right: 0)
                imagenLupa.isUserInteractionEnabled = false
                imagenLupa.tag = -6
                
                fondoblanco.addSubview(campoBuscador)
                fondoblanco.addSubview(imagenLupa)
                barraTitulo.addSubview(fondoblanco)
                
                // boton cancelar
                botonMenu.frame = CGRect(x: campoBuscador.frame.origin.x + vista.frame.width * 0.67, y: campoBuscador.frame.origin.y, width: fondoblanco.frame.width * 0.33, height: fondoblanco.frame.height)
                botonMenu.setTitle("Cancelar", for: .normal)
                botonMenu.titleLabel?.font = UIFont(name: fontFamilia, size: tamanoLetraTitulo - 2)
                botonMenu.setTitleColor(UIColor.white, for: .normal)
                botonMenu.contentHorizontalAlignment = .right
                botonMenu.contentVerticalAlignment = .center
            }
            else{
                let auxImagen = UIImage(named:"regresar")!
                
                botonMenu.setImage(auxImagen.resize2(targetSize: CGSize(width: 16, height: 20)), for: .normal)
                botonMenu.tag = BOTON_ATRAS
            }
        }
        else{
            
            let auxImagen = UIImage(named:"menu")!
            
            botonMenu.setImage(auxImagen.resize2(targetSize: CGSize(width: 28, height: 28)), for: .normal)
            botonMenu.addTarget(SWRevealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControlEvents.touchDown)
        }
        
        botonMenu.contentMode = .scaleAspectFill
        botonMenu.contentVerticalAlignment = .center
        botonMenu.contentHorizontalAlignment = .center
        
        barraTitulo.addSubview(botonMenu)
        
        let botonBusqueda:UIButton = UIButton()
        botonBusqueda.tag = -4
        
        botonBusqueda.frame = CGRect(x: barraTitulo.frame.width * 0.85, y: 0, width: barraTitulo.frame.width * 0.15, height: barraTitulo.frame.height)
        botonBusqueda.contentMode = .scaleAspectFill
        botonBusqueda.contentVerticalAlignment = .center
        botonBusqueda.contentHorizontalAlignment = .center
        botonBusqueda.clipsToBounds = true
        
        let auxImagen = UIImage(named:"search")!
        botonBusqueda.setImage(auxImagen.resize2(targetSize: CGSize(width: 21, height: 21)), for: .normal)
        //botonBusqueda.addTarget(self, action:#selector(iraBuscar), for: .touchUpInside)
        barraTitulo.addSubview(botonBusqueda)
        
        if(tipo == 3){
            botonBusqueda.removeFromSuperview()
            botonMenu.removeFromSuperview()
        }
        
        if tipo == 2{
            botonBusqueda.removeFromSuperview()
        }
        
        return barraTitulo
    }
    
    @objc func iraBuscar(){
        //eventoAnalytics(id: "\(String(describing: defaults.object(forKey: "expedienteUsuario") as! String))", nombre: "Buscador", contentType: "metricas")
        
        siguienteController = BuscadorController()
        moverPantalla()
    }
    
    func crearGradiente(vista: UIView) -> UIView{
        let gradienteBg: UIView = UIView()
        gradienteBg.frame = CGRect(x: 0, y: 0, width: vista.frame.width, height: vista.frame.height)
        gradienteBg.tag = GRADIENTE
        
        let gradient:CAGradientLayer = CAGradientLayer()
        let colorTop = UIColor(red: 0.0, green: 110.0 / 255.0, blue: 249.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 0.0, green: 110.0 / 255.0, blue: 249.0 / 255.0, alpha: 0.6).cgColor
        gradient.colors = [colorTop, colorBottom]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = gradienteBg.bounds
        //gradient.cornerRadius = 5
        gradienteBg.layer.addSublayer(gradient)
        
        return gradienteBg
    }
    
    
}



























//
//  Cargador.swift
//  TelmexConmigo
//
//  Created by Jair Moreno Gaspar on 28/03/18.
//  Copyright © 2018 Mac Hitss. All rights reserved.
//

import Foundation

class CargadorPrincipal: UIView {
    

    var urlDescarga: String = String()
    
    
    
    //MARK: Loading
    func cargadorLoading(vista: UIView) {
        
         DispatchQueue.main.async {
            //Loading
            let fondo:UIView = UIView()
            let marco:UIView = UIView()
            var vistaloading: UIImageView = UIImageView()
            let vistaCargador:UIScrollView = UIScrollView()
            
            //Controlador actual
            let controladorActual = UIApplication.topViewController()
            
            vistaCargador.frame = vista.frame
            vistaCargador.backgroundColor = UIColor.clear
            
            fondo.frame = vista.frame
            fondo.backgroundColor = UIColor(rgba:"#000000")
            fondo.alpha = 0.5
            
            marco.frame = CGRect(x: vista.frame.width * 0.1, y: vista.frame.height * 0.3, width: vista.frame.width * 0.8, height: vista.frame.height * 0.30)
            marco.layer.cornerRadius = 0
            marco.backgroundColor = UIColor.white
            marco.isHidden = true
            
            vistaloading = self.loading(vistaPadre: vista)
            
            vistaCargador.addSubview(fondo)
            vistaCargador.addSubview(marco)
            vistaCargador.addSubview(vistaloading)
            vistaloading.startAnimating()
            vistaCargador.tag = 179
            
            //return vistaCargador
           
                controladorActual?.view!.addSubview(vistaCargador)
                controladorActual?.view!.bringSubview(toFront: vistaCargador)
        }
        
        
    }
    
    //MARK: Alerta Servicios
    func cargadorAlerta(vista: UIView, texto: String) {
        
        DispatchQueue.main.async {
            //Alerta 1 Servicios
            let imagenAlerta:UIImageView = UIImageView()
            let textoAlerta: UIButton = UIButton()
            let botonCerrar: UIButton = UIButton()
            
            //Loading
            let fondo:UIView = UIView()
            let marco:UIView = UIView()
            let vistaCargador:UIScrollView = UIScrollView()
            
            //Controlador actual
            let controladorActual = UIApplication.topViewController()
            
            vistaCargador.frame = vista.frame
            vistaCargador.backgroundColor = UIColor.clear
            
            fondo.frame = vista.frame
            fondo.backgroundColor = UIColor(rgba:"#000000")
            fondo.alpha = 0.5
            
            marco.frame = CGRect(x: vista.frame.width * 0.1, y: vista.frame.height * 0.3, width: vista.frame.width * 0.8, height: vista.frame.height * 0.30)
            marco.layer.cornerRadius = 0
            marco.backgroundColor = UIColor.white
            
            imagenAlerta.frame = CGRect(x: marco.frame.origin.x + marco.frame.width * 0.35, y: marco.frame.origin.y + marco.frame.height * 0.05, width: marco.frame.width * 0.3, height: marco.frame.width * 0.3)
            imagenAlerta.contentMode = .center
            imagenAlerta.image = UIImage(named:"alerta")
            
            textoAlerta.frame = CGRect(x: marco.frame.origin.x + marco.frame.width * 0.05, y: imagenAlerta.frame.origin.y + imagenAlerta.frame.height + marco.frame.height * 0.05, width: marco.frame.width * 0.9, height: marco.frame.width * 0.3)
            textoAlerta.setTitle(texto, for: .normal)
            textoAlerta.titleLabel?.font = UIFont(name: fontFamilia, size: tamanoLetra)
            textoAlerta.titleLabel?.textAlignment = .center
            textoAlerta.titleLabel?.numberOfLines = 2
            textoAlerta.contentHorizontalAlignment = .center
            textoAlerta.contentVerticalAlignment = .top
            textoAlerta.setTitleColor(UIColor.black, for: .normal)
            textoAlerta.isUserInteractionEnabled = false
            
            botonCerrar.frame = CGRect(x: marco.frame.origin.x, y: marco.frame.origin.y + marco.frame.height - marco.frame.height * 0.15, width: marco.frame.width, height: marco.frame.width * 0.15)
            botonCerrar.setTitle("CERRAR", for: .normal)
            botonCerrar.titleLabel?.font = UIFont(name: fontFamiliaBold, size: tamanoLetra)
            botonCerrar.titleLabel?.textAlignment = .justified
            botonCerrar.titleLabel?.numberOfLines = 0
            botonCerrar.contentHorizontalAlignment = .center
            botonCerrar.contentVerticalAlignment = .center
            botonCerrar.setTitleColor(UIColor.black, for: .normal)
            botonCerrar.backgroundColor = UIColor(rgba:"#F9F9FB")
            let path = UIBezierPath(roundedRect:botonCerrar.bounds,
                                    byRoundingCorners:[.bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: 0, height:  0))
            
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            botonCerrar.layer.mask = maskLayer
            botonCerrar.addTarget(self, action: #selector(self.ocultarCargador), for: .touchUpInside)
            
            vistaCargador.addSubview(fondo)
            vistaCargador.addSubview(marco)
            vistaCargador.addSubview(imagenAlerta)
            vistaCargador.addSubview(textoAlerta)
            vistaCargador.addSubview(botonCerrar)
            vistaCargador.tag = 179
            
            //return vistaCargador
            
                controladorActual?.view!.addSubview(vistaCargador)
                controladorActual?.view!.bringSubview(toFront: vistaCargador)
        }
    }
    
    //MARK: Alerta 2 botones
    func cargadorConBotones(vista: UIView, texto: String, textoBoton1: String, textoBoton2: String){
        
        DispatchQueue.main.async {
            //Loading
            let fondo:UIView = UIView()
            let marco:UIView = UIView()
            let vistaCargador:UIScrollView = UIScrollView()
            
            //Alerta 1 Servicios
            let imagenAlerta:UIImageView = UIImageView()
            let textoAlerta: UIButton = UIButton()
            
            //Alerta 2 Botones
            let boton1: UIButton = UIButton()
            let boton2: UIButton = UIButton()
            
            //Controlador actual
            let controladorActual = UIApplication.topViewController()
            
            vistaCargador.frame = vista.frame
            vistaCargador.backgroundColor = UIColor.clear
            
            fondo.frame = vista.frame
            fondo.backgroundColor = UIColor(rgba:"#000000")
            fondo.alpha = 0.5
            
            marco.frame = CGRect(x: vista.frame.width * 0.1, y: vista.frame.height * 0.3, width: vista.frame.width * 0.8, height: vista.frame.height * 0.30)
            marco.layer.cornerRadius = 0
            marco.backgroundColor = UIColor.white
            
            imagenAlerta.frame = CGRect(x: marco.frame.origin.x + marco.frame.width * 0.35, y: marco.frame.origin.y + marco.frame.height * 0.05, width: marco.frame.width * 0.3, height: marco.frame.width * 0.3)
            imagenAlerta.contentMode = .center
            imagenAlerta.image = UIImage(named:"actualizar")
            
            textoAlerta.frame = CGRect(x: marco.frame.origin.x + marco.frame.width * 0.05, y: imagenAlerta.frame.origin.y + imagenAlerta.frame.height + marco.frame.height * 0.05, width: marco.frame.width * 0.9, height: marco.frame.width * 0.3)
            textoAlerta.setTitle(texto, for: .normal)
            textoAlerta.titleLabel?.font = UIFont(name: fontFamilia, size: tamanoLetra)
            textoAlerta.titleLabel?.textAlignment = .justified
            textoAlerta.titleLabel?.numberOfLines = 0
            textoAlerta.contentHorizontalAlignment = .center
            textoAlerta.contentVerticalAlignment = .center
            textoAlerta.setTitleColor(UIColor.black, for: .normal)
            textoAlerta.isUserInteractionEnabled = false
            
            
            
            boton1.frame = CGRect(x: marco.frame.origin.x, y: marco.frame.origin.y + marco.frame.height - marco.frame.height * 0.15, width: marco.frame.width, height: marco.frame.width * 0.15)
            boton1.setTitle(textoBoton1, for: .normal)
            boton1.titleLabel?.font = UIFont(name: fontFamiliaBold, size: tamanoLetra)
            boton1.titleLabel?.textAlignment = .justified
            boton1.titleLabel?.numberOfLines = 0
            //boton1.layer.addBorder(edge: UIRectEdge.right, color: UIColor.lightGray, thickness: 0.5, x: boton1.frame.width, width: boton1.frame.width)
            boton1.contentHorizontalAlignment = .center
            boton1.contentVerticalAlignment = .center
            boton1.setTitleColor(UIColor.white, for: .normal)
            boton1.backgroundColor = colorRojoBotones
            let path = UIBezierPath(roundedRect:boton1.bounds,
                                    byRoundingCorners:[.bottomLeft],
                                    cornerRadii: CGSize(width: 0, height:  0))
            
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            boton1.layer.mask = maskLayer
            boton1.addTarget(self, action: #selector(self.descargarApp), for: .touchUpInside)
            
            boton2.frame = CGRect(x: marco.frame.origin.x + marco.frame.width * 0.5, y: marco.frame.origin.y + marco.frame.height - marco.frame.height * 0.15, width: marco.frame.width * 0.5, height: marco.frame.width * 0.15)
            boton2.setTitle(textoBoton2, for: .normal)
            boton2.titleLabel?.font = UIFont(name: fontFamilia, size: tamanoLetra)
            boton2.titleLabel?.textAlignment = .justified
            boton2.titleLabel?.numberOfLines = 0
            boton2.contentHorizontalAlignment = .center
            boton2.contentVerticalAlignment = .center
            boton2.setTitleColor(UIColor.black, for: .normal)
            boton2.backgroundColor = UIColor(rgba:"#F9F9FB")
            let path2 = UIBezierPath(roundedRect:boton2.bounds,
                                     byRoundingCorners:[.bottomRight],
                                     cornerRadii: CGSize(width: 0, height:  0))
            
            let maskLayer2 = CAShapeLayer()
            maskLayer2.path = path2.cgPath
            boton2.layer.mask = maskLayer2
            boton2.addTarget(self, action: #selector(self.ocultarCargador), for: .touchUpInside)
            
            vistaCargador.addSubview(fondo)
            vistaCargador.addSubview(marco)
            vistaCargador.addSubview(imagenAlerta)
            vistaCargador.addSubview(textoAlerta)
            vistaCargador.addSubview(boton1)
            vistaCargador.tag = 179
            //vistaCargador.addSubview(boton2)
            
            //return vistaCargador
            //return vistaCargador
            
                controladorActual?.view!.addSubview(vistaCargador)
                controladorActual?.view!.bringSubview(toFront: vistaCargador)
        }
    }
    
    @objc func ocultarCargador() {
        
        /*DispatchQueue.main.async {
            self.vistaCargador.removeFromSuperview()
        }*/
        
        let controladorActual = UIApplication.topViewController()
        
        DispatchQueue.main.async {
            
            let subvistas = controladorActual?.view!.subviews
            
            for subvista in subvistas! where subvista.tag == 179 {
                
                subvista.removeFromSuperview()
                
            }
            
        }
        
    }
    
    
    @objc func descargarApp(){
        guard let url = URL(string: self.urlDescarga) else {
            self.ocultarCargador()
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        self.ocultarCargador()
    }
    
    func loading(vistaPadre: UIView) -> UIImageView{
        var carreteImagenes: [UIImage] = []
        for i in 0..<18 {
            carreteImagenes.append((UIImage(named: "loader\(i)"))!)
        }
        
        let uiImageView: UIImageView = UIImageView(frame: CGRect(x: vistaPadre.frame.width * 0.5 - ((vistaPadre.frame.width * 0.25) / 2), y: vistaPadre.frame.height * 0.5 - ((vistaPadre.frame.height * 0.2) / 2 ), width: vistaPadre.frame.width * 0.25, height: vistaPadre.frame.height * 0.2))
        uiImageView.contentMode = .scaleAspectFill
        uiImageView.animationImages = carreteImagenes
        uiImageView.animationDuration = 1
        
        return uiImageView
    }
    
}


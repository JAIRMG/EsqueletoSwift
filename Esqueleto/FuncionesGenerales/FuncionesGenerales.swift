//
//  FuncionesGenerales.swift
//  TelmexConmigo
//
//  Created by Mac Hitss on 1/31/18.
//  Copyright © 2018 Mac Hitss. All rights reserved.
//

import Foundation
import FirebaseAnalytics

let fontFamilia = "HelveticaNeueLTStd-Lt"
let fontFamiliaBold = "HelveticaNeueLTStd-Bd"
let fontNew = "HelveticaNeue"

var factorAumentoTexto: CGFloat = 0.0
var tamanoStandardConf: CGFloat = 16
var tamanoLetra:CGFloat = 16
var tamanoLetraTitulo:CGFloat = 20
var tamanoLetraSuperTitulo:CGFloat = 30

var vistaCargador:UIScrollView = UIScrollView()

var seccionActual = 1

var ultimoController:Any?
var siguienteController:Any?

var accionesMenu:menuAcciones = menuAcciones()

var noticiasDetalle: NoticiasDetalle = NoticiasDetalle()

//var manejadorDeErrores: ManejadorDeErrores = ManejadorDeErrores()

let setTimeOutRequest = 59.0
let setTimeOutResource = 59.0

var retardoParaServicios = 300000000 //5 minutos
var sidCGRect: CGRect!

var noticiasArregloGeneral:[[String:AnyObject]] = [[:]]
var bannerRelevanciaGeneral: [String:AnyObject] = [:]

let menuSuperior: MenuSuperior = MenuSuperior()
let menuInferior: MenuInferior = MenuInferior()
let cargadorPrincipal: CargadorPrincipal = CargadorPrincipal()
var primeraVez: Bool = true

var imagenesNoticiasYaCargadas: [Int:AnyObject] = [:]

////// Variables
var colorAzulGeneral       = UIColor(rgba: "#006EF9")
var colorGrisAlertaBg      = UIColor(rgba: "#E2E2E2")
var azulBarraCargador      = UIColor(rgba: "#008ECE")
var colorGrisBgCollections = UIColor(rgba: "#F9F9FB")
var colorGrisVistaTerminos = UIColor(rgba: "#444444")
var colorRojoBotones       = UIColor(rgba: "#FF2B13")
var colorAzulVistaAyuda    = UIColor(rgba: "#019EE1")
var colorGrisBgImagen      = UIColor(rgba: "#CCCCCC")
var colorAzulFechaNoticias = UIColor(rgba: "#109BC9")
var colorGrisLineaCeldas   = UIColor(rgba: "#E1E2E3")
var colorAzulLineaCeldas   = UIColor(rgba: "#C4DFF6")
var colorGrisSubtWifi      = UIColor(rgba: "#AAAAAA")
var colorAzulDistanciaWifi = UIColor(rgba: "#00A2E3")
var colorGrisLineaWifi     = UIColor(rgba: "#E6E7E8")
var colorAzulTituloFAQ     = UIColor(rgba: "#0279FF")
var colorGrisTextoFAQ      = UIColor(rgba: "#707070")
var colorFondoVista        = UIColor(rgba: "#006DF9")
var colorGrisFechaNoticia  = UIColor(rgba: "#9D9D9D")

//self.performSegue(withIdentifier: "logintoinicio", sender: self)var videoPlayer: VideoPlayerView = VideoPlayerView()


//Variables Servicios
var servicioStatusTerminos      = "https://app-pre.telmex.com/TelmexConmigoWS/statusTermsExpediente"
var servicioObtenerPerfil       = "https://app-pre.telmex.com/TelmexConmigoWS/getProfile"
var servicioAceptarTerminos     = "https://app-pre.telmex.com/TelmexConmigoWS/acceptTermsExpediente"
var servicioValidarSID          = "https://app-pre.telmex.com/TelmexConmigoWS/validarSID"
var servicioObtenerTerminos     = "https://app-pre.telmex.com/TelmexConmigoWS/searchText"
var servicioObtenerVersion      = "https://app-pre.telmex.com/TelmexConmigoWS/version"
var servicioObtenerNoticias     = "https://app-pre.telmex.com/TelmexConmigoWS/getNoticiasAsync"
var servicioObtenerCategoria    = "https://app-pre.telmex.com/AgendaWeb/webresources/entities.categoria?"
var servicioTituloCategoria     = "https://app-pre.telmex.com/AgendaWeb/webresources/entities.agenda/titulos/"
var servicioCriterioCategoria   = "https://app-pre.telmex.com/AgendaWeb/webresources/entities.agenda/criterios"
var servicioPuntosWifi          = "https://app.telmex.com/api/telmex-zones/find"
var servicioBuscarActualizacion = "https://app-pre.telmex.com/TelmexConmigoWS/findUpdate"
var servicioNoticiasSID        = "https://app-pre.telmex.com/TelmexConmigoWS/obtenerNotasSID"
var servicioBuscador            = "https://app-pre.telmex.com/TelmexConmigoWS/searchAsync"
var servicioObtenerImagen       = "https://app-pre.telmex.com/TelmexConmigoWS/getImage?path="

func identificadorDeDispositivo(vista: UIView){
    noticiasArregloGeneral.removeAll()
    bannerRelevanciaGeneral.removeAll()
    
    if DeviceType.IS_IPHONE{
        if DeviceType.IS_IPHONE_5{ // iPhone5s, iPhoneSE
            factorAumentoTexto = -4
            sidCGRect = CGRect(x: vista.frame.width * 0.75, y: vista.frame.height * 0.75, width: vista.frame.width * 0.2, height: vista.frame.width * 0.2)
        }
        else if DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P || DeviceType.IS_IPHONE_7 || DeviceType.IS_IPHONE_7P || DeviceType.IS_IPHONE_X{ /// iPhone8 y iPhone8p
            print("iphone 6, 7, 8")
            factorAumentoTexto = 0
            sidCGRect = CGRect(x: vista.frame.width * 0.75, y: vista.frame.height * 0.75, width: vista.frame.width * 0.2, height: vista.frame.width * 0.2)
        }
    }
    else if DeviceType.IS_IPAD || DeviceType.IS_IPAD_PRO_9_7{
        print("ipad")
        factorAumentoTexto = 4
        sidCGRect = CGRect(x: vista.frame.width * 0.8, y: vista.frame.height * 0.75, width: vista.frame.width * 0.15, height: vista.frame.width * 0.15)
    }
    else if DeviceType.IS_IPAD_PRO_12_9{
        factorAumentoTexto = 8
        sidCGRect = CGRect(x: vista.frame.width * 0.85, y: vista.frame.height * 0.8, width: vista.frame.width * 0.1, height: vista.frame.width * 0.1)
    }
    
}

func reInitTamanos(){
    tamanoStandardConf = 16
    tamanoLetra = 16
    tamanoLetraTitulo = 20
    tamanoLetraSuperTitulo = 30
    primeraVez = true
}

func moverPantalla(){
    
    let controlador = UIApplication.topViewController()
    
    (controlador as! SWRevealViewController).setFront(siguienteController as! UIViewController, animated: true)
    
}

func regresarPantalla(controlador:UIViewController){
    
    controlador.revealViewController().setFront(ultimoController as! UIViewController, animated: true)
    
}

class menuAcciones:UIViewController {
    
    @objc func mover(boton:UIButton){
        
        
        
        switch boton.tag {
        case 1:
            siguienteController = InicioController()
            print("")
        case 2:
            siguienteController = LoNuestroController()
            print("")
        case 3:
            siguienteController = ServiciosController()
            print("")
        case 4:
            //siguienteController = CorreoController()
            print("")
        case 5:
            siguienteController = WifiController()
            print("")
        default:
            break
        }
        
        
        
        moverPantalla()
        
    }
    
    @objc func iraBuscar(){
        
        eventoAnalytics(id: "\(String(describing: defaults.object(forKey: "expedienteUsuario") as! String))", nombre: "Buscador", contentType: "metricas")
        
        //siguienteController = BuscadorController()
        
        moverPantalla()
        
    }
    
    @objc func ocultarCargadorB(){
        
        let controladorActual = UIApplication.topViewController()
        
        let subvistas = controladorActual?.view!.subviews
        
        for subvista in subvistas! where subvista.tag == 179 {
            
            DispatchQueue.main.async {
                
                subvista.removeFromSuperview()
                
            }
            
        }
    }
    
}

func mostrarCargador()->UIButton{
    
    let controladorActual = UIApplication.topViewController()
    
    print(controladorActual as Any)
    
    let subvistas = vistaCargador.subviews
    
    for subvista in subvistas {
        
        subvista.removeFromSuperview()
        
    }
    
    vistaCargador.tag = 179
    
    vistaCargador.frame = (controladorActual?.view!.frame)!
    
    vistaCargador.backgroundColor = UIColor.clear
    
    let malla:UIView = UIView()
    
    malla.frame = vistaCargador.frame
    
    malla.backgroundColor = UIColor(rgba:"#000000")
    
    malla.alpha = 0.5
    
    vistaCargador.addSubview(malla)
    
    /*let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
     let blurEffectView = UIVisualEffectView(effect: blurEffect)
     blurEffectView.frame = vistaCargador.bounds
     blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
     vistaCargador.addSubview(blurEffectView)*/
    
    let auxColor:UIColor = UIColor(rgba: "#000000")
    
    let marco:UIView = UIView()
    
    marco.tag = -12
    
    marco.frame = CGRect(x: vistaCargador.frame.width * 0.2, y: vistaCargador.frame.height * 0.3, width: vistaCargador.frame.width * 0.6, height: vistaCargador.frame.height * 0.25)
    
    marco.backgroundColor = UIColor(rgba:"#FFFFFF")
    
    marco.layer.cornerRadius = 10
    
    vistaCargador.addSubview(marco)
    marco.isHidden = true
    
    let tituloIzquierdo:UIButton = UIButton()
    
    tituloIzquierdo.frame = CGRect(x: marco.frame.origin.x, y: marco.frame.origin.y, width: marco.frame.width, height: marco.frame.height * 0.1)
    
    tituloIzquierdo.setTitle("CARGANDO", for: .normal)
    
    tituloIzquierdo.setTitleColor(UIColor(rgba:"#ae435a"), for: .normal)
    
    tituloIzquierdo.titleLabel?.font = UIFont(name: fontFamiliaBold, size: 10)
    
    tituloIzquierdo.titleEdgeInsets = UIEdgeInsets(top: 0, left: tituloIzquierdo.frame.width * 0.05, bottom: 0, right: 0)
    
    tituloIzquierdo.contentHorizontalAlignment = .left
    tituloIzquierdo.contentVerticalAlignment = .center
    
    //vistaCargador.addSubview(tituloIzquierdo)
    
    
    
    //let vistaLoading = NVActivityIndicatorView(frame: CGRect(x: vistaCargador.frame.width * 0.38, y: vistaCargador.frame.height * 0.3, width: vistaCargador.frame.width * 0.25, height: vistaCargador.frame.height * 0.2),color:auxColor)
    let vistaloading = loading()
    vistaloading.tag = -34
    
    //vistaloading.type = .ballSpinFadeLoader
    
    vistaCargador.addSubview(vistaloading)
    
    DispatchQueue.main.async {
        controladorActual?.view!.addSubview(vistaCargador)
        controladorActual?.view!.bringSubview(toFront: vistaCargador)
    }
    
    vistaloading.startAnimating()
    
    let textoCargador:UIButton = UIButton()
    
    textoCargador.frame = CGRect(x: marco.frame.origin.x, y:marco.frame.origin.y + marco.frame.height*0.25, width: marco.frame.width,  height: marco.frame.height*0.6)
    
    textoCargador.setTitle("", for: .normal)
    textoCargador.setTitleColor(auxColor, for: .normal)
    
    textoCargador.setAttributedTitle(nil, for: UIControlState())
    
    textoCargador.titleLabel!.font = UIFont(name: fontFamilia, size: CGFloat(3))
    
    textoCargador.titleLabel!.font = textoCargador.titleLabel!.font.withSize(CGFloat(tamanoLetra))
    
    textoCargador.titleEdgeInsets = UIEdgeInsets(top: 0, left: marco.frame.width * 0.1, bottom: 0, right: marco.frame.width * 0.1)
    
    textoCargador.isSelected = false
    
    textoCargador.tag = -1
    
    //textoCargador.backgroundColor = UIColor.cyan
    
    
    textoCargador.titleLabel!.textColor = auxColor
    textoCargador.titleLabel!.numberOfLines = 0
    textoCargador.titleLabel!.textAlignment = .center
    textoCargador.contentVerticalAlignment = .center
    
    vistaCargador.addSubview(textoCargador)
    
    let botonCerrar:UIButton = UIButton()
    
    botonCerrar.backgroundColor = colorGrisAlertaBg
    
    botonCerrar.frame = CGRect(x: marco.frame.origin.x, y: marco.frame.origin.y + marco.frame.height * 0.9, width: marco.frame.width, height: marco.frame.height * 0.2)
    
    botonCerrar.setTitleColor(UIColor.black, for: .normal)
    
    botonCerrar.setTitle("CERRAR", for: .normal)
    
    botonCerrar.titleLabel?.font = UIFont(name: fontFamiliaBold, size: 16)
    
    botonCerrar.contentVerticalAlignment = .center
    botonCerrar.contentHorizontalAlignment = .center
    
    botonCerrar.tag = -2
    botonCerrar.isHidden = true
    
    botonCerrar.addTarget(accionesMenu, action: #selector(accionesMenu.ocultarCargadorB), for: .touchUpInside)
    
    let path = UIBezierPath(roundedRect:botonCerrar.bounds,
                            byRoundingCorners:[.bottomLeft, .bottomRight],
                            cornerRadii: CGSize(width: 10, height:  10))
    
    let maskLayer = CAShapeLayer()
    
    maskLayer.path = path.cgPath
    botonCerrar.layer.mask = maskLayer
    
    botonCerrar.isUserInteractionEnabled = false
    
    vistaCargador.addSubview(botonCerrar)
    
    vistaCargador.bringSubview(toFront: botonCerrar)
    
    return botonCerrar
    
    
}

func actualizarTextoCargador(textoNuevo:String,activar:Bool,tipo:Int?=nil) {
    
    //actualizar texto cargador
    
    let controladorActual = UIApplication.topViewController()
    
    DispatchQueue.main.async {
        
        
        
        let subvistas = controladorActual?.view!.subviews
        
        for subvista in subvistas! where subvista.tag == 179 {
            
            
            let subvistasCargador = subvista.subviews
            
            for subvistaCargador in subvistasCargador where subvistaCargador is UIButton {
                
                switch subvistaCargador.tag{
                    
                case -1:
                    
                    var marco:UIView!
                    
                    for vistaMarco in subvistasCargador where vistaMarco.tag == -12 {
                        
                        vistaMarco.frame = CGRect(x: vistaMarco.superview!.frame.width * 0.1, y: vistaMarco.superview!.frame.height * 0.3, width: vistaMarco.superview!.frame.width * 0.8, height: vistaMarco.superview!.frame.height * 0.4)
                        
                        marco = vistaMarco
                        
                    }
                    
                    (subvistaCargador as! UIButton).setTitle(textoNuevo, for: .normal)
                    
                    if activar {
                        
                        (subvistaCargador as! UIButton).frame = CGRect(x: marco.frame.origin.x, y:marco.frame.origin.y + marco.frame.height*0.28, width: marco.frame.width, height: marco.frame.height*0.4)
                        
                    }
                    
                case -2:
                    
                    if activar {
                        
                        var marco:UIView!
                        
                        for vistaMarco in subvistasCargador where vistaMarco.tag == -12 {
                            
                            vistaMarco.frame = CGRect(x: vistaMarco.superview!.frame.width * 0.1, y: vistaMarco.superview!.frame.height * 0.3, width: vistaMarco.superview!.frame.width * 0.8, height: vistaMarco.superview!.frame.height * 0.3)
                            
                            marco = vistaMarco
                            marco.isHidden = false
                            
                        }
                        
                        (subvistaCargador as! UIButton).isUserInteractionEnabled = true
                        (subvistaCargador as! UIButton).frame = CGRect(x: marco.frame.origin.x, y: marco.frame.origin.y + marco.frame.height * 0.9, width: marco.frame.width, height: marco.frame.height * 0.2)
                        let path = UIBezierPath(roundedRect:subvistaCargador.bounds,
                                                byRoundingCorners:[.bottomLeft, .bottomRight],
                                                cornerRadii: CGSize(width: 10, height:  10))
                        
                        let maskLayer = CAShapeLayer()
                        
                        maskLayer.path = path.cgPath
                        subvistaCargador.layer.mask = maskLayer
                        subvistaCargador.backgroundColor = colorGrisAlertaBg
                        (subvistaCargador as! UIButton).setTitleColor(UIColor(rgba:"#000000"), for: .normal)
                        subvistaCargador.isHidden = false
                    }
                    
                default:
                    break
                    
                }
                
            }
            
            for subvistaCargador in subvistasCargador where subvistaCargador is UIImageView {
                
                if activar {
                    
                    subvistaCargador.isHidden = true
                    
                    let palomaverde:UIImageView = UIImageView()
                    
                    palomaverde.frame = CGRect(x: subvistaCargador.superview!.frame.width * 0.31, y: subvistaCargador.superview!.frame.height * 0.20, width: subvistaCargador.superview!.frame.width * 0.4, height: subvistaCargador.superview!.frame.height * 0.4)
                    
                    palomaverde.contentMode = .center
                    
                    
                    palomaverde.image = UIImage(named:"iconoPalomaVerde")
                    
                    if tipo != nil {
                        
                        palomaverde.image = UIImage(named:"alerta")//?.resize2(targetSize: CGSize(width: palomaverde.frame.width * 0.1, height: palomaverde.frame.width * 0.1))
                        
                    }
                    
                    
                    
                    
                    subvistaCargador.superview?.addSubview(palomaverde)
                }
            }
            
            
        }
        
    }
    
    //fin actualizar texto cargador
    
    
}

func pintarFlecha(celda: UICollectionViewCell, nombreFlecha: String, topEdgeInsets: CGFloat) -> UIButton {
    let flecha:UIButton = UIButton()
    
    flecha.frame = CGRect(x: celda.frame.width * 0.9, y: 0, width: celda.frame.width * 0.05, height: celda.frame.width * 0.055)
    flecha.setImage(UIImage(named: nombreFlecha), for: .normal)
    flecha.contentMode = .scaleAspectFill
    flecha.alpha = 1
    flecha.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    if nombreFlecha == "acordeon_abierto"{
        flecha.frame.origin.y = celda.frame.height * topEdgeInsets - flecha.frame.height * 0.5
    }
    else{
        flecha.frame.origin.y = celda.frame.height * 0.5 - flecha.frame.height * 0.5
    }
    
    return flecha
}


func pintarBotonCerrar(webView: UIWebView) -> UIButton {
    
    let botonCerrarWebView: UIButton = UIButton()
    botonCerrarWebView.frame = CGRect(x: webView.frame.width * 0.04, y: webView.frame.height * 0.92, width: webView.frame.width * 0.1, height: webView.frame.height * 0.05)
    botonCerrarWebView.backgroundColor = UIColor(rgba:"#009bdc")
    botonCerrarWebView.setTitle("X", for: .normal)
    botonCerrarWebView.titleLabel?.font = UIFont(name: fontFamiliaBold, size: tamanoLetra)
    botonCerrarWebView.contentHorizontalAlignment = .center
    botonCerrarWebView.contentVerticalAlignment = .center
    botonCerrarWebView.layer.shadowOffset = CGSize(width: 0, height: 3)
    botonCerrarWebView.layer.shadowOpacity = 0.6
    botonCerrarWebView.layer.shadowRadius = 3.0
    botonCerrarWebView.layer.cornerRadius = 7.0
    botonCerrarWebView.layer.shadowColor = UIColor(rgba:"#000000").cgColor
    return botonCerrarWebView
}

func loading() -> UIImageView{
    var carreteImagenes: [UIImage] = []
    for i in 0..<18 {
        carreteImagenes.append((UIImage(named: "loader\(i)"))!)
    }
    
    let uiImageView: UIImageView = UIImageView(frame: CGRect(x: vistaCargador.frame.width * 0.5 - ((vistaCargador.frame.width * 0.25) / 2), y: vistaCargador.frame.height * 0.5 - ((vistaCargador.frame.height * 0.2) / 2 ), width: vistaCargador.frame.width * 0.25, height: vistaCargador.frame.height * 0.2))
    uiImageView.contentMode = .scaleAspectFill
    uiImageView.animationImages = carreteImagenes
    uiImageView.animationDuration = 1
    //uiImageView.startAnimating()
    
    return uiImageView
}

class botonResultado:UIButton {
    
    var seccion:Int?
    
    
}

func eventoAnalytics(id: String, nombre: String, contentType: String) {
    Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
        AnalyticsParameterItemID: "\(id)" as NSObject,
        AnalyticsParameterItemName: "\(nombre)" as NSObject,
        AnalyticsParameterContentType: "\(contentType)" as NSObject
        ])
    
}

/*
func extraerTexto(texto: String) -> String {
    var txt: String = String()
    txt = texto.replacingOccurrences(of: "\n", with: "")
    txt  = EncryptionUtil.decrypt(txt)!
    return txt
}
*/

class NoticiasDetalle {
    var categoria: String!
    var subtitulo: String!
    var relevancia: String!
    var fecha: String!
    var imagen: String!
    var descripcion: String!
    var iframes: [String]!
    var urlsExternas: [[String:AnyObject]]!
    
    
    func setValores(categoria: String, subtitulo: String, relevancia: String, fecha: String, imagen: String, descripcion: String, iframes: [String], urlsExternas: [[String:AnyObject]]) {
        self.categoria = categoria
        self.subtitulo = subtitulo
        self.relevancia = relevancia
        self.fecha = fecha
        self.imagen = imagen
        self.descripcion = descripcion
        self.iframes = iframes
        self.urlsExternas = urlsExternas
    }
    
    init(){
        self.categoria = ""
        self.subtitulo = ""
        self.relevancia = ""
        self.fecha = ""
        self.imagen = ""
        self.descripcion = ""
        self.iframes = []
        self.urlsExternas = [[:]]
    }
}

class Cargador: UIView{
    
    let controladorActual = UIApplication.topViewController()
    var vistacargadorc:UIScrollView = UIScrollView()
    let malla:UIView = UIView()
    let marco:UIView = UIView()
    let textoCargador:UIButton = UIButton()
    
    let botonCerrar:UIButton = UIButton()
    
    let botonAceptar:UIButton = UIButton()
    let botonDeclinar:UIButton = UIButton()
    let titulo:UIButton = UIButton()
    let subtitulo:UIButton = UIButton()
    
    static let cargadorSingleton = Cargador()
    
    var urlDescarga: String = String()
    
    
    let auxColor:UIColor = UIColor(rgba: "#FFFFFF")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        vistacargadorc.frame = (controladorActual?.view!.frame)!
        
        vistacargadorc.backgroundColor = UIColor.clear
        
        //let malla:UIView = UIView()
        
        //malla.frame = vistacargadorc.frame
        
        //malla.backgroundColor = UIColor(rgba:"#000000")
        
        //malla.alpha = 0.5
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = vistacargadorc.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        vistacargadorc.addSubview(blurEffectView)//malla)
        
        marco.tag = -12
        
        marco.frame = CGRect(x: vistacargadorc.frame.width * 0.2, y: vistacargadorc.frame.height * 0.3, width: vistacargadorc.frame.width * 0.6, height: vistacargadorc.frame.height * 0.25)
        
        marco.backgroundColor = azulBarraCargador
        
        marco.layer.cornerRadius = 10
        
        vistacargadorc.addSubview(marco)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func cargadorTipo1(){
        
        
        //let vistaLoading = NVActivityIndicatorView(frame: CGRect(x: vistacargadorc.frame.width * 0.38, y: vistacargadorc.frame.height * 0.3, width: vistacargadorc.frame.width * 0.25, height: vistacargadorc.frame.height * 0.2),color:auxColor)
        let vistaloading = loading()
        
        vistaloading.tag = -34
        
        //vistaloading.type = .ballSpinFadeLoader
        
        vistacargadorc.addSubview(vistaloading)
        
        controladorActual?.view!.addSubview(vistacargadorc)
        
        vistaloading.startAnimating()
        /*
         textoCargador.frame = CGRect(x: marco.frame.origin.x, y:marco.frame.origin.y + marco.frame.height*0.63, width: marco.frame.width, height: marco.frame.height*0.3)
         
         textoCargador.setTitle("Cargando...", for: .normal)
         
         textoCargador.setTitleColor(auxColor, for: .normal)
         
         textoCargador.setAttributedTitle(nil, for: UIControlState())
         
         textoCargador.titleLabel!.font = UIFont(name: fontFamilia, size: CGFloat(3))
         
         textoCargador.titleLabel!.font = textoCargador.titleLabel!.font.withSize(CGFloat(20))
         
         textoCargador.isSelected = false
         
         textoCargador.titleLabel!.textColor = auxColor
         
         textoCargador.titleLabel!.numberOfLines = 0
         
         textoCargador.titleLabel!.textAlignment = .center
         
         vistacargadorc.addSubview(textoCargador)
         */
    }
    
    func cargadorTipo2(){
        
        controladorActual?.view!.addSubview(vistacargadorc)
        
        botonCerrar.backgroundColor = azulBarraCargador
        
        botonCerrar.frame = CGRect(x: marco.frame.origin.x, y: marco.frame.origin.y + marco.frame.height * 0.9, width: marco.frame.width, height: marco.frame.height * 0.2)
        
        botonCerrar.setTitleColor(auxColor, for: .normal)
        
        botonCerrar.setTitle("CERRAR", for: .normal)
        
        botonCerrar.titleLabel?.font = UIFont(name: fontFamilia, size: 14)
        
        botonCerrar.contentVerticalAlignment = .center
        
        botonCerrar.contentHorizontalAlignment = .center
        
        botonCerrar.addTarget(self, action: #selector(self.ocultarCargador), for: .touchUpInside)
        
        let path = UIBezierPath(roundedRect:botonCerrar.bounds,
                                byRoundingCorners:[.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: 10, height:  10))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        botonCerrar.layer.mask = maskLayer
        
        vistacargadorc.addSubview(botonCerrar)
        
        vistacargadorc.bringSubview(toFront: botonCerrar)
    }
    
    func cargadorTipo3(textoTitulo: String, textoDescripcion: String, textoBotonIzquiero: String, textoBotonDerecho: String){
        
        //marco.frame = CGRect(x: marco.superview!.frame.width * 0.1, y: marco.superview!.frame.height * 0.3, width: marco.superview!.frame.width * 0.8, height: marco.superview!.frame.height * 0.4)
        
        controladorActual?.view!.addSubview(vistacargadorc)
        
        titulo.backgroundColor = azulBarraCargador
        
        titulo.frame = CGRect(x: marco.frame.origin.x, y: marco.frame.origin.y, width: marco.frame.width, height: marco.frame.height * 0.3)
        
        titulo.setTitleColor(auxColor, for: .normal)
        
        titulo.setTitle(textoTitulo, for: .normal)
        
        titulo.titleLabel?.font = UIFont(name: fontFamiliaBold, size: 16)
        
        titulo.contentVerticalAlignment = .center
        
        titulo.contentHorizontalAlignment = .center
        
        let path3 = UIBezierPath(roundedRect:titulo.bounds,
                                 byRoundingCorners:[.topLeft, .topRight],
                                 cornerRadii: CGSize(width: 10, height:  10))
        
        let maskLayer3 = CAShapeLayer()
        
        maskLayer3.path = path3.cgPath
        titulo.layer.mask = maskLayer3
        
        vistacargadorc.addSubview(titulo)
        
        //------
        
        subtitulo.backgroundColor = azulBarraCargador
        
        subtitulo.frame = CGRect(x: marco.frame.origin.x, y: titulo.frame.origin.y + titulo.frame.height, width: marco.frame.width, height: marco.frame.height * 0.45)
        
        subtitulo.setTitleColor(auxColor, for: .normal)
        
        subtitulo.setTitle(textoDescripcion, for: .normal)
        
        subtitulo.titleLabel?.font = UIFont(name: fontFamilia, size: 14)
        
        subtitulo.titleLabel?.numberOfLines = 2
        
        subtitulo.contentVerticalAlignment = .center
        
        subtitulo.contentHorizontalAlignment = .center
        
        let path4 = UIBezierPath(roundedRect:subtitulo.bounds,
                                 byRoundingCorners:[],
                                 cornerRadii: CGSize(width: 10, height:  10))
        
        let maskLayer4 = CAShapeLayer()
        
        maskLayer4.path = path4.cgPath
        subtitulo.layer.mask = maskLayer4
        
        vistacargadorc.addSubview(subtitulo)
        
        //------
        
        botonDeclinar.backgroundColor = UIColor(rgba:"#a71a3f")
        
        botonDeclinar.frame = CGRect(x: marco.frame.origin.x, y: marco.frame.origin.y + marco.frame.height * 0.75, width: marco.frame.width * 0.5, height: marco.frame.height * 0.25)
        
        botonDeclinar.setTitleColor(auxColor, for: .normal)
        
        botonDeclinar.setTitle(textoBotonIzquiero, for: .normal)
        
        botonDeclinar.titleLabel?.font = UIFont(name: fontFamilia, size: 14)
        
        botonDeclinar.contentVerticalAlignment = .center
        
        botonDeclinar.contentHorizontalAlignment = .center
        
        botonDeclinar.addTarget(self, action: #selector(self.ocultarCargador), for: .touchUpInside)
        
        let path = UIBezierPath(roundedRect:botonDeclinar.bounds,
                                byRoundingCorners:[.bottomLeft],
                                cornerRadii: CGSize(width: 10, height:  10))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        botonDeclinar.layer.mask = maskLayer
        
        vistacargadorc.addSubview(botonDeclinar)
        
        //------
        
        botonAceptar.backgroundColor = UIColor(rgba:"#a71a3f")
        
        botonAceptar.frame = CGRect(x: botonDeclinar.frame.origin.x + botonDeclinar.frame.width, y: botonDeclinar.frame.origin.y, width: marco.frame.width * 0.5, height: marco.frame.height * 0.25)
        
        botonAceptar.setTitleColor(auxColor, for: .normal)
        
        botonAceptar.setTitle(textoBotonDerecho, for: .normal)
        
        botonAceptar.titleLabel?.font = UIFont(name: fontFamilia, size: 14)
        
        botonAceptar.contentVerticalAlignment = .center
        
        botonAceptar.contentHorizontalAlignment = .center
        
        botonAceptar.addTarget(self, action: #selector(self.descargarApp), for: .touchUpInside)
        
        let path2 = UIBezierPath(roundedRect:botonAceptar.bounds,
                                 byRoundingCorners:[.bottomRight],
                                 cornerRadii: CGSize(width: 10, height:  10))
        
        let maskLayer2 = CAShapeLayer()
        
        maskLayer2.path = path2.cgPath
        botonAceptar.layer.mask = maskLayer2
        
        vistacargadorc.addSubview(botonAceptar)
        
        
        
        
        //vistacargadorc.bringSubview(toFront: botonAceptar)
        //vistacargadorc.bringSubview(toFront: botonDeclinar)
    }
    
    @objc func ocultarCargador(){
        
        let controladorActual = UIApplication.topViewController()
        
        let subvistas = controladorActual?.view!.subviews
        
        for subvista in subvistas! where subvista == vistacargadorc {
            
            DispatchQueue.main.async {
                
                subvista.removeFromSuperview()
                
            }
            
        }
        
    }
    
    @objc func descargarApp(){
        guard let url = URL(string: self.urlDescarga) else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        ocultarCargador()
    }
    
    func loading() -> UIImageView{
        var carreteImagenes: [UIImage] = []
        for i in 0..<18 {
            carreteImagenes.append((UIImage(named: "loader\(i)"))!)
        }
        
        marco.removeFromSuperview()
        
        let uiImageView: UIImageView = UIImageView(frame: CGRect(x: vistaCargador.frame.width * 0.5 - ((vistaCargador.frame.width * 0.25) / 2), y: vistaCargador.frame.height * 0.5 - ((vistaCargador.frame.height * 0.2) / 2 ), width: vistaCargador.frame.width * 0.25, height: vistaCargador.frame.height * 0.2))
        uiImageView.contentMode = .scaleAspectFill
        uiImageView.animationImages = carreteImagenes
        uiImageView.animationDuration = 1
        //uiImageView.startAnimating()
        
        return uiImageView
        
    }
    
}





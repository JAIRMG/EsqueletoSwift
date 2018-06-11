//
//  Extensiones.swift
//  DiageoOnTrade
//
//  Created by Daniel Cedeño García on 10/9/17.
//  Copyright © 2017 Go Sharp. All rights reserved.
//

import Foundation
import SystemConfiguration
import MapKit
import LocalAuthentication
//import CryptoSwift

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l >= r
    default:
        return !(lhs < rhs)
    }
}


let defaults = UserDefaults.standard

extension UIImage {
    func resize(_ scale:CGFloat)-> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width*scale, height: size.height*scale)))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
    func resizeToWidth(_ width:CGFloat)-> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
    
    func resize2(targetSize: CGSize) -> UIImage {
        if #available(iOS 10.0, *) {
            return UIGraphicsImageRenderer(size:targetSize).image { _ in
                self.draw(in: CGRect(origin: .zero, size: targetSize))
            }
        } else {
            let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: targetSize.width, height: CGFloat(ceil(targetSize.width/size.width * size.height)))))
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            imageView.image = self
            UIGraphicsBeginImageContext(imageView.bounds.size)
            imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
            let result = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return result!
        }
    }
    
    //para cambiar a blanco y negro mandar parametro 0.5
    func grayScale(contrast value: NSNumber) -> UIImage? {
        guard
            let ciImage = CIImage(image: self)?.applyingFilter("CIColorControls", parameters: [kCIInputContrastKey: value])
            else { return nil } // Swift 3 uses withInputParameters instead of parameters
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        UIImage(ciImage: ciImage).draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}


extension Date {
    func isBetweeen(date date1: Date, andDate date2: Date) -> Bool {
        return date1.compare(self) == self.compare(date2)
    }
}


extension UIColor {
    public convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let index   = rgba.index(rgba.startIndex, offsetBy: 1)
            let hex     = rgba[index...]
            let scanner = Scanner(string: String(hex))
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                switch (hex.count) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
                }
            } else {
                print("Scan hex error", terminator: "")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix", terminator: "")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}


extension UIViewController: UITextFieldDelegate{
    func addToolBar(_ textField: UITextField){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        let doneButton = UIBarButtonItem(title: "Listo", style: UIBarButtonItemStyle.done, target: self, action: #selector(UIViewController.donePressed))
        //let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(UIViewController.cancelPressed))
        //let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textField.delegate = self
        textField.inputAccessoryView = toolBar
    }
    @objc func donePressed(){
        view.endEditing(true)
    }
    func cancelPressed(){
        view.endEditing(true) // or do something
    }
}


func obtener_ruta_Documents() -> URL {
    
    
    
    
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    return documentsURL
}

func ruta_absoluta(_ filename: String) -> String {
    
    let fileURL = obtener_ruta_Documents().appendingPathComponent(filename)
    return fileURL.path
    
}

func dibujar_cuadro(_ size: CGSize,color:String) -> UIImage {
    // Setup our context
    //let bounds = CGRect(origin: CGPoint.zero, size: size)
    let opaque = false
    let scale: CGFloat = 0
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
    let context = UIGraphicsGetCurrentContext()
    
    // Setup complete, do drawing here
    //CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
    //CGContextSetLineWidth(context, 2.0)
    
    //CGContextStrokeRect(context, bounds)
    
    //CGContextBeginPath(context)
    
    //CGContextMoveToPoint(context, CGRectGetMinX(bounds), CGRectGetMinY(bounds))
    //CGContextAddLineToPoint(context, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds))
    //CGContextMoveToPoint(context, CGRectGetMaxX(bounds), CGRectGetMinY(bounds))
    //CGContextAddLineToPoint(context, CGRectGetMinX(bounds), CGRectGetMaxY(bounds))
    //CGContextStrokePath(context)
    
    
    //let context = UIGraphicsGetCurrentContext()
    
    context?.setLineWidth(4.0)
    context?.setStrokeColor(UIColor(rgba: "#\(color)").cgColor)
    let rectangle = CGRect(x: 0,y: 0,width: size.width,height: size.height)
    context?.addRect(rectangle)
    context?.strokePath()
    context?.setFillColor(UIColor(rgba: "#\(color)").cgColor)
    context?.fill(rectangle)
    
    
    context?.setFillColor(UIColor(rgba: "#\(color)").cgColor)
    context?.fillPath()
    
    
    
    // Drawing complete, retrieve the finished image and cleanup
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
}




func generar_udid() {
    let newUniqueID = CFUUIDCreate(kCFAllocatorDefault)
    let newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    let guid = newUniqueIDString! as String
    
    let defaults = UserDefaults.standard
    
    defaults.set(guid.lowercased(), forKey: "mi_udid")
    
    //return guid.lowercased as NSString
}

func obtener_udid()->String{
    
    
    let defaults = UserDefaults.standard
    
    if defaults.object(forKey: "mi_udid") == nil {
        
        generar_udid()
        
    }
    
    let aux_udid = defaults.object(forKey: "mi_udid") as! String
    
    return aux_udid
    
}


//clase reachability


internal class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}



//fin clase reachability


//distancia entre dos coordenadas

func distancia_entre_dos_coordenadas(_ coordenada1:Double,coordenada2:Double,coordenada3:Double,coordenada4:Double) -> String{
    
    
    let aux_location2: CLLocation = CLLocation(latitude: coordenada1, longitude: coordenada2)
    
    let aux_location1: CLLocation = CLLocation(latitude:  coordenada3, longitude: coordenada4)
    
    let distance = aux_location1.distance(from: aux_location2)
    
    
    
    
    let kilometros = "\(String(format: "%.1f",(distance.description as NSString).doubleValue/1000)) KM"
    
    return kilometros
    
}

//fin de distancia entre dos coordenadas


//obtener fecha satelite

func obtener_fecha_satelite() -> String{
    
    
    
    let locationManager: CLLocationManager! = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        //manager.delegate = self
        manager.requestAlwaysAuthorization()
        return manager
    }()
    
    var satelliteUTC = ""
    
    if let _ = locationManager.location {
        print("aqui el satelite")
        print(locationManager.location!.timestamp)
        
        satelliteUTC = String(Int64(locationManager.location!.timestamp.timeIntervalSince1970*1000))
        
        //satelliteUTC = dateFormatter.string(from: locationManager.location!.timestamp)
        
    }
    
    
    print(satelliteUTC)
    
    return satelliteUTC
    
}

//fin obtener fecha satelite


//obtener ubicacion

let locationManager: CLLocationManager! = {
    let manager = CLLocationManager()
    manager.desiredAccuracy = kCLLocationAccuracyBest
    //manager.delegate = self
    manager.requestAlwaysAuthorization()
    return manager
}()

func obtener_ubicacion()->CLLocation{
    
    
    
    
    
    //locationManager.delegate = controlador
    locationManager.requestAlwaysAuthorization()
    locationManager.startUpdatingLocation()
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    
    //si no hay location
    
    
    if let _ = locationManager.location {
        
        return locationManager.location!
        
    }
    else{
        
        
        
        print("no tenemos location")
        
        let aux_location = CLLocation(latitude: 0, longitude: 0)
        
        
        //defaults.setObject("0", forKey: "satelliteUTC")
        
        //defaults.setObject(aux_location.coordinate.latitude, forKey: "miLatitude")
        
        //defaults.setObject(aux_location.coordinate.longitude, forKey: "miLongitude")
        
        
        return aux_location
        
    }
    
    
    
    //fin si no hay location
    
    
    
}

//fin obtener ubicacion


func devicePasscodeSet() -> Bool {
    //checks to see if devices (not apps) passcode has been set
    return LAContext().canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
}




func checar_version_guardada() -> [String:AnyObject]{
    
    var versionGuardada = defaults.object(forKey: "versionGuardada") as? String
    
    var tipo = 1
    
    if versionGuardada == nil {
        
        tipo = 0
        versionGuardada = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        
        defaults.set(versionGuardada, forKey: "versionGuardada")
        
    }
    
    return ["versionGuardada":versionGuardada! as AnyObject,"tipo":tipo as AnyObject]
    
}


extension UILabel{
    
    func adjustFontSizeToFitRect(rect : CGRect,maximo:CGFloat){
        
        if text == nil{
            return
        }
        
        frame = rect
        
        let maxFontSize: CGFloat = maximo
        let minFontSize: CGFloat = 5.0
        
        var q = Int(maxFontSize)
        var p = Int(minFontSize)
        
        let constraintSize = CGSize(width: rect.width, height: CGFloat.greatestFiniteMagnitude)
        
        while(p <= q){
            let currentSize = (p + q) / 2
            font = font.withSize( CGFloat(currentSize) )
            let text = NSAttributedString(string: self.text!, attributes: [NSAttributedStringKey.font:font])
            let textRect = text.boundingRect(with: constraintSize, options: .usesLineFragmentOrigin, context: nil)
            
            let labelSize = textRect.size
            
            if labelSize.height < frame.height && labelSize.height >= frame.height-10 && labelSize.width < frame.width && labelSize.width >= frame.width-10 {
                break
            }else if labelSize.height > frame.height || labelSize.width > frame.width{
                q = currentSize - 1
            }else{
                p = currentSize + 1
            }
        }
        
    }
}


extension String {
    
    func escapeStr() -> (String) {
        let raw: NSString = self as NSString
        
        let characterSet = NSMutableCharacterSet() //create an empty mutable set
        characterSet.formUnion(with: NSCharacterSet.urlQueryAllowed)
        //characterSet.addCharacters(in: "&")
        characterSet.removeCharacters(in: "+")
        characterSet.removeCharacters(in: "$")
        characterSet.removeCharacters(in: "%")
        characterSet.removeCharacters(in: "&")
        
        let str = raw.addingPercentEncoding(withAllowedCharacters: characterSet as CharacterSet)
        
        
        //let str = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,raw,"[]." as CFString!,":/?&=;+!@#$()',*" as CFString!,CFStringConvertNSStringEncodingToEncoding(String.Encoding.utf8.rawValue))
        return str!
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf16) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:  NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
}

extension Dictionary {
    
    func parametrizarGET()->(String){
        
        
        var parametrosString = "?"
        
        for (indice,parametro) in self.enumerated() {
            
            if indice > 0 {
                
                parametrosString.append("&")
            }
            
            
            parametrosString.append(parametro.key as! String)
            parametrosString.append("=")
            parametrosString.append(parametro.value as! String)
            
        }
        
        
        return parametrosString.escapeStr()
        
    }
    
    
}


extension Array
{
    func toJsonString()->String
    {
        do
        {
            // convert array to data
            let jsonData = try JSONSerialization.data(withJSONObject: self)
            
            // load into string
            guard let string = String.init(data: jsonData, encoding: String.Encoding.utf8) else {
                print("Failed casting json to string...")
                return ""
            }
            
            return string
        }
        catch
        {
            print(error)
        }
        return ""
    }
}

extension Data {
    var stringValue:String {
        return NSString(data: self, encoding: String.Encoding.utf8.rawValue) as String? ?? ""
    }
}


extension Dictionary
{
    func toJsonString()->String
    {
        do
        {
            // convert array to data
            let jsonData = try JSONSerialization.data(withJSONObject: self)
            
            // load into string
            guard let string = String.init(data: jsonData, encoding: String.Encoding.utf8) else {
                print("Failed casting json to string...")
                return ""
            }
            
            
            return string
        }
        catch
        {
            print(error)
        }
        return ""
    }
}


func fileInDocumentsDirectory(filename: String) -> String {
    
    let fileURL = getDocumentsURL().appendingPathComponent(filename)
    return fileURL!.path
    
}

func getDocumentsURL() -> NSURL {
    
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    return documentsURL as NSURL
}

func removeImage(archivo:String) {
    let fileManager = FileManager.default
    let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
    let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
    let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
    guard let dirPath = paths.first else {
        return
    }
    let filePath = "\(dirPath)/\(archivo)"
    do {
        try fileManager.removeItem(atPath: filePath)
    } catch let error as NSError {
        print(error.debugDescription)
    }
    
}

func borrar_imagen(ruta:String){
    
    let fileManager = FileManager.default
    
    let filePath = ruta
    do {
        try fileManager.removeItem(atPath: filePath)
        print("se borro la imagen \(ruta)")
    } catch let error as NSError {
        print(error.debugDescription)
    }
    
    
}


func deviceRemainingFreeSpaceInBytes() -> Int64? {
    let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
    guard
        let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: documentDirectory),
        let freeSize = systemAttributes[.systemFreeSize] as? NSNumber
        else {
            // something failed
            return nil
    }
    return freeSize.int64Value
}


extension String
{
    func encodeUrl() -> String
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    func decodeUrl() -> String
    {
        return self.removingPercentEncoding!
    }
}

func dibujarCirculo(ancho:CGFloat,alto:CGFloat,color:UIColor) -> CAShapeLayer {
    
    let circlePath = UIBezierPath(arcCenter: CGPoint(x: ancho,y: alto), radius: CGFloat(20), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = circlePath.cgPath
    
    //change the fill color
    shapeLayer.fillColor = color.cgColor
    //you can change the stroke color
    shapeLayer.strokeColor = color.cgColor
    //you can change the line width
    shapeLayer.lineWidth = 3.0
    
    shapeLayer.frame.origin.x = 0
    shapeLayer.frame.origin.y = 0
    
    return shapeLayer
    
}

func setGradientBackground(laVista:UIScrollView,colorTop:CGColor,colorBottom:CGColor) {
    
    //let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
    //let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [ colorTop, colorBottom]
    gradientLayer.locations = [ 0.0, 1.0]
    gradientLayer.frame = laVista.bounds
    
    laVista.layer.addSublayer(gradientLayer)
}

extension UIView {
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    
}

extension NSNumber {
    
    func formatoMoneda() -> String {
        
        let price = self
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.string(from: price) // "$123.44"
        
        formatter.locale = NSLocale.current
        //formatter.string(from: price) // $123"
        
        //formatter.locale = Locale(identifier: "es_ES")
        
        let auxNumero = formatter.string(from: price) // "123,44 €"
        
        return auxNumero!
        
        
    }
    
}

extension UIButton {
    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let padding = CGFloat(10)
        let extendedBounds = bounds.insetBy(dx: -padding, dy: -padding)
        return extendedBounds.contains(point)
    }
}

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

extension UILabel {
    func textHeight(for width: CGFloat) -> CGFloat {
        guard let text = text else {
            return 0
        }
        return text.height(for: width, font: font)
    }
    
    func attributedTextHeight(for width: CGFloat) -> CGFloat {
        guard let attributedText = attributedText else {
            return 0
        }
        return attributedText.height(for: width)
    }
}

extension String {
    func height(for width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font: font], context: nil)
        return actualSize.height
    }
}

extension NSAttributedString {
    func height(for width: CGFloat) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], context: nil)
        return actualSize.height
    }
}

extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat,x:CGFloat,width:CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect.init(x: x, y: 0, width: width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect.init(x: x, y: frame.height - thickness, width: width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect.init(x: 0, y: 0, width: thickness, height: frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect.init(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
}

extension Notification.Name {
    
    static let appTimeout = Notification.Name("appTimeout")
    
}

//Revisa si los permisos para acceder a la localización están habilitados, en caso de que lo estén retorna true, sino retorna false
func revisarPermisosLocalizacion() -> Bool {
    if CLLocationManager.locationServicesEnabled() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined, .restricted, .denied:
            return false
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        }
    } else {
        return false
    }
    
}

func validarCorreo(correo:String) -> Bool {
    
    let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
    return emailPredicate.evaluate(with: correo)
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension NSMutableAttributedString {
    
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(NSAttributedStringKey.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}


struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE            = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_7          = IS_IPHONE_6
    static let IS_IPHONE_7P         = IS_IPHONE_6P
    static let IS_IPHONE_X         = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO_9_7      = IS_IPAD
    static let IS_IPAD_PRO_12_9     = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
    static let IS_TV                = UIDevice.current.userInterfaceIdiom == .tv
    static let IS_CAR_PLAY          = UIDevice.current.userInterfaceIdiom == .carPlay
    
}

struct Version{
    static let SYS_VERSION_FLOAT = (UIDevice.current.systemVersion as NSString).floatValue
    static let iOS7 = (Version.SYS_VERSION_FLOAT < 8.0 && Version.SYS_VERSION_FLOAT >= 7.0)
    static let iOS8 = (Version.SYS_VERSION_FLOAT >= 8.0 && Version.SYS_VERSION_FLOAT < 9.0)
    static let iOS9 = (Version.SYS_VERSION_FLOAT >= 9.0 && Version.SYS_VERSION_FLOAT < 10.0)
    static let iOS10 = (Version.SYS_VERSION_FLOAT >= 10.0 && Version.SYS_VERSION_FLOAT < 11.0)
}


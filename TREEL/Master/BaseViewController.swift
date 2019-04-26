//
//  BaseViewController.swift
//  TREEL
//
//  Created by Treel Mobility  on 22/04/19.
//  Copyright © 2019 Treel Mobility . All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont(name: .EXO_BOLD, size: 17)!];
        self.navigationController?.navigationBar.largeTitleTextAttributes =  [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                              NSAttributedString.Key.font: UIFont(name: .EXO_BOLD, size: 40)!];
        // Do any additional setup after loading the view.
    }
    
    //Method to display Alert Message
    func showAlert(msg: String) {
        let alert = UIAlertController(title:"Alert", message: msg, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension String {
    
    public static let LOTO_REGULAR = "Lato-Regular"
    public static let LOTO_BOLD = "Lato-Bold"
    public static let EXO_REGULAR = "Exo-Regular"
    public static let EXO_BOLD = "Exo-Bold"
    public static let EXO_SEMI_BOLD = "Exo-Semi-Bold"
    
    public static let maxPressure : Int = 30
    public static let minPressure : Int = 20
    public static let maxTemp : Int = 60
    
    public static let treelTag1 = "DBEF7B651F83"
    public static let treelTag2 = "C2CA9EA0EF40"

    ///DBEF7B651F83
    //C2CA9EA0EF40
    
    public static let TIRE_1A = "1A"
    public static let TIRE_1B = "1B"
    public static let TIRE_2A = "2A"
    public static let TIRE_2B = "2B"
    public static let TIRE_2C = "2C"
    public static let TIRE_2D = "2D"
    public static let TIRE_3A = "3A"
    public static let TIRE_3B = "3B"
    public static let TIRE_3C = "3C"
    public static let TIRE_3D = "3D"
    public static let TIRE_4A = "4A"
    public static let TIRE_4B = "4B"
    public static let TIRE_4C = "4C"
    public static let TIRE_4D = "4D"
    public static let TIRE_5A = "5A"
    public static let TIRE_5B = "5B"
    public static let TIRE_5C = "5C"
    public static let TIRE_5D = "5D"
    public static let TIRE_6A = "6A"
    public static let TIRE_6B = "6B"

}

struct ScreenSize
{
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

//@K
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

import Foundation
import Alamofire

class Connectivity{
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

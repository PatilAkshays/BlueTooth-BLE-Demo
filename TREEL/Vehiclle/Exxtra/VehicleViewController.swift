//
//  VehicleViewController.swift
//  TREEL
//
//  Created by Treel Mobility  on 22/04/19.
//  Copyright © 2019 Treel Mobility . All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
class VehicleViewController: BaseViewController {
    @IBOutlet weak var podBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        BLEManager.sharedManager.delegate = self

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationItem.leftBarButtonItem?.image = UIImage(named: "back")
//        BLEManager.sharedManager.findBLE(true)
    }
    
    
    @IBAction func pressPodBtnAction(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vehicleDetailsVC = storyBoard.instantiateViewController(withIdentifier:"VehicleDetailsVC") as! VehicleDetailsVC
        vehicleDetailsVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(vehicleDetailsVC, animated:true, completion:nil)
    }
    @IBAction func pressTireBtnAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vehicleDetailsVC = storyBoard.instantiateViewController(withIdentifier:"VehicleDetailsVC") as! VehicleDetailsVC
        vehicleDetailsVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext

        self.present(vehicleDetailsVC, animated:true, completion:nil)
    }
    @IBAction func pressVehicleBtnAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vehicleDetailsVC = storyBoard.instantiateViewController(withIdentifier:"VehicleDetailsVC") as! VehicleDetailsVC
        vehicleDetailsVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext

        self.present(vehicleDetailsVC, animated:true, completion:nil)
        
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
//extension VehicleViewController: BLEManagerProtocol {
//
//    func onTreelDeviceDetected(treelTags: Array<LogicareTreelTag>) {
//        print("tag Data: ",treelTags)
////        self.treelTags = treelTags
//    }
//}

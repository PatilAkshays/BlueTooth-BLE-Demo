//
//  TwentyTiresVehicleVC.swift
//  TMass
//
//  Created by Treel Mobility  on 03/04/19.
//  Copyright © 2019 AkshAy Patil. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
class TwentyTiresVehicleVC: BaseViewController {

    @IBOutlet var issueReportViewModel: TireViewModel!

    @IBOutlet weak var tire1A: TireParameterControl!
    @IBOutlet weak var tire1B: TireParameterControl!
    
    @IBOutlet weak var tire2A: TireParameterControl!
    @IBOutlet weak var tire2B: TireParameterControl!
    @IBOutlet weak var tire2C: TireParameterControl!
    @IBOutlet weak var tire2D: TireParameterControl!
    
    @IBOutlet weak var tire3A: TireParameterControl!
    @IBOutlet weak var tire3B: TireParameterControl!
    @IBOutlet weak var tire3C: TireParameterControl!
    @IBOutlet weak var tire3D: TireParameterControl!
    
    @IBOutlet weak var tire4A: TireParameterControl!
    @IBOutlet weak var tire4B: TireParameterControl!
    @IBOutlet weak var tire4C: TireParameterControl!
    @IBOutlet weak var tire4D: TireParameterControl!
    
    @IBOutlet weak var tire5A: TireParameterControl!
    @IBOutlet weak var tire5B: TireParameterControl!
    @IBOutlet weak var tire5C: TireParameterControl!
    @IBOutlet weak var tire5D: TireParameterControl!
    
    @IBOutlet weak var tire6A: TireParameterControl!
    @IBOutlet weak var tire6B: TireParameterControl!

    @IBOutlet weak var scrollView: UIScrollView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //Set tire Postion
        tire1A.positonString = .TIRE_1A
        tire1B.positonString = .TIRE_1B
        
        tire2A.positonString = .TIRE_2A
        tire2B.positonString = .TIRE_2B
        tire2C.positonString = .TIRE_2C
        tire2D.positonString = .TIRE_2D
        
        tire3A.positonString = .TIRE_3A
        tire3B.positonString = .TIRE_3B
        tire3C.positonString = .TIRE_3C
        tire3D.positonString = .TIRE_3D
        
        tire4A.positonString = .TIRE_4A
        tire4B.positonString = .TIRE_4B
        tire4C.positonString = .TIRE_4C
        tire4D.positonString = .TIRE_4D
        
        tire5A.positonString = .TIRE_5A
        tire5B.positonString = .TIRE_5B
        tire5C.positonString = .TIRE_5C
        tire5D.positonString = .TIRE_5D
        
        tire6A.positonString = .TIRE_6A
        tire6B.positonString = .TIRE_6B
        //Set Tire Border Color
        updateTyreBorderColorAndTireConfigMethod()
        //Set tire Config Data
        updateTireConfigData()
        //Get Tire TPMS Data
        self.getTPMSUpdatedData()

      
        //Add Tap Gesture on Tire View And Odometer Label
        self.addTapGestureOnTireView();
    
        // Do any additional setup after loading the view.
        self.fetchIssueReportData();

    }
    
    func recomendedPressureTempCheck(tire : TireParameterControl,pressure : Int) -> Void {
        
        if pressure > String.maxPressure || pressure < String.minPressure {
            tire.borderColor = .red
        }else{
            tire.borderColor = .green
        }
        
    }
    ////MARK: Get Issue Report Data Array
    private func fetchIssueReportData() {
        if Connectivity.isConnectedToInternet(){
//            showLoading()
            //Get all vehicles and its configurations
            self.issueReportViewModel?.getAllVehicleTireData(completion: {(responceModel) in
                let vehicleData = responceModel.vehicleData![0]

                if vehicleData.Pres_0 != nil && vehicleData.Pres_0 != "" {
                    self.tire1A.pressureLbl.text = vehicleData.Pres_0! + " PSI"
                    self.tire1A.tempLbl.text = vehicleData.Temp_0! + " °C"
                    self.recomendedPressureTempCheck(tire: self.tire1A, pressure: Int(vehicleData.Pres_0!)!)
                }else{
                    self.tire1A.borderColor = .red
                }
                if vehicleData.Pres_1 != nil && vehicleData.Pres_1 != "" {
                    self.tire1B.pressureLbl.text = vehicleData.Pres_1! + " PSI"
                    self.tire1B.tempLbl.text = vehicleData.Temp_1! + " °C"
                    self.recomendedPressureTempCheck(tire: self.tire1B, pressure: Int(vehicleData.Pres_1!)!)
                }else{
                    self.tire1B.borderColor = .red
                }
                if vehicleData.Pres_2 != nil && vehicleData.Pres_2 != "" {
                    self.tire2A.pressureLbl.text = vehicleData.Pres_2! + " PSI"
                    self.tire2A.tempLbl.text = vehicleData.Temp_2! + " °C"
                    self.recomendedPressureTempCheck(tire: self.tire2A, pressure: Int(vehicleData.Pres_2!)!)
                }else{
                    self.tire2A.borderColor = .red
                }
                if vehicleData.Pres_3 != nil && vehicleData.Pres_3 != "" {
                    self.tire2B.pressureLbl.text = vehicleData.Pres_3! + " PSI"
                    self.tire2B.tempLbl.text = vehicleData.Temp_3! + " °C"
                    self.recomendedPressureTempCheck(tire: self.tire2B, pressure: Int(vehicleData.Pres_3!)!)
                }else{
                    self.tire2B.borderColor = .red
                }
                if vehicleData.Pres_4 != nil && vehicleData.Pres_4 != "" {
                    self.tire2C.pressureLbl.text = vehicleData.Pres_4! + " PSI"
                    self.tire2C.tempLbl.text = vehicleData.Temp_4! + " °C"
                    self.recomendedPressureTempCheck(tire: self.tire2C, pressure: Int(vehicleData.Pres_4!)!)
                }else{
                    self.tire2C.borderColor = .red
                }
                
                if vehicleData.Pres_5 != nil && vehicleData.Pres_5 != "" {
                    self.tire2D.pressureLbl.text = vehicleData.Pres_5! + " PSI"
                    self.tire2D.tempLbl.text = vehicleData.Temp_5! + " °C"
                    self.recomendedPressureTempCheck(tire: self.tire2D, pressure: Int(vehicleData.Pres_5!)!)
                }else{
                    self.tire2D.borderColor = .red
                }
                if vehicleData.Pres_6 != nil && vehicleData.Pres_6 != "" {
                    self.tire3A.pressureLbl.text = vehicleData.Pres_6! + " PSI"
                    self.tire3A.tempLbl.text = vehicleData.Temp_6! + " °C"
                    self.recomendedPressureTempCheck(tire: self.tire3A, pressure: Int(vehicleData.Pres_6!)!)
                }else{
                    self.tire3A.borderColor = .red
                }
                if vehicleData.Pres_7 != nil && vehicleData.Pres_7 != "" {
                    self.tire3B.pressureLbl.text = vehicleData.Pres_7! + " PSI"
                    self.tire3B.tempLbl.text = vehicleData.Temp_7! + " °C"
                    self.recomendedPressureTempCheck(tire: self.tire3B, pressure: Int(vehicleData.Pres_7!)!)
                }else{
                    self.tire3B.borderColor = .red
                }
                if vehicleData.Pres_8 != nil && vehicleData.Pres_8 != "" {
                    self.tire3C.pressureLbl.text = vehicleData.Pres_8! + " PSI"
                    self.tire3C.tempLbl.text = vehicleData.Temp_8! + " °C"
                    self.recomendedPressureTempCheck(tire: self.tire3C, pressure: Int(vehicleData.Pres_8!)!)
                }else{
                    self.tire3C.borderColor = .red
                }
                if vehicleData.Pres_9 != nil && vehicleData.Pres_9 != "" {
                    self.tire3D.pressureLbl.text = vehicleData.Pres_9! + " PSI"
                    self.tire3D.tempLbl.text = vehicleData.Temp_9! + " °C"
                    self.recomendedPressureTempCheck(tire: self.tire3D, pressure: Int(vehicleData.Pres_9!)!)
                }else{
                    self.tire3D.borderColor = .red
                }
                if vehicleData.Pres_10 != nil && vehicleData.Pres_10 != "" {
                    self.tire4A.pressureLbl.text = vehicleData.Pres_10! + " PSI"
                    self.tire4A.tempLbl.text = vehicleData.Temp_6! + " °C"
                    self.recomendedPressureTempCheck(tire: self.tire4A, pressure: Int(vehicleData.Pres_10!)!)
                }else{
                    self.tire5A.borderColor = .red
                }
                if vehicleData.Pres_11 != nil && vehicleData.Pres_11 != "" {
                    self.tire4B.pressureLbl.text = vehicleData.Pres_11! + " PSI"
                    self.tire4B.tempLbl.text = vehicleData.Temp_11! + " °C"
                    self.recomendedPressureTempCheck(tire: self.tire4B, pressure: Int(vehicleData.Pres_11!)!)
                }else{
                    self.tire5A.borderColor = .red
                }
                if vehicleData.Pres_12 != nil && vehicleData.Pres_12 != "" {
                    self.tire4C.pressureLbl.text = vehicleData.Pres_12! + " PSI"
                    self.tire4C.tempLbl.text = vehicleData.Temp_12! + " °C"
                    self.recomendedPressureTempCheck(tire: self.tire4C, pressure: Int(vehicleData.Pres_12!)!)
                }else{
                    self.tire5A.borderColor = .red
                }
                if vehicleData.Pres_13 != nil && vehicleData.Pres_13 != "" {
                    self.tire4D.pressureLbl.text = vehicleData.Pres_13! + " PSI"
                    self.tire4D.tempLbl.text = vehicleData.Temp_13! + " °C"
                    self.recomendedPressureTempCheck(tire: self.tire4D, pressure: Int(vehicleData.Pres_13!)!)
                }else{
                    self.tire5A.borderColor = .red
                }
                if vehicleData.Pres_14 != nil && vehicleData.Pres_14 != "" {
                    self.tire5A.pressureLbl.text = vehicleData.Pres_14! + " PSI"
                    self.tire5A.tempLbl.text = vehicleData.Temp_15! + " °C"
                    self.recomendedPressureTempCheck(tire: self.tire5A, pressure: Int(vehicleData.Pres_14!)!)
                }else{
                    self.tire5A.borderColor = .red
                }
                if vehicleData.Pres_15 != nil && vehicleData.Pres_15 != "" {
                    self.tire5B.pressureLbl.text = vehicleData.Pres_15! + " PSI"
                    self.tire5B.tempLbl.text = vehicleData.Temp_15! + " °C"
                    self.recomendedPressureTempCheck(tire: self.tire5B, pressure: Int(vehicleData.Pres_15!)!)
                }else{
                    self.tire5B.borderColor = .red
                }
                if vehicleData.Pres_16 != nil && vehicleData.Pres_16 != "" {
                    self.tire5C.pressureLbl.text = vehicleData.Pres_16! + " PSI"
                    self.tire5C.tempLbl.text = vehicleData.Temp_16! + " °C"
                    self.recomendedPressureTempCheck(tire: self.tire5C, pressure: Int(vehicleData.Pres_16!)!)
                }else{
                    self.tire5C.borderColor = .red
                }
                if vehicleData.Pres_17 != nil && vehicleData.Pres_17 != "" {
                    self.tire5D.pressureLbl.text = vehicleData.Pres_17! + " PSI"
                    self.tire5D.tempLbl.text = vehicleData.Temp_17! + " °C"
                    self.recomendedPressureTempCheck(tire: self.tire5D, pressure: Int(vehicleData.Pres_17!)!)
                }else{
                    self.tire5D.borderColor = .red
                }
                if vehicleData.Pres_18 != nil && vehicleData.Pres_18 != "" {
                    self.tire6A.pressureLbl.text = vehicleData.Pres_18! + " PSI"
                    self.tire6A.tempLbl.text = vehicleData.Temp_18! + " °C"
                    self.recomendedPressureTempCheck(tire: self.tire6A, pressure: Int(vehicleData.Pres_18!)!)
                }else{
                    self.tire6A.borderColor = .red
                }
                if vehicleData.Pres_19 != nil && vehicleData.Pres_19 != "" {
                    self.tire6B.pressureLbl.text = vehicleData.Pres_19! + " PSI"
                    self.tire6B.tempLbl.text = vehicleData.Temp_19! + " °C"
                    self.recomendedPressureTempCheck(tire: self.tire6B, pressure: Int(vehicleData.Pres_19!)!)
                }else{
                    self.tire6B.borderColor = .red
                }
               
                
                
                
                
                
//                self.hideLoading()
                
//                if  (self.issueReportViewModel?.getAllGroupSuccess())!{
                
//                    self.showAlert(msg: (self.issueReportViewModel?.getAllGroupSuccessMsg())!);
                
                    
                    
//                }else if responceModel.errCodeStr == "403" || responceModel.errCodeStr == "405" {
////                    self.showNeedToReloginAlert(msg: .AUTH_TOKEN_MSG)
//                }
                
                
            })
            
        }else{
            showAlert(msg: "Please Connect to Internet")
        }
        
    }
    
    
    //Method: Set Tire Border Color
    func updateTyreBorderColorAndTireConfigMethod() -> Void {
        let tireArray : [TireParameterControl] = [self.tire1A,self.tire1B,self.tire2A,self.tire2B,self.tire2C,self.tire2D,self.tire3A,self.tire3B,self.tire3C,self.tire3D,self.tire4A,self.tire4B,self.tire4C,self.tire4D,self.tire5A,self.tire5B,self.tire5C,self.tire5D,self.tire6A,self.tire6B]

//        self.updateTireBorderColorWithTagOnTireVehicleData( tireViewArray: tireArray)
    }
    //Method: Set Tire Configuration Data
    func updateTireConfigData() -> Void {
        let tireArray : [TireParameterControl] = [self.tire1A,self.tire1B,self.tire2A,self.tire2B,self.tire2C,self.tire2D,self.tire3A,self.tire3B,self.tire3C,self.tire3D,self.tire4A,self.tire4B,self.tire4C,self.tire4D,self.tire5A,self.tire5B,self.tire5C,self.tire5D,self.tire6A,self.tire6B]
        
//        self.updateTireConfigData( tireViewArray: tireArray)
    }
    
    func loadDataToTire() -> Void {
        let tireArray : [TireParameterControl] = [self.tire1A,self.tire1B,self.tire2A,self.tire2B,self.tire2C,self.tire2D,self.tire3A,self.tire3B,self.tire3C,self.tire3D,self.tire4A,self.tire4B,self.tire4C,self.tire4D,self.tire5A,self.tire5B,self.tire5C,self.tire5D,self.tire6A,self.tire6B]

        
        
//        for i in 0 ... tireArray.count {
//            let tire = tireArray[i] as! TireParameterControl
//            let vehicleData = self.issueReportViewModel.vehicleDataRespnse?.vehicleData[0]
//
//            
//        }
    }
    
    
    
    
    
    //API : Get Tire TPMS Data
    func getTPMSUpdatedData() -> Void {
//        self.getTPMSVehicleDataFromAPI { (response) in
//            if  (response.isSuccess!){
//                self.updateTyreBorderColorAndTireConfigMethod()
//                let tireArray : [TireParameterControl] = [self.tire1A,self.tire1B,self.tire2A,self.tire2B,self.tire2C,self.tire2D,self.tire3A,self.tire3B,self.tire3C,self.tire3D,self.tire4A,self.tire4B,self.tire4C,self.tire4D,self.tire5A,self.tire5B,self.tire5C,self.tire5D,self.tire6A,self.tire6B]
//
//                self.updateTireData(tagInfoArray: (response.vehicleTPMSData?.tagInfo)!, tireViewArray: tireArray)
//                self.OdometerDateView.dateLbl.text = self.changeDateStandardFormatToDate(selectedDate: (response.vehicleTPMSData?.DateTime)!, formatter: .ddMMMhhmma)
//
//            }
//        }
    }
    //Method : Add Tap Gesture On Tire view And Odometer Label
    func addTapGestureOnTireView() {
        
       
        let tire1Atap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tire1A.addGestureRecognizer(tire1Atap)
        let tire1Btap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tire1B.addGestureRecognizer(tire1Btap)
        let tire2Atap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tire2A.addGestureRecognizer(tire2Atap)
        let tire2Btap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tire2B.addGestureRecognizer(tire2Btap)
        let tire2Ctap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tire2C.addGestureRecognizer(tire2Ctap)
        let tire2Dtap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tire2D.addGestureRecognizer(tire2Dtap)
        let tire3Atap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tire3A.addGestureRecognizer(tire3Atap)
        let tire3Btap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tire3B.addGestureRecognizer(tire3Btap)
        let tire3Ctap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tire3C.addGestureRecognizer(tire3Ctap)
        let tire3Dtap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tire3D.addGestureRecognizer(tire3Dtap)
        let tire4Atap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tire4A.addGestureRecognizer(tire4Atap)
        let tire4Btap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tire4B.addGestureRecognizer(tire4Btap)
        let tire4Ctap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tire4C.addGestureRecognizer(tire4Ctap)
        let tire4Dtap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tire4D.addGestureRecognizer(tire4Dtap)
        let tire5Atap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tire5A.addGestureRecognizer(tire5Atap)
        let tire5Btap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tire5B.addGestureRecognizer(tire5Btap)
        let tire5Ctap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tire5C.addGestureRecognizer(tire5Ctap)
        let tire5Dtap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tire5D.addGestureRecognizer(tire5Dtap)
        let tire6Atap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tire6A.addGestureRecognizer(tire6Atap)
        let tire6Btap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tire6B.addGestureRecognizer(tire6Btap)
       
        
        tire1A.isUserInteractionEnabled = true
        tire1B.isUserInteractionEnabled = true
        tire2A.isUserInteractionEnabled = true
        tire2B.isUserInteractionEnabled = true
        tire2C.isUserInteractionEnabled = true
        tire2D.isUserInteractionEnabled = true
        tire3A.isUserInteractionEnabled = true
        tire3B.isUserInteractionEnabled = true
        tire3C.isUserInteractionEnabled = true
        tire3D.isUserInteractionEnabled = true
        tire4A.isUserInteractionEnabled = true
        tire4B.isUserInteractionEnabled = true
        tire4C.isUserInteractionEnabled = true
        tire4D.isUserInteractionEnabled = true
        tire5A.isUserInteractionEnabled = true
        tire5B.isUserInteractionEnabled = true
        tire5C.isUserInteractionEnabled = true
        tire5D.isUserInteractionEnabled = true
        tire6A.isUserInteractionEnabled = true
        tire6B.isUserInteractionEnabled = true
      
    }
    //Method : Handel Tap Gesture From Tire View
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let masterViewController = storyBoard.instantiateViewController(withIdentifier:"VehicleVC1") as! VehicleVC
        self.navigationController?.pushViewController(masterViewController, animated: true)
    }
    //Method : Handel Tap gesture From Odometer Label
   
    
    
    override func viewDidLayoutSubviews() {
//        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.bounds.height)
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

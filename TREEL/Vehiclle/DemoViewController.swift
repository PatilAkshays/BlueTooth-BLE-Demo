//
//  DemoViewController.swift
//  TREEL
//
//  Created by Treel Mobility  on 23/04/19.
//  Copyright © 2019 Treel Mobility . All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
class DemoViewController: BaseViewController {

    @IBOutlet weak var tireView1: CircularProgress!
    @IBOutlet weak var tireView2: CircularProgress!
    
    
    @IBOutlet weak var tempLbl1: UILabel!
    @IBOutlet weak var tempLbl2: UILabel!
    @IBOutlet weak var pressureLbl1: UILabel!
    @IBOutlet weak var pressureLbl2: UILabel!

    var timer1 = Timer()
    var timer2 = Timer()

    var isTire1Animated : Int = 0
    var isTire2Animated : Int = 0
    var pressure1InFloat : Float = 0.0
    var pressure2InFloat : Float = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        BLEManager.sharedManager.delegate = self
        tireView1.tag = 1
        tireView2.tag = 1
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tempLbl1.text = "-- °C"
        self.pressureLbl1.text = "-- PSI"
        self.tempLbl2.text = "-- °C"
        self.pressureLbl2.text = "-- PSI"
       
        self.tireView1.progressColor = .green
        self.tireView2.progressColor = .green
       
        self.tireView1.trackColor = .gray
        self.tireView2.trackColor = .gray
        
        ///*
//        let tireTag1 = UserDefaults.standard.value(forKey: "tireTag1") as! LogicareTreelTag
            let tireTag1 = AppDelegate.shared!.tireTag1

            if tireTag1.macID == .treelTag1{
    
                if tireTag1.temperature != "" && tireTag1.temperature != "-"{
                    self.tempLbl1.text =  tireTag1.temperature + " °C"
                }else{
                    self.tempLbl1.text = "-- °C"
                }
                if tireTag1.pressure != "" && tireTag1.pressure != "-"{
                    self.pressureLbl1.text =  tireTag1.pressure + " PSI"
                }else{
                    self.pressureLbl1.text = "-- PSI"
                }
                pressure1InFloat = Float(tireTag1.pressure)!
                pressure1InFloat = pressure1InFloat / 100;
                if self.isTire1Animated == 0 {
                    self.isTire1Animated = 1
                    self.perform(#selector(animateProgress1), with: nil, afterDelay: 0.3)
                }else{
                    self.tireView1.setProgressWithAnimation(duration: 1.0, value: pressure1InFloat)
                }
                self.checkRecommendedPressureAndTempWithValue(temp: tireTag1.temperature, pressure: tireTag1.pressure)
                
            }
        
//        let tireTag2 = UserDefaults.standard.value(forKey: "tireTag2") as! LogicareTreelTag
        let tireTag2 = AppDelegate.shared!.tireTag2

            if tireTag2.macID == .treelTag2{
              
                if tireTag2.temperature != "" && tireTag2.temperature != "-"{
                    self.tempLbl2.text =  tireTag2.temperature + " °C"
                }else{
                    self.tempLbl2.text = "-- °C"
                }
                if tireTag2.pressure != "" && tireTag2.pressure != "-"{
                    self.pressureLbl2.text =  tireTag2.pressure + " PSI"
                }else{
                    self.pressureLbl2.text = "-- PSI"
                }
                pressure2InFloat = Float(tireTag2.pressure)!
                pressure2InFloat = pressure2InFloat / 100;
                
                
                
                if self.isTire2Animated == 0 {
                    self.isTire2Animated = 1
                    self.perform(#selector(animateProgress2), with: nil, afterDelay: 0.3)
                }else{
                    self.tireView2.setProgressWithAnimation(duration: 1.0, value: pressure2InFloat)
                }
                
                if tireTag2.eventFlag == "01"{
                    self.showAlert(msg: "Tire Removal Alert.")
                    self.checkRecommendedPressureAndTempWithValue2(temp: tireTag2.temperature, pressure: tireTag2.pressure)
                    
                }else{
                    timer2.invalidate()
                    self.tireView2.progressColor = .green
                    self.tireView2.trackColor = .gray
                }
            }
//    */
        
//        pressure1InFloat = 30
//        pressure1InFloat = pressure1InFloat / 100;
//        if self.isTire1Animated == 0 {
//            self.isTire1Animated = 1
//            self.perform(#selector(animateProgress1), with: nil, afterDelay: 0.3)
//        }else{
//            self.tireView1.setProgressWithAnimation(duration: 1.0, value: pressure1InFloat)
//        }
//        self.checkRecommendedPressureAndTempWithValue(temp: "29", pressure: "17")
//
        
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
@available(iOS 11.0, *)
extension DemoViewController: BLEManagerProtocol {
    
    func onTreelDeviceDetected(treelTags: Array<LogicareTreelTag>) {
        print("tag Data: ",treelTags)
        for tag in treelTags {
            if tag.macID == .treelTag1{
//                self.tireTag1 = tag
//                UserDefaults.standard.removeObject(forKey: "tireTag1")
//                UserDefaults.standard.set(tag, forKey: "tireTag1")
                AppDelegate.shared!.tireTag1 = tag;
                
                if tag.temperature != "" && tag.temperature != "-"{
                    self.tempLbl1.text =  tag.temperature + " °C"
                }else{
                    self.tempLbl1.text = "-- °C"
                }
                if tag.pressure != "" && tag.pressure != "-"{
                    self.pressureLbl1.text =  tag.pressure + " PSI"
                }else{
                    self.pressureLbl1.text = "-- PSI"
                }
               pressure1InFloat = Float(tag.pressure)!
                pressure1InFloat = pressure1InFloat / 100;
                if self.isTire1Animated == 0 {
                    self.isTire1Animated = 1
                    self.perform(#selector(animateProgress1), with: nil, afterDelay: 0.3)
                }else{
                    self.tireView1.setProgressWithAnimation(duration: 1.0, value: pressure1InFloat * 2)
                }
                self.checkRecommendedPressureAndTempWithValue(temp: tag.temperature, pressure: tag.pressure)
               
            }else if tag.macID == .treelTag2{

                AppDelegate.shared!.tireTag2 = tag;

                if tag.temperature != "" && tag.temperature != "-"{
                    self.tempLbl2.text =  tag.temperature + " °C"
                }else{
                    self.tempLbl2.text = "-- °C"
                }
                if tag.pressure != "" && tag.pressure != "-"{
                    self.pressureLbl2.text =  tag.pressure + " PSI"
                }else{
                    self.pressureLbl2.text = "-- PSI"
                }
              pressure2InFloat = Float(tag.pressure)!
                pressure2InFloat = pressure2InFloat / 100;



                if self.isTire2Animated == 0 {
                    self.isTire2Animated = 1
                    self.perform(#selector(animateProgress2), with: nil, afterDelay: 0.3)
                }else{
                    self.tireView2.setProgressWithAnimation(duration: 1.0, value: pressure2InFloat * 2)
                }

                // Hexadecimal to binary
                let b4 = String(Int(tag.eventFlag, radix: 16)!, radix: 2)

                let last1 = String(b4.characters.suffix(1))

                print("last1 = ",last1) //

                if last1 == "1"{
                    self.showAlert(msg: "Tire Removal Alert on Tire 2")
                    self.checkRecommendedPressureAndTempWithValue2(temp: tag.temperature, pressure: tag.pressure)

                }else{
                    timer2.invalidate()
                    self.tireView2.progressColor = .green
                    self.tireView2.trackColor = .gray
                }
            }else{
                
            }
        }
        
        
        //        self.treelTags = treelTags
    }
    
    func checkRecommendedPressureAndTempWithValue(temp : String , pressure : String) -> Void {
        let pressureInt = Int(pressure)!
        if pressureInt > String.maxPressure || pressureInt < String.minPressure {
            if pressureInt > String.maxPressure {
                self.showAlert(msg: "High Pressure Alert on Tire 1")

            }else{
                self.showAlert(msg: "Low Pressure Alert on Tire 1")

            }
            

            timer1.invalidate()
            timer1 = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { _ in
                if self.tireView1.tag == 1 {
                    self.tireView1.tag = 2
                    self.tireView1.progressColor = .red
                    if pressureInt == 0{
                        self.tireView1.trackColor = .red
                    }
                }
                else{
                    self.tireView1.tag = 1
                    if pressureInt == 0{
                        self.tireView1.trackColor = .gray
                    }
                    self.tireView1.progressColor = .gray
                }
            })
        }else{
            timer1.invalidate()
            self.tireView1.progressColor = .green

        }
    }
    
    func checkRecommendedPressureAndTempWithValue2(temp : String , pressure : String) -> Void {
        let pressureInt = Int(pressure)!
        if pressureInt > String.maxPressure || pressureInt < String.minPressure {
            timer2.invalidate()
            timer2 = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { _ in
                if self.tireView2.tag == 1 {
                    self.tireView2.tag = 2
                    
                    self.tireView2.progressColor = .red
                    if pressureInt == 0{
                        self.tireView2.trackColor = .red
                    }
                }
                else{
                    self.tireView2.tag = 1
                    if pressureInt == 0{
                        self.tireView2.trackColor = .gray
                    }
                    self.tireView2.progressColor = .gray
                }
            })
        }else{
            timer2.invalidate()
            self.tireView2.progressColor = .green
            
        }
    }
    
    
    
    @objc func animateProgress1() {
       
        self.tireView1.setProgressWithAnimation(duration: 1.0, value: pressure1InFloat * 2)
    }
    @objc func animateProgress2() {
        self.tireView2.setProgressWithAnimation(duration: 1.0, value: pressure2InFloat * 2)
    }
    
}




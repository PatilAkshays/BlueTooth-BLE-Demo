//
//  VehicleVC.swift
//  TREEL
//
//  Created by Treel Mobility  on 23/04/19.
//  Copyright © 2019 Treel Mobility . All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
class VehicleVC: BaseViewController, ChartDelegate {
    // Chart delegate
    
    func didTouchChart(_ chart: Chart, indexes: Array<Int?>, x: Double, left: CGFloat) {
        for (seriesIndex, dataIndex) in indexes.enumerated() {
            if let value = chart.valueForSeries(seriesIndex, atIndex: dataIndex) {
                print("Touched series: \(seriesIndex): data index: \(dataIndex!); series value: \(value); x-axis value: \(x) (from left: \(left))")
            }
        }
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        
    }
    
    @IBOutlet weak var chartTemp: Chart!
    @IBOutlet weak var chartPressure: Chart!

    @IBOutlet var viewModel: TireViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        chartTemp.delegate = self
        loadTempGraph(data: [0])
        loadPressureGraph(data: [0])
        fetchIssueReportData()
        // Do any additional setup after loading the view.
    }
    
    func loadTempGraph(data :  [Double] ) -> Void {
//        let data: [Double] = [0, 23, 20, 30, 35, 40, 10]
        
        let series = ChartSeries(data)
        series.colors = (
            above: ChartColors.greenColor(),
            below: ChartColors.yellowColor(),
            zeroLevel: 0
        )
        series.area = true
        
        chartTemp.add(series)
        
        // Set minimum and maximum values for y-axis
        chartTemp.minY = 0
        chartTemp.maxY = 60
        
        // Format y-axis, e.g. with units
        chartTemp.yLabelsFormatter = { String(Int($1)) +  "ºC" }
        
        chartTemp.backgroundColor = .white
    }
    
    func loadPressureGraph(data :  [Double] ) -> Void {
//        let data: [Double] = [0, 23, 20, 30, 35, 40, 10]

        let series = ChartSeries(data)
        series.colors = (
            above: ChartColors.greenColor(),
            below: ChartColors.blueColor(),
            zeroLevel: 0
        )
        series.area = true
        
        chartPressure.add(series)
        
        // Set minimum and maximum values for y-axis
        chartPressure.minY = 0
        chartPressure.maxY = 100
        
        // Format y-axis, e.g. with units
        chartPressure.yLabelsFormatter = { String(Int($1)) + "psi" }
        
        chartPressure.backgroundColor = .white
    }
    
    
    private func fetchIssueReportData() {
        if Connectivity.isConnectedToInternet(){
            //            showLoading()
            //Get all vehicles and its configurations
            self.viewModel?.vehicleDetailsRespnse(completion: {(responce) in
                
                var tempArray : [Double] = []
                var pressArray : [Double] = []
                if responce.vehicledetails != nil {
                    for item in responce.vehicledetails! {
                        if item.temp != "" && item.press != "" {
                            let tempI : Int = Int(item.temp!)!
                            let pressI : Int = Int(item.press!)!
                            let tempD : Double = Double(tempI)
                            let pressD : Double = Double(pressI)
                            tempArray.append(tempD)
                            pressArray.append(pressD)
                        }
                    }
                }
               
                
                self.loadTempGraph(data:tempArray)
                self.loadPressureGraph(data: pressArray)

            })
            
        }else{
            showAlert(msg: "Please Connect to Internet")
        }
        
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        // Redraw chart on rotation
        chartTemp.setNeedsDisplay()
        chartTemp.setNeedsDisplay()

    }
    @IBAction func pressBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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

//
//  TireViewModel.swift
//  TREEL
//
//  Created by Treel Mobility  on 24/04/19.
//  Copyright © 2019 Treel Mobility . All rights reserved.
//

import UIKit

class TireViewModel: NSObject {
    @IBOutlet var apiClient: ApiClient!
    var vehicleDataRespnse : TiresResponceModel?
    var vehicleDetailsRespnse : TempPressRespModel?

    ////MARK: Get All Vehicle Groups
    func getAllVehicleTireData(completion: @escaping (TiresResponceModel) -> Void) {
        apiClient?.getAllVehicleTireData(){
            (response) in
            DispatchQueue.main.async {
                self.vehicleDataRespnse = response
//                if self.getAllGroupSuccess(){
//
//                }else{
//                    print(self.getAllGroupSuccessMsg())
//                }
                completion(self.vehicleDataRespnse!)
            }
        }
    }
    
    
    ////MARK: Get All Vehicle Groups
    func vehicleDetailsRespnse(completion: @escaping (TempPressRespModel) -> Void) {
        apiClient?.getAllDetailData(){
            (response) in
            DispatchQueue.main.async {
                self.vehicleDetailsRespnse = response
                //                if self.getAllGroupSuccess(){
                //
                //                }else{
                //                    print(self.getAllGroupSuccessMsg())
                //                }
                completion(self.vehicleDetailsRespnse!)
            }
        }
    }
    
    
    
    
    
    func getAllGroupSuccess() -> Bool {
        
        return (vehicleDataRespnse?.isSuccess ?? false)
    }
    
    func getAllGroupSuccessMsg() -> String {
        return (vehicleDataRespnse?.msg) ?? "Unknown Error"
    }
    
    
    
}

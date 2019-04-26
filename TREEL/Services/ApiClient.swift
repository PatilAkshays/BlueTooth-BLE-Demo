//
//  ApiClient.swift
//  TMass
//
//  Created by Treel Mobility  on 26/03/19.
//  Copyright © 2019 AkshAy Patil . All rights reserved.
//


import UIKit
import Alamofire
import AlamofireObjectMapper

class ApiClient: NSObject {
    
   
    //MARK:- Get Vehicles Groups list
    func getAllVehicleTireData(completionHandler: @escaping (TiresResponceModel) -> Void ) {
        
        let url = "http://demo.tmaas.in/treel_data_lg/device_details/get_device_info_deviceid.php?DeviceID=353719092011814&deviceType=treel&MgrValue=1"
        
        let headers: HTTPHeaders = [
//            "Accept": "application/json",//This is required
//            "Content-Type": "application/json",
////            "x-access-token": UserDefaults.standard.string(forKey:.accessToken)!

            :]
        
        Alamofire.request(url, method:.get, encoding: JSONEncoding.default, headers: headers).responseObject(completionHandler: { (response: DataResponse<TiresResponceModel>) in
            switch(response.result){
            case .success:
                completionHandler(response.result.value!)
            case .failure(let error):
                print("Error ",error)
                let apiErrorResponse = TiresResponceModel()
                apiErrorResponse?.isSuccess = false
                apiErrorResponse?.msg = "Something went wrong!, Please try again later"
                completionHandler(apiErrorResponse!)
            }
        })
    }
      //MARK:- Get Vehicles Groups list
    func getAllDetailData(completionHandler: @escaping (TempPressRespModel) -> Void ) {
        
        let url = "http://demo.tmaas.in/treel_data_lg/device_details/get_graph_data.php"
        
        let headers: HTTPHeaders = [
            //            "Accept": "application/json",//This is required
            //            "Content-Type": "application/json",
            ////            "x-access-token": UserDefaults.standard.string(forKey:.accessToken)!
            
            :]
        
        Alamofire.request(url, method:.get, encoding: JSONEncoding.default, headers: headers).responseObject(completionHandler: { (response: DataResponse<TempPressRespModel>) in
            switch(response.result){
            case .success:
                completionHandler(response.result.value!)
            case .failure(let error):
                print("Error ",error)
                let apiErrorResponse = TempPressRespModel()
                apiErrorResponse?.isSuccess = false
                apiErrorResponse?.msg = "Something went wrong!, Please try again later"
                completionHandler(apiErrorResponse!)
            }
        })
    }
}






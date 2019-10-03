//
//  LogicareTreelDevice.swift
//  BLEdemo
//
//  Created by Prasanna Rege on 1/18/18.
//  Copyright © 2018 Prasanna Rege. All rights reserved.
//

import Foundation
class LogicareTreelTag: NSObject {
    var macID = ""
    var rssi = 0
    var services : Array<String> = []
    var temperature = ""
    var pressure = ""
    var battery = ""
    var eventFlag = ""
    var beaconElapsedTime = 0
    var beaconTimer: Timer?
    
    func startTimer() {
        beaconElapsedTime = 0
        beaconTimer?.invalidate()
        beaconTimer = nil
        beaconTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        beaconElapsedTime += 1
        print("beaconElapsedTime \(macID) : \(beaconElapsedTime)")
        //If tire's last status is received more than 120 seconds ago than
        //update the tire status to unavailable
        if (beaconElapsedTime >= 240) {
            BLEManager.sharedManager.tireTimeout(tagID: macID)
            stopTimer()
        }
    }
    
    func resetTimer(){
        beaconTimer?.invalidate()
        beaconElapsedTime = 0
        startTimer()
    }
    func stopTimer() {
        beaconElapsedTime = 0
        beaconTimer?.invalidate()
        beaconTimer = nil
    }
}


class TireConfiguration: NSObject {
    
    var configTableId: Int?
    var vehicelID: String?
    var vehicleRegNo: String?
    var tirePosition: String?
    var tagID : String?
    var highPressure: Int?
    var lowPressure: Int?
    var highTemp: Int?
    var serverVehicleID: String?
    var isConfigSynced: Int?
    var alerts: [Alert]?
    
}


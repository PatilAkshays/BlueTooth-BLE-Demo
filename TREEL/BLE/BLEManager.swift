//
//  BLEManager.swift
//  Treel
//
//  Created by Prasanna Rege on 2/17/18.
//  Copyright © 2018 Prasanna Rege. All rights reserved.
//

import Foundation
import CoreBluetooth
import CryptoSwift
import CoreLocation
import UserNotifications


protocol BLEManagerProtocol {
    func onTreelDeviceDetected(treelTags: Array<LogicareTreelTag>)
}
class BLEManager: NSObject {
    static let sharedManager = BLEManager()
    var treelTags = [LogicareTreelTag]()
    
    fileprivate var timer : Timer? = nil
    lazy fileprivate var locationManager:CLLocationManager = {
        
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        return locationManager
        
    }()
    fileprivate var bluetoothManager : CBCentralManager? = nil
    var delegate: BLEManagerProtocol?
    var tireConfigurations = [TireConfiguration]()
    fileprivate var beaconsIdentiferCount = 0
    //var isViewedNo : Int? = 0
    
    private override init() {
        super.init()
        
        locationManager.requestAlwaysAuthorization()
        self.updateTireConfigurations()
        //deleteSensorDetectionEventsOlderThan4Minutes()
        
        switch CLLocationManager.authorizationStatus() {
        case  .denied, .restricted:
            let alertController = UIAlertController(title: "Error", message:
                "Please, turn on location service", preferredStyle: UIAlertController.Style.alert)
            
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                let settingsUrl = URL(string: UIApplication.openSettingsURLString)
                if let url = settingsUrl {
                    UIApplication.shared.openURL(url)
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            alertController.addAction(settingsAction)
            alertController.addAction(cancelAction)
            
            var topController = UIApplication.shared.keyWindow!.rootViewController!
            while ((topController.presentedViewController) != nil) {
                topController = topController.presentedViewController!
            }
            topController.present(alertController, animated:true, completion:nil)
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
        //locationManager.delegate = self
        updateBeaconsFinder()
    }
    
    func updateBeaconsFinder() {
        for region in locationManager.rangedRegions {
            locationManager.stopRangingBeacons(in: region as! CLBeaconRegion)
            locationManager.stopMonitoring(for: region)
        }
        findBeaconsWithUUID("ffffffff-ffff-ffff-ffff-ffffffffffe0")
    }
    
    func findBeaconsWithUUID(_ uuid: String) {
        //beaconsIdentiferCount += 1
        let region = CLBeaconRegion(proximityUUID: UUID(uuidString: uuid)!, identifier: "Treel iBeacon Identifier)")
        region.notifyEntryStateOnDisplay = true
        locationManager.startMonitoring(for: region)
        locationManager.startRangingBeacons(in: region)
        //locationManager.startUpdatingLocation()
    }
    
   
    
    func updateTireConfigurations() {
//        tireConfigurations = DatabaseManager.sharedDbManager?.fetchVehiclesConfigurationData()
        
        let tireConfig = TireConfiguration()
        tireConfig.tagID = .treelTag1
        tireConfig.highPressure = 30
        tireConfig.lowPressure = 15
        tireConfig.highTemp = 60
        tireConfig.vehicleRegNo = "1"
        tireConfigurations.append(tireConfig);
        
        let tireConfig1 = TireConfiguration()
        tireConfig1.tagID = .treelTag2
        tireConfig1.highPressure = 30
        tireConfig1.lowPressure = 15
        tireConfig1.highTemp = 60
        tireConfig1.vehicleRegNo = "2"
        tireConfigurations.append(tireConfig1);


        
        if !treelTags.isEmpty {
            for tag in treelTags {
                tag.stopTimer()
            }
            treelTags.removeAll()
        }
        
//        for configuration in tireConfigurations! {
//
//
//            if let sensorDetectionEvent = DatabaseManager.sharedDbManager?.getSensorDetectionEvent(tagID: configuration.tagID!) {
//                let tag = LogicareTreelTag()
//
//                if isSensorDataWithinLast4Minutes(lastAlertTimeStamp: sensorDetectionEvent.sensorDetectionTimestamp) {
//
//                    let sensorData = sensorDetectionEvent.sensorData.split(separator: ",")
//                    tag.pressure = String(sensorData[0])
//                    tag.temperature = String(sensorData[1])
//                    tag.battery = String(sensorData[2])
//                    tag.macID = (sensorDetectionEvent.tagID)!
//
//                    treelTags.append(tag)
//                    tag.startTimer()
//                }
//            }
//        }
        if !treelTags.isEmpty {
            delegate?.onTreelDeviceDetected(treelTags: treelTags)
        }
    }
    
    //Delete sensor detection data older than 4 minutes
//    private func deleteSensorDetectionEventsOlderThan4Minutes() {
//        print("deleteSensorDetectionEventsOlderThan4Minutes called..")
//        for configuration in tireConfigurations! {
//            if let sensorDetectionEvent = DatabaseManager.sharedDbManager?.getSensorDetectionEvent(tagID: configuration.tagID!) {
//                if !isSensorDataWithinLast4Minutes(lastAlertTimeStamp: sensorDetectionEvent.sensorDetectionTimestamp) {
//
//                    DatabaseManager.sharedDbManager?.deleteTagAlertDetectionEvents(tagID: configuration.tagID!)
//                }
//            }
//        }
//    }
    
    
    
    //Helper Functions
    func findBLE(_ needFind: Bool) {
        if needFind {
            bluetoothManager = CBCentralManager(delegate: self, queue: nil)
            
            //bluetoothManager!.delegate = self
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(BLEManager.updateBLE), userInfo: nil, repeats: true)
            updateBLE()
        } else {
            timer!.invalidate()
            timer = nil
            bluetoothManager = nil
        }
    }
    
    @objc func updateBLE() {
        var serviceUUIDs = [CBUUID]()
        serviceUUIDs.append(CBUUID.init(string: "ffe0"))
        bluetoothManager?.scanForPeripherals(withServices: serviceUUIDs, options: nil)
    }
    
    func stopScanning() {
//        timer!.invalidate()
//        timer = nil
//        bluetoothManager = nil
//        for region in locationManager.rangedRegions {
//            locationManager.stopRangingBeacons(in: region as! CLBeaconRegion)
//            locationManager.stopMonitoring(for: region)
//        }
        
    }
    
    func checkIfTagConfigured(tagMacId: String)-> TireConfiguration? {
        
        if let index = tireConfigurations.index(where: {$0.tagID == tagMacId}) {
            return tireConfigurations[index]
        }
        return nil
    }
    
    func checkIfiBeaconTagConfigured(iBeaconLastThreeByteMacID: String)-> TireConfiguration? {
        
        if let index = tireConfigurations.index(where: {($0.tagID?.hasSuffix(iBeaconLastThreeByteMacID))! }) {
            return tireConfigurations[index]
        }
        return nil
    }
    
    func tireTimeout(tagID: String) {
        if let index = treelTags.index(where: {$0.macID == tagID}) {
            treelTags.remove(at: index)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tireTimeout"), object: nil, userInfo: ["macID": "\(tagID)"])
        }
    }
}

func stringsFromUUIDs(_ idArray:NSArray) throws ->[String]{
    var idStringArray = [String]()
    for uuid in (idArray as NSArray as [AnyObject]) {
        let objUUID = uuid as? CBUUID
        let idStr = objUUID!.uuidString
        idStringArray.append(idStr)
    }
    return idStringArray
    
}

func fillParsedData(advertisementData: [String : Any], tag: LogicareTreelTag) {
    if let manufacturerData = advertisementData["kCBAdvDataManufacturerData"] as? Data {
        
        if(manufacturerData.count >= 22) {
            
            let macIDRange:Range<Int> = 0..<6
            let temperatureRange:Range<Int> = 1..<3
            let pressureRange:Range<Int> = 3..<5
            let batteryRange:Range<Int> = 5..<6

            let eventFlagRange:Range<Int> = 6..<7
            let measurementPayloadRange:Range<Int> = 6..<22
            
            let macID = manufacturerData.subdata(in: macIDRange)
            
            let measurementPayloadData = manufacturerData.subdata(in: measurementPayloadRange)
            
            if let decryptedData = decrypt(encryptedData: measurementPayloadData, macID: macID) {
                
                //Return when decrypted data is invalid
                if decryptedData.count < 16 {
                    return
                }
                
                var temperature = decryptedData.subdata(in: temperatureRange)
                temperature = getLsbMsbData(data: temperature)
                
                var pressure = decryptedData.subdata(in: pressureRange)
                pressure = getLsbMsbData(data: pressure)
                let battery = decryptedData.subdata(in: batteryRange)
               
                let eventFlag = decryptedData.subdata(in: eventFlagRange)
//                print("eventFlag" , calculateCounter(hexString: (eventFlag.hexEncodedString())))
//                print("eventFlag111" , eventFlag.toHexString())

                
                tag.macID = macID.hexEncodedString()
                tag.temperature = calculateTemperature(hexString: (temperature.hexEncodedString()))
                tag.pressure = calculatePressure(hexString:(pressure.hexEncodedString()))
                tag.battery = calculateCounter(hexString: (battery.hexEncodedString()))
                tag.eventFlag = eventFlag.toHexString()
            }
        }
    }
}



private func getLsbMsbData(data: Data) -> Data {
    let tempLsb = data.subdata(in: 1..<2)
    let tempMsb = data.subdata(in: 0..<1)
    var lsbMsb = Data()
    lsbMsb.append(tempLsb)
    lsbMsb.append(tempMsb)
    return lsbMsb
}

private func decrypt(encryptedData: Data, macID: Data) -> Data? {
    let key = "#@Trl2018-lespl$"
    let keyData = key.data(using: .utf8)!
    do {
        let aes = try AES(key: (keyData.bytes), blockMode: .ECB) // aes128
        let decryptedData = try aes.decrypt(encryptedData.bytes)
        return Data(decryptedData)
    } catch {
        print(error)
    }
    return nil
}
private func decimalToHexString(decimal: Int) -> String {
    return String(format:"%04X",  arguments: [decimal])
}


private func calculatePressure(hexString: String) -> String {
    if let value = UInt16(hexString, radix: 16) {
        return String(value/100)
    } else {
        return "N/A"
    }
}

private func parsePressure(hexString: String) -> String {
    if let value = UInt16(hexString, radix: 16) {
        return String(value)
    } else {
        return "N/A"
    }
}

private func calculateTemperature(hexString: String) -> String {
    if let value = UInt16(hexString, radix: 16) {
        var temperature: Int
        if value <= 32768 {
            temperature = Int(value/100)
            
        } else {
            temperature = -(Int((value - 32768)/100))
        }
        return String(temperature)
        
    } else {
        return "N/A"
    }
}

private func calculateBattery(hexString: String) -> String {
    print("Battery : \(hexString)")
    if let value = UInt8(hexString, radix: 16) {
        return String(value)
    } else {
        return "N/A"
    }
}

private func calculateCounter(hexString: String) -> String {
    return String(describing: UInt16(hexString, radix: 16)!)
    
}


extension Data {
    
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }
    
    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        
        let hexDigits = Array("0123456789ABCDEF".utf16)
        var chars: [unichar] = []
        chars.reserveCapacity(2 * count)
        for byte in self {
            chars.append(hexDigits[Int(byte / 16)])
            chars.append(hexDigits[Int(byte % 16)])
        }
        return String(utf16CodeUnits: chars, count: chars.count)
    }
    
    
}
extension String {
    
    /// Create `Data` from hexadecimal string representation
    ///
    /// This takes a hexadecimal representation and creates a `Data` object. Note, if the string has any spaces or non-hex characters (e.g. starts with '<' and with a '>'), those are ignored and only hex characters are processed.
    ///
    /// - returns: Data represented by this hexadecimal string.
    
    func hexadecimal() -> Data? {
        var data = Data(capacity: count / 2)
        
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSMakeRange(0, utf16.count)) { match, flags, stop in
            let byteString = (self as NSString).substring(with: match!.range)
            var num = UInt8(byteString, radix: 16)!
            data.append(&num, count: 1)
        }
        
        guard data.count > 0 else { return nil }
        
        return data
    }
}

extension BLEManager : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        /*
//        if (DatabaseManager.sharedDbManager?.getCurrentUsersUserID() == -1) {
//            return
//        }
        for beacon in beacons {
            
            //print("Beacon detected: \(beacon.major)")
            DispatchQueue.main.async {
                
                let majorInHex = decimalToHexString(decimal: Int(truncating: beacon.major))
                
                let majorInData = majorInHex.hexadecimal()
                
                let minorInHex = decimalToHexString(decimal: Int(truncating: beacon.minor))
                
                let minorInData = minorInHex.hexadecimal()
                
                let macIDInMinorRange:Range<Int> = 0..<1
                let pressureInMinorRange:Range<Int> = 1..<2
                
                let macIDInMinor = minorInData?.subdata(in: macIDInMinorRange)
                
                var newMacID = Data()
                newMacID.append(majorInData!)
                newMacID.append(macIDInMinor!)
                
                let macIDInHexString = newMacID.toHexString().uppercased()
                
                
                let pressure = parsePressure(hexString: (minorInData?.subdata(in: pressureInMinorRange).toHexString())!)
                
                print("BEACON Detected : \(macIDInHexString)")
                let tireConfiguration: TireConfiguration?
                if let configuration = self.checkIfiBeaconTagConfigured(iBeaconLastThreeByteMacID: macIDInHexString) {
                    tireConfiguration = configuration
                } else {
                    return
                }
                
                let tag = LogicareTreelTag()
                
                //tag.uuid = beacon.proximityUUID.uuidString
                tag.pressure = pressure
                tag.temperature = "0"
                tag.battery = "-0"
                tag.macID = (tireConfiguration?.tagID)!
                //print("Beacon detected: \(tag.macID) Pressure: \(pressure)")
                if let index = self.treelTags.index(where: {$0.macID == tag.macID}) {
                    self.treelTags[index].stopTimer()
                    tag.temperature = self.treelTags[index].temperature
                    tag.battery = self.treelTags[index].battery
                    tag.resetTimer()
                    self.treelTags[index] = tag
                    
                } else {
                    tag.startTimer()
                    self.treelTags.append(tag)
                }
                
                self.delegate?.onTreelDeviceDetected(treelTags: self.treelTags)
                
//                self.showAlertIfRequired(configuration: tireConfiguration!, tag: tag)
            }
        }
 */
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Failed monitoring region: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        
        print("Beacon monitoring..")
        
        if (AppDelegate.shared?.inBackground)! {
            DispatchQueue.main.async {
                AppDelegate.shared?.extendBackgroundRunningTime()
                // updateBeaconsFinder()
                self.findBLE(true)
                //                DatabaseManager.sharedDbManager?.logBeacon(time: self.getTodayString())
            }
            
        }
        
    }
    
    
    
}

//  # MARK : TreelBLE Info

extension BLEManager : CBCentralManagerDelegate {
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        print("State -- \(central.state)")
        
        switch (central.state) {
        case .poweredOff:
            print("CoreBluetooth BLE hardware is powered off");
            break;
        case .poweredOn:
            print("CoreBluetooth BLE hardware is powered on and ready");
            break;
        case .resetting:
            print("CoreBluetooth BLE hardware is resetting");
            break;
        case .unauthorized:
            print("CoreBluetooth BLE state is unauthorized");
            break;
        case .unknown:
            print("CoreBluetooth BLE state is unknown");
            break;
        case .unsupported:
            print("CoreBluetooth BLE hardware is unsupported on this platform");
            break;
        }
    }
    
    @available(iOS 9.1.0, *)
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//        if (DatabaseManager.sharedDbManager?.getCurrentUsersUserID() == -1) {
//            return
//        }
        let tag = LogicareTreelTag()
        let tireConfiguration: TireConfiguration?
        //tag.uuid = peripheral.identifier.uuidString
        fillParsedData(advertisementData: advertisementData, tag: tag)
        if(tag.macID == "") {
            return
        }
        print("BLE Detected : \(tag.macID)")
        
        if tag.macID == .treelTag2 {
            
        }
        if let configuration = self.checkIfTagConfigured(tagMacId: tag.macID) {
            tireConfiguration = configuration
        } else {
            return
        }
        
        if let index = treelTags.index(where: {$0.macID == tag.macID}) {
            self.treelTags[index].stopTimer()
            tag.resetTimer()
            treelTags[index] = tag
        } else {
            tag.startTimer()
            treelTags.append(tag)
        }
        DispatchQueue.main.async {
            self.delegate?.onTreelDeviceDetected(treelTags: self.treelTags)
            
//            self.showAlertIfRequired(configuration: tireConfiguration!, tag: tag)
        }
        
    }
    
    private func showAlertIfRequired(configuration: TireConfiguration, tag: LogicareTreelTag) {
        let sensorData = "\(tag.pressure),\(tag.temperature),\(tag.battery)"
//        DatabaseManager.sharedDbManager?.saveSensorLastDetectionEvent(tagID: tag.macID, sensorData: sensorData, timeStamp: getTodayString())
        
        if(Int(tag.pressure)! < configuration.lowPressure!) {
            isAlertTimeout(tagID: tag.macID, alertType: AlertType.LOW_PRESSURE) {
//                self.showAlert(alertType: AlertType.LOW_PRESSURE, configuration: configuration, tireValue: tag.pressure)
            }
        } else if(Int(tag.pressure)! > configuration.highPressure!) {
            isAlertTimeout(tagID: tag.macID, alertType: AlertType.HIGH_PRESSURE) {
//                self.showAlert(alertType: AlertType.HIGH_PRESSURE, configuration: configuration, tireValue: tag.pressure)
            }
        }
        
        if(Int(tag.temperature)! > configuration.highTemp!) {
            isAlertTimeout(tagID: tag.macID, alertType: AlertType.HIGH_TEMPERATURE) {
//                self.showAlert(alertType: AlertType.HIGH_TEMPERATURE, configuration: configuration, tireValue: tag.temperature)
            }
        }
    }
    
    private func isAlertTimeout(tagID: String, alertType: AlertType, completion: @escaping () -> Void) {
        var lastAlertDetectionTimestamp: String?
        switch alertType {
        case AlertType.LOW_PRESSURE:
//            lastAlertDetectionTimestamp = DatabaseManager.sharedDbManager?.getLastLowPressureAlertDetectionEvent(tagID: tagID)
//            DatabaseManager.sharedDbManager?.saveLowPressureAlertDetectionEvent(tagID: tagID, timeStamp: getTodayString())
            break
        case AlertType.HIGH_PRESSURE:
//            lastAlertDetectionTimestamp = DatabaseManager.sharedDbManager?.getLastHighPressureAlertDetectionEvent(tagID: tagID)
//            DatabaseManager.sharedDbManager?.saveHighPressureAlertDetectionEvent(tagID: tagID, timeStamp: getTodayString())
            break
        case AlertType.HIGH_TEMPERATURE:
//            lastAlertDetectionTimestamp = DatabaseManager.sharedDbManager?.getLastHighTemperatureAlertDetectionEvent(tagID: tagID)
//            DatabaseManager.sharedDbManager?.saveHighTemperatureAlertDetectionEvent(tagID: tagID, timeStamp: getTodayString())
            break
        default:
            print("Ignore Alert")
        }
        if let timeStamp = lastAlertDetectionTimestamp {
            if (isTimeoutHappend(lastAlertTimeStamp: timeStamp)) {
                completion()
            }
        } else {
            completion()
        }
        
    }
    
    private func isTimeoutHappend(lastAlertTimeStamp: String)-> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let fromTime = dateFormatter.date(from: lastAlertTimeStamp)
        
        let now = getTodayString()
        let toTime = dateFormatter.date(from: now)
        
        let difference = Calendar.current.dateComponents([.second], from: fromTime!, to: toTime!)
        
        return difference.second! > (10 * 60)
    }
    
    private func isSensorDataWithinLast4Minutes(lastAlertTimeStamp: String)-> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let fromTime = dateFormatter.date(from: lastAlertTimeStamp)
        
        let now = getTodayString()
        let toTime = dateFormatter.date(from: now)
        
        let difference = Calendar.current.dateComponents([.second], from: fromTime!, to: toTime!)
        
        return difference.second! <= (4 * 60)
    }
    
    /*
    private func showAlert(alertType: AlertType, configuration: TireConfiguration, tireValue: String) {
        if let vehicle = DatabaseManager.sharedDbManager?.fetchVehicleDetails(registrationNum: configuration.vehicleRegNo!){
            var notificationID = 0
            let vehicleType = vehicle.vehicleTyp!
            let vehicleRegNo = vehicle.registrationNo!
            let tirePosition = configuration.tirePosition!
            var vehicleTirePosition: String?
            if(vehicleType != "Bike") {
                switch tirePosition {
                case "1A":
                    vehicleTirePosition = "Front Left"
                case "1B":
                    vehicleTirePosition = "Front Right"
                case "2A":
                    vehicleTirePosition = "Rear Left"
                case "2B":
                    vehicleTirePosition = "Rear Right"
                default:
                    vehicleTirePosition = "Stepney"
                }
            } else {
                switch tirePosition {
                case "1A":
                    vehicleTirePosition = "Front"
                case "2A":
                    vehicleTirePosition = "Rear"
                default:
                    vehicleTirePosition = "Front"
                }
            }
            
            var alertLabel: String?
            var alertMsg: String?
            
            switch alertType {
            case AlertType.LOW_PRESSURE:
                //Generating a unique notification identifier which will be used to replace the existing notification for the same tyre's same type of notification. This will prevent from generating duplicate notifications
                notificationID = configuration.configTableId! * 100 + 1 * 10
                alertLabel = "Low Pressure Alert! - \(String(describing: tireValue)) PSI"
                alertMsg = """
                           \(String(describing: vehicleTirePosition!)) Tyre.
                           Please refill air at the nearest gas station.
                           Save on precious fuel!
                           """
           
                break
            case AlertType.HIGH_PRESSURE:
                 //Generating a unique notification identifier which will be used to replace the existing notification for the same tyre's same type of notification. This will prevent from generating duplicate notifications
                notificationID = configuration.configTableId! * 100 + 2 * 10
                alertLabel = "High Pressure Alert! - \(String(describing: tireValue)) PSI"
                alertMsg = """
                           \(String(describing: vehicleTirePosition!)) Tyre.
                           Please slow down or stop your vehicle and avoid a tyre burst!
                           """
                //alertMsg = "\(String(describing: vehicleTirePosition!)) tire of your vehicle has \(String(describing: alertLabel!)). Kindly check."
                break
            case AlertType.HIGH_TEMPERATURE:
                 //Generating a unique notification identifier which will be used to replace the existing notification for the same tyre's same type of notification. This will prevent from generating duplicate notifications
                notificationID = configuration.configTableId! * 100 + 3 * 10
                alertLabel = "Ahoy! High Temperate Alert! - \(String(describing: tireValue)) °C"
                alertMsg = """
                           \(String(describing: vehicleTirePosition!)) Tyre.
                           Your tyres are overheated.
                           Take a break, cool down and avoid a tyre burst!
                           """
                //alertMsg = "\(String(describing: vehicleTirePosition!)) tire of your vehicle has \(String(describing: alertLabel!)). Kindly check."
                break
                
            default:
                alertLabel = "Ahoy! High Temperate Alert! - \(String(describing: tireValue)) °C"
                alertMsg = """
                           \(String(describing: vehicleTirePosition!)) Tyre.
                           Your tyres are overheated.
                           Take a break, cool down and avoid a tyre burst!
                           """
                
            }
            
            
            //Saving Alert to Database
            
            let today = getTodayString()
            let titleName = "\(vehicleRegNo) : \(String(describing: alertLabel!))"
            let titleNameForDB = "\(alertLabel!)"
            
            let message = """
                          \(titleNameForDB)
                          \(String(describing: alertMsg!))
                          """
            
            DatabaseManager.sharedDbManager?.saveAlerts(vehicleRegNo: vehicleRegNo, tagId: configuration.tagID, alertType: String(describing: alertType), alertMessage: message, timeStamp: today, isViewed: 0)
            
            //Notification to update count
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateNotificationCount"),object: nil)
            
            //Fire notification for alert
            showNotificationAlert(alertMsg: alertMsg!, vehicleRegNo: titleName, userInfo: vehicleRegNo, notificationID: notificationID)
       
        
        }else{
            return
        }
    
    }*/

    //Function to get current date and time
    func getTodayString() -> String{
        
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
        
        return today_string
        
    }
    
    
    private func showNotificationAlert(alertMsg: String, vehicleRegNo: String, userInfo:String, notificationID: Int) {
        

            let id_Name = String(notificationID)
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey: vehicleRegNo, arguments: nil)
            content.body = NSString.localizedUserNotificationString(forKey: alertMsg,arguments: nil)
        content.sound = UNNotificationSound.default
            content.categoryIdentifier = vehicleRegNo
            content.userInfo = ["vehicleRegNo": "\(userInfo)"]
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            // Create the request object.
            let request = UNNotificationRequest(identifier:id_Name, content: content, trigger: trigger)
            
            let center = UNUserNotificationCenter.current()
            center.add(request) { (error : Error?) in
                if let theError = error {
                    print(theError.localizedDescription)
                }
            }
            

    }
}

enum AlertType : Int {
    case LOW_PRESSURE
    case HIGH_PRESSURE
    case HIGH_TEMPERATURE
    case ROTATION_ALERT
    case REMINDER_ALERT
}

class Alert {
    var alertType: AlertType?
    var alertMsg: String?
    var alertTime: String?
    var vehicleRegistrationNo: String?
    
}

extension BLEManager: UNUserNotificationCenterDelegate {
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Update the app interface directly.
        
        // Play a sound.
        completionHandler(UNNotificationPresentationOptions.sound)
    }
}


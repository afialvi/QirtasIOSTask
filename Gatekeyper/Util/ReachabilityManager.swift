//
//  ReachabilityManager.swift
//  Gatekeyper
//
//  Created by Qirtas on 19/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import Foundation
import UIKit
import ReachabilitySwift
import SystemConfiguration


protocol ReachabilityDelegate:class{
    func networkAvailable()
    func networkNotAvailable()
}

class ReachabilityManager: NSObject {
    //Boolean to track network reachability
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .notReachable
    }
    
    // Tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
    var reachabilityStatus: Reachability.NetworkStatus = .notReachable
    
    let reachability = Reachability()!
    
    var delegate:ReachabilityDelegate?
    
    init(delegate:ReachabilityDelegate) {
        self.delegate = delegate
    }
    
    @objc func reachabilityChanged(notification: Notification) {
        let reachability = notification.object as! Reachability
        print("reachabilityChanged reachability.isReachable \(reachability.isReachable)")
        
        switch reachability.currentReachabilityStatus {
        case .notReachable:
            debugPrint("Network became unreachable")
            delegate?.networkNotAvailable()
        case .reachableViaWiFi:
            debugPrint("Network reachable through WiFi")
            delegate?.networkAvailable()
        case .reachableViaWWAN:
            debugPrint("Network reachable through Cellular Data")
            delegate?.networkAvailable()
        }
    }
    
//    @objc func reachabilityChanged(notification: Notification) {
//        let reachability = notification.object as! Reachability
//        switch reachability.currentReachabilityStatus {
//        case .notReachable:
//            debugPrint("Network became unreachable")
//            delegate?.networkNotAvailable()
//        case .reachableViaWiFi:
//            debugPrint("Network reachable through WiFi")
//            delegate?.networkAvailable()
//        case .reachableViaWWAN:
//            debugPrint("Network reachable through Cellular Data")
//            delegate?.networkAvailable()
//        }
//    }
    
    /// Starts monitoring the network availability status
    func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: ReachabilityChangedNotification,
                                               object: reachability)
        do{
            try reachability.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }
    
    /// Stops monitoring the network availability status
    func stopMonitoring(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: ReachabilityChangedNotification,
                                                  object: reachability)
    }
    
    
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



//
//  ViewController.swift
//  BeTheBeacon
//
//  Created by Jeff Gayle on 8/21/14.
//  Copyright (c) 2014 Jeff Gayle. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreLocation

class ViewController: UIViewController, CBPeripheralManagerDelegate {
    
    let myUUID = NSUUID(UUIDString: "7D1335F7-E5A3-4658-A189-89E145D4D49D")
    let myIdentifier = "com.jeffgayle.beacons.the_east_room"
    var region : CLBeaconRegion!
    var beaconData : NSDictionary!
    var peripheralManager : CBPeripheralManager!
    
    @IBOutlet weak var broadcastButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.region = CLBeaconRegion(proximityUUID: myUUID, identifier: myIdentifier)
        self.beaconData = region.peripheralDataWithMeasuredPower(nil)
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        println(self.peripheralManager.isAdvertising)
    }
    
    @IBAction func toggleBroadcasting(sender: UIButton!) {
        
        if self.peripheralManager.isAdvertising == false {
            
            self.peripheralManager.startAdvertising(self.beaconData)
            self.view.backgroundColor = UIColor.greenColor()
            self.broadcastButton.setTitle("Stop", forState: UIControlState.Normal)
            println(self.peripheralManager.isAdvertising)
            
        } else if self.peripheralManager.isAdvertising == true {
            
            self.peripheralManager.stopAdvertising()
            self.view.backgroundColor = UIColor.redColor()
            self.broadcastButton.setTitle("Broadcast", forState: UIControlState.Normal)
            println(self.peripheralManager.isAdvertising)
        }
        
    }
    
    //MARK: CBPeripheralManagerDelegate
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {
        if peripheral.state == CBPeripheralManagerState.PoweredOn {
            println("Started")
//            self.peripheralManager.startAdvertising(self.beaconData)
            
        } else if peripheral.state == CBPeripheralManagerState.PoweredOff {
            println("Stopped")
//            self.peripheralManager.stopAdvertising()
            
        } else if peripheral.state == CBPeripheralManagerState.Unsupported {
            self.view.backgroundColor = UIColor.grayColor()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}


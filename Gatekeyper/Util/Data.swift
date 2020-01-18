//
//  Data.swift
//  Equipment
//
//  Created by Qirtas on 12/12/2019.
//  Copyright © 2019 Qirtas. All rights reserved.
//

import UIKit

class Data: NSObject {
    static let dataJson = [
    "Equipment": [
        [
          "id": "1",
          "title": "EQ#241567",
          "VIN": "0094536786834",
          "state": "Locked",
          "action": "ENTER",
          "isUseAble": "true",
          "isEmergencyActivated": "false",
          "remainingTestAttempts": "0",
          "remainingMinutes": "0",
          "isReserved": "false",
          "reservedBy": "",
          "isBlocked": "false",
          "Aux": [
            [
              "id": "123",
              "title": "EQ#24667",
              "VIN": "009453438748",
              "state": "Unclocked",
              "action": "EXIT",
              "isUseAble": "true",
              "isEmergencyActivated": "false",
              "remainingTestAttempts": "0",
              "remainingMinutes": "0",
              "isReserved": "false",
              "reservedBy": "",
              "isBlocked": "false"
            ],
            [
              "id": "666",
              "title": "EQ#24667784",
              "VIN": "6677847872",
              "state": "Unclocked",
              "action": "EXIT",
              "isUseAble": "true",
              "isEmergencyActivated": "false",
              "remainingTestAttempts": "0",
              "remainingMinutes": "0",
              "isReserved": "false",
              "reservedBy": "",
              "isBlocked": "false"
            ]
          ]
        ],
        [
          "id": "2",
          "title": "EQ#241567",
          "VIN": "0094536786834",
          "state": "Scheduled Unlock",
          "action": "ENTER",
          "isUseAble": "true",
          "isEmergencyActivated": "false",
          "remainingTestAttempts": "0",
          "remainingMinutes": "12",
          "isReserved": "false",
          "reservedBy": "",
          "isBlocked": "false",
          "Aux": []
        ],
        [
          "id": "2",
          "title": "EQ#247937",
          "VIN": "00945364793749",
          "state": "Locked",
          "action": "Enter",
          "isUseAble": "true",
          "isEmergencyActivated": "false",
          "remainingTestAttempts": "0",
          "remainingMinutes": "0",
          "isReserved": "false",
          "reservedBy": "",
          "isBlocked": "false",
          "Aux": [
            [
              "id": "777",
              "title": "EQ#24667",
              "VIN": "009453438748",
              "state": "Unclocked",
              "action": "Exit",
              "isUseAble": "true",
              "isEmergencyActivated": "false",
              "remainingTestAttempts": "0",
              "remainingMinutes": "0",
              "isReserved": "false",
              "reservedBy": "",
              "isBlocked": "false"
            ]
          ]
        ],
        [
          "id": "3",
          "title": "EQ#24766",
          "VIN": "009453647339",
          "state": "Locked",
          "action": "Enter",
          "isUseAble": "true",
          "isEmergencyActivated": "false",
          "remainingTestAttempts": "2",
          "remainingMinutes": "0",
          "isReserved": "false",
          "reservedBy": "",
          "isBlocked": "false",
          "Aux": []
        ],
        [
          "id": "4",
          "title": "EQ#24766",
          "VIN": "009453647339",
          "state": "Unlocked",
          "action": "Enter",
          "isUseAble": "true",
          "isEmergencyActivated": "true",
          "remainingTestAttempts": "2",
          "remainingMinutes": "0",
          "isReserved": "false",
          "reservedBy": "",
          "isBlocked": "false",
          "Aux": [
            [
              "id": "123",
              "title": "EQ#24667",
              "VIN": "009453438748",
              "state": "Unclocked",
              "action": "Exit",
              "isUseAble": "true",
              "isEmergencyActivated": "false",
              "remainingTestAttempts": "0",
              "remainingMinutes": "0",
              "isReserved": "false",
              "reservedBy": "",
              "isBlocked": "false"
            ],
            [
              "id": "999",
              "title": "EQ#24333",
              "VIN": "009453438748",
              "state": "Locked",
              "action": "Exit",
              "isUseAble": "false",
              "isEmergencyActivated": "false",
              "remainingTestAttempts": "0",
              "remainingMinutes": "0",
              "isReserved": "false",
              "reservedBy": "Mike",
              "isBlocked": "false"
            ],
            [
              "id": "555",
              "title": "EQ#24222",
              "VIN": "009453498493",
              "state": "Unlocked",
              "action": "Enter",
              "isUseAble": "true",
              "isEmergencyActivated": "false",
              "remainingTestAttempts": "1",
              "remainingMinutes": "0",
              "isReserved": "false",
              "reservedBy": "",
              "isBlocked": "false"
            ]
          ]
        ],
        [
          "id": "5",
          "title": "EQ#241567",
          "VIN": "0094536786834",
          "state": "Locked",
          "action": "Enter",
          "isUseAble": "false",
          "isEmergencyActivated": "false",
          "remainingTestAttempts": "0",
          "remainingMinutes": "0",
          "isReserved": "true",
          "reservedBy": "John",
          "isBlocked": "false",
          "Aux": [
            [
              "id": "123",
              "title": "EQ#24667",
              "VIN": "009453438748",
              "state": "Unclocked",
              "action": "Exit",
              "isUseAble": "true",
              "isEmergencyActivated": "false",
              "remainingTestAttempts": "0",
              "remainingMinutes": "0",
              "isReserved": "false",
              "reservedBy": "",
              "isBlocked": "false"
            ],
            [
              "id": "666",
              "title": "EQ#24667784",
              "VIN": "6677847872",
              "state": "Unclocked",
              "action": "Exit",
              "isUseAble": "true",
              "isEmergencyActivated": "false",
              "remainingTestAttempts": "0",
              "remainingMinutes": "0",
              "isReserved": "false",
              "reservedBy": "",
              "isBlocked": "false"
            ]
          ]
        ],
        [
          "id": "6",
          "title": "EQ#241455",
          "VIN": "0094536786834",
          "state": "UnLocked",
          "action": "",
          "isUseAble": "false",
          "isEmergencyActivated": "false",
          "remainingTestAttempts": "0",
          "remainingMinutes": "0",
          "isReserved": "true",
          "reservedBy": "",
          "isBlocked": "false"
        ],
        [
          "id": "7",
          "title": "EQ#24444",
          "VIN": "877498934",
          "state": "Locked",
          "action": "",
          "isUseAble": "false",
          "isEmergencyActivated": "false",
          "remainingTestAttempts": "0",
          "remainingMinutes": "0",
          "isReserved": "false",
          "reservedBy": "",
          "isBlocked": "true"
        ],
        [
          "id": "8",
          "title": "EQ#24444",
          "VIN": "877498934",
          "state": "Schedule Locked",
          "action": "",
          "isUseAble": "false",
          "isEmergencyActivated": "false",
          "remainingTestAttempts": "0",
          "remainingMinutes": "0",
          "isReserved": "false",
          "reservedBy": "",
          "isBlocked": "false"
        ]
      ]
    ]

}

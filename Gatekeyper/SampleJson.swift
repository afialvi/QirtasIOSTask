//
//  SampleJson.swift
//  Gatekeyper
//
//  Created by Muhammad Alvi on 14/01/2020.
//  Copyright © 2020 Qirtas. All rights reserved.
//

import UIKit

class SampleJson: NSObject {

    static let data = [
      "questions": [
        [
          "id": "1",
          "text": "How is the weather today?",
          "type": "MCQ",
          "options": [
            [
              "optionId": "1",
              "title": "Hot",
              "url": ""
            ],
            [
              "optionId": "2",
              "title": "Rainy",
              "url": ""
            ],
            [
              "optionId": "3",
              "title": "Cold",
              "url": ""
            ]
          ],
          "correctOption": "2"
        ],
        [
          "id": "2",
          "text": "Did you find any evidence when completing your DVIR?",
          "type": "MCQ",
          "options": [
            [
              "optionId": "1",
              "title": "Yes",
              "url": ""
            ],
            [
              "optionId": "2",
              "title": "No",
              "url": ""
            ]
          ],
          "correctOption": "2"
        ],
        [
          "id": "3",
          "text": "What is your name?",
          "type": "Text",
          "options": [],
          "correctOption": ""
        ],
        [
          "id": "4",
          "text": "Which option showing the cat image?",
          "type": "MCQ-Image",
          "options": [
            [
              "optionId": "1",
              "title": "",
              "url": "https://homepages.cae.wisc.edu/~ece533/images/airplane.png"
            ],
            [
              "optionId": "2",
              "title": "",
              "url": "https://homepages.cae.wisc.edu/~ece533/images/cat.png"
            ],
            [
              "optionId": "3",
              "title": "",
              "url": "https://homepages.cae.wisc.edu/~ece533/images/fruits.png"
            ]
          ],
          "correctOption": "2"
        ],
        [
          "id": "3",
          "text": "Please upload the picture from your phone and add description.",
          "type": "ImageAnswer",
          "options": [],
          "correctOption": ""
        ],
        [
          "id": "3",
          "text": "What is the emergency?",
          "type": "Text",
          "options": [],
          "correctOption": ""
        ]
      ],
      "supportingMaterial": [
        [
          "id": "987",
          "title": "The first Blender Open Movie from 2006",
          "type": "video",
          "url": "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
          "thumbnail": "https://homepages.cae.wisc.edu/~ece533/images/monarch.png"
        ],
        [
          "id": "333",
          "title": "Help Image",
          "type": "image",
          "url": "https://homepages.cae.wisc.edu/~ece533/images/boat.png",
          "thumbnail": ""
        ],
        [
          "id": "777",
          "title": "Help Document",
          "type": "pdf",
          "url": "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
          "thumbnail": ""
        ]
      ]
    ]
    
}

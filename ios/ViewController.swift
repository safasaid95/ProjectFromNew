//
//  ViewController.swift
//  GcpNLPTest
//
//  Created by Mallikarjuna Jana on 3/12/20.
//  Copyright © 2020 Mallikarjuna Jana. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    let CLOUD_URL = "https://us-ce-cloudfuncfortoken.cloudfunctions.net/getOAuthToken"


//    var googleURL: URL {
//        return URL(string: "https://language.googleapis.com/v1/documents:analyzeEntities?key=\(googleAPIKey)")!
//    }
//    var GCP_CLOUD_NLP_ENT_URL = "https://language.googleapis.com/v1/documents:analyzeEntities?key=\(googleAPIKey)"

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func getOAthToken(_ sender: Any) {
                
        let parameters: [String:Any] = ["data": "hi"]
        let headers: HTTPHeaders = ["Content-Type":"application/json"]
        
        AF.request(CLOUD_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in debugPrint(response)
        }
    }
    
    @IBAction func getDocumentEntities(_ sender: Any) {
        
        let fileUrl = URL(string:"https://language.googleapis.com/v1/documents:analyzeEntities")!
        //let fileUrl = URL(string:"https://language.googleapis.com/v1/documents:analyzeEntitySentiment")!

        
        var request = URLRequest(url:fileUrl)
        request.httpMethod = "POST"
        request.addValue("Bearer ya29.c.")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        
        // Build our API request
        let jsonRequest: [String:Any] = [
            "document": [
                "type": "PLAIN_TEXT",
                "content": "Michelangelo Caravaggio, Italian painter, is known for the Calling of Saint Matthew."],
            "encodingType":"UTF8"
        ]
        let jsonObject = JSON(jsonRequest)
        
        // Serialize the JSON
        guard let data = try? jsonObject.rawData() else {
            return
        }
        
        request.httpBody = data
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            // Parse the data in the response and use it
            print(response ?? 0)
            print(JSON(data))
        })
        task.resume()
    }
}


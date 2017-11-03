//
//  Model.swift
//  ChatMan
//
//  Created by Maksim Akifev on 9/26/17.
//  Copyright © 2017 Maksim Akifev. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import Messages

class CleverBotModel {

    var input: String? = ""
    var output: String? = ""
    var cs: String? = ""
    var outputOther: String? = ""
    
    init(input: String? = nil,output: String? = nil,cs: String? = nil, outputOther: String? = nil) {
        self.input = input
        self.output = output
        self.cs = cs
        self.outputOther = outputOther
    }
    
    // MARK: Network Request
    
    func loadData(completed: @escaping ()-> ()) {
        
        let key = "CC4ktpyyb_KudZvHh1R7mvHsgPA"
        let url =  "http://www.cleverbot.com/getreply?"
        
        let parameters: Parameters = [
             "key": key,
             "input": input!,
             "cs": cs
        ]
        print("Input: \(String(describing: input))")

        Alamofire.request(url, method: .get, parameters: parameters).responseJSON(completionHandler: {
            (responseData) -> Void in
            if((responseData.result.value) != nil) {
            do {
                let data = JSON(responseData.result.value!)
                print(data)
                let interactionCount = data["interaction_count"].stringValue
                
                self.input = data["input"].stringValue
                self.output = data["output"].stringValue
                self.outputOther = data["interaction_\(interactionCount)_other"].stringValue
                self.cs = data["cs"].stringValue
                
            } catch let error as NSError {
              print(error.localizedDescription)
            }
          }
            completed()
        })
       }

}
 

 
 



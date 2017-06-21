//
//  Server.swift
//  SwiftVoiceQuickstart
//
//  Created by Vahagn Gevorgyan on 5/30/17.
//  Copyright © 2017 Twilio, Inc. All rights reserved.
//

import Foundation
import Alamofire

class Server {
    
    var twilioToken: String! {
        didSet {
            NotificationCenter.default.post(Notification(name: Notification.Name("twilioTokenIsReady")))
        }
    }
    
    let serverLink = "http://six-dev.us-west-2.elasticbeanstalk.com"
    
    func getTwilioToken() {
        DispatchQueue.global(qos: .background).async {
            
            let parameters: Parameters = [
                "identity" : "arus"
            ]
            
            let twilioToken = "/test/voiceToken"
            let requestLink = self.serverLink + twilioToken
            
            Alamofire.request(requestLink, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
                .responseJSON {response in debugPrint(response)
            
                if response.result.value != nil {
                    let json = response.result.value as! NSDictionary
                    server.twilioToken = json.value(forKey: "token") as! String
                    print("Token is found")
                } else {
                    print("Twilio token is not valid")
                    
                }
            }
            
        }
    }
    
}

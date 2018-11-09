//
//  ShowUserController.swift
//  Bizy
//
//  Created by Wolf on 11/9/18.
//  Copyright © 2018 Wolf. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class ShowUserController: UIViewController {
  
  var urlString: String!
  let parser = UserParser()
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    fetchUserData()
  }
  
  func fetchUserData() {
     DispatchQueue.main.async() {
      Alamofire.request(self.urlString).responseJSON(completionHandler: {(response) in
        switch response.result {
        case.success(let value):
            let json = JSON(value);
            self.parser.swiftyjson = json
        case.failure(let error):
          print(error.localizedDescription)
        }
      })
      }
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

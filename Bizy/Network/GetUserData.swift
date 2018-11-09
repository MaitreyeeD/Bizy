import Foundation
import Alamofire

class GetUserData {
  func fetch(urlString: String, _ completion: @escaping (Data?) -> Void) {
    
    Alamofire.request(urlString).response { response in
      if let error = response.error {
        print("Error fetching repositories: \(error)")
        completion(response.data)
        return
      }
      completion(response.data)
    }
    
  }
}

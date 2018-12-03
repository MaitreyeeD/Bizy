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
import CoreData

class ShowUserController: UIViewController {
  
  var urlString: String!
  var userData: User!
  let parser = UserParser()
  var thisuser = User(fname: "", lname: "", email: "")
  
  
  @IBOutlet var addButton: UIButton!
  @IBOutlet var declineButton: UIButton!
  
  @IBOutlet weak var firstNameLabel: UILabel!
  @IBOutlet weak var lastNameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var companyLabel: UILabel!
  @IBOutlet weak var positionLabel: UILabel!
  @IBOutlet weak var websiteLabel: UILabel!
  @IBOutlet weak var linkedInLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var stateLabel: UILabel!
  @IBOutlet weak var summaryLabel: UILabel!
  @IBOutlet weak var picture: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    fetchUserData()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
    request.returnsObjectsAsFaults = false
    
    do {
      let result = try context.fetch(request)
      for data in result as! [NSManagedObject] {
        self.loadUsers(data: data)
        //        nameData.text = thisuser.firstName
        //        emailData.text = thisuser.email
        
        
        //        print(data.value(forKey: "first_name") as! String)
        //        print(data.value(forKey: "email") as! String)
      }
      
    } catch {
      
      print("Failed")
    }
  }
  
  func fetchUserData() {
     DispatchQueue.main.async() {
      Alamofire.request(self.urlString).responseJSON(completionHandler: {(response) in
        switch response.result {
        case.success(let value):
            let json = JSON(value);
            self.parser.swiftyjson = json
            if let user = self.parser.createUser() {
                
                self.userData = user
                self.saveUser(user: self.userData)
            }
          
        case.failure(let error):
          print(error.localizedDescription)
        }
      })
      }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    populateView()
  }
  
  func populateView() {
    
    if let user = self.userData {
      firstNameLabel.text = user.firstName
      lastNameLabel.text = user.lastName
      emailLabel.text = user.email
      
      companyLabel.text = user.company ?? "Not Available"
      positionLabel.text = user.position ?? "Not Available"
      websiteLabel.text = user.website ?? "Not Available"
      linkedInLabel.text = user.linkedIn ?? "Not Available"
      cityLabel.text = user.company ?? "Not Available"
      stateLabel.text = user.state ?? "Not Available"
      summaryLabel.text = user.summary ?? "Not Available"
    }
    
  }
  
  func loadUsers(data: NSManagedObject){
    let newUser = User(fname: "", lname: "", email: "")
    newUser.firstName = (data.value(forKey: "first_name") as! String)
    newUser.lastName = (data.value(forKey: "last_name") as! String)
    newUser.email = (data.value(forKey: "email") as? String ?? "bop@gmail.com")
    newUser.id = (data.value(forKey: "id") as? String ?? "")

    thisuser = newUser
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func sendPostToWallet(_ sender: Any) {
    postToWallet()
    
    
    
    
    
    let alert = UIAlertController(
      title: self.userData!.firstName + " Added to Wallet!",
      message: "Go To Your Wallet to View Your Bizy Cards!",
      preferredStyle: .alert
    )
    
    
    alert.addAction(UIAlertAction(title: "Go To Wallet!", style: .default, handler: {(action) -> Void in
      self.performSegue(withIdentifier: "backToWallet", sender: self)
    }))
    
    self.present(alert, animated: true, completion: nil)
    
    
  }
  
  @IBAction func decline(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  //Finish with CoreData
  func postToWallet() {
    
    let parameters: Parameters = [
      "user_id": thisuser.id!,
      "contact_id": "1",
      "category": "main"
      ]
    let urlString: String = "https://desolate-springs-29566.herokuapp.com/wallets/"
    DispatchQueue.main.async() {
      Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON(completionHandler: {(response) in
        print(response.result)
      })
    }
  }
  
  func alreadySaved(id: String) -> Bool {

      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let context = appDelegate.persistentContainer.viewContext
      
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
      request.returnsObjectsAsFaults = false
      do {
        let result = try context.fetch(request)
        for data in result as! [NSManagedObject] {
          let newId = (data.value(forKey: "id") as? String ?? "")
          if (id == newId) {
            return true
          }
        }
        
      } catch {
        
        print("Failed")
      }
    return false
  }
  
  func saveUser(user: User){
    if (alreadySaved(id: user.id!) == true) {
      let alert = UIAlertController(title: "Check Again!", message: "User Is Already In Your Wallet!", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
          self.dismiss(animated: true, completion: nil)
      }))
      self.present(alert, animated: true, completion: nil)
    }
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Card", in: context)
    let newUser = NSManagedObject(entity: entity!, insertInto: context)
    newUser.setValue(user.firstName, forKey: "first_name")
    newUser.setValue(user.lastName, forKey: "last_name")
    newUser.setValue(user.email, forKey: "email")
    newUser.setValue(user.phone, forKey: "phone")
    newUser.setValue(user.company, forKey: "company")
    newUser.setValue(user.position, forKey: "position")
    newUser.setValue(user.summary, forKey: "summary")
    newUser.setValue(user.linkedIn, forKey: "linkedin")
    newUser.setValue(user.state, forKey: "state")
    newUser.setValue(user.city, forKey: "city")
    newUser.setValue(user.website, forKey: "website")
    newUser.setValue(user.id, forKey: "id")
    
    //Set RESUME AND IMAGE ------------------------------------------------------->
    //must set resume as well
    //must set image.
//    if let pic = user.image {
//      newUser.setValue(UIImagePNGRepresentation(pic), forKey: "image")
//    }
    do {
      try context.save()
    } catch {
      print("Failed saving")
    }
  }
  
  
  
  
  
}

//
//  ContactInfoController.swift
//
//
//  Created by Wolf on 12/6/18.
//

import Foundation
import UIKit
import CoreData
import ChameleonFramework
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialButtons_ButtonThemer



class ContactInfoController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var phone:UITextField!
  @IBOutlet weak var city:UITextField!
  @IBOutlet weak var state:UITextField!
  @IBOutlet var nextButton: MDCButton!
  
  
  var thisuser = User(fname: "", lname: "", email: "")
  @IBOutlet weak var main: UILabel!
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    print("HEYYYYYYYYYY!!!")
    print(thisuser.firstName)
    
    self.hideKeyboardWhenTappedAround()
    initializeUI()
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
  }
  
  func initializeUI() {
    main.textColor = HexColor("E0C393")
    navigationController?.navigationBar.topItem?.title = "Let's Start With The Essentials!"
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    navigationController?.navigationBar.titleTextAttributes = textAttributes
    
    let colorScheme = MDCSemanticColorScheme()
    colorScheme.primaryColor = HexColor("A6DD69")!
    
    let buttonSchemeScan = MDCButtonScheme()
    MDCContainedButtonThemer.applyScheme(buttonSchemeScan, to: nextButton)
    MDCContainedButtonColorThemer.applySemanticColorScheme(colorScheme, to: nextButton)
    
    
  }
  
  
  @IBAction func goBack(sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Your code here
    if segue.identifier == "toProfessional" {
      if let cardView = segue.destination as? ProfessionalInfoController {
        self.thisuser.phone = phone.text!
        self.thisuser.city = city.text!
        self.thisuser.state = state.text!
        cardView.thisuser = self.thisuser
      }
      
    }
    
  }
  func textField(_ nameField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    let oldText: NSString = nameField.text! as NSString
    let newText: NSString = oldText.replacingCharacters(in: range, with: string) as NSString
    

    return true
  }
}

//
//  SecondViewController.swift
//  TransferApp
//
//  Created by MyMacBook on 13.07.2022.
//

import Foundation
import UIKit

protocol UpdatingDataController: class {
  var updatingData: String { get set }
}

class SecondViewController: UIViewController, UpdatingDataController {
  
  @IBOutlet var dataTextField: UITextField!
    
  var updatingData: String = ""
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateTextFieldData(withText: updatingData)
  }
  
  // update data in the textField
  private func updateTextFieldData(withText text: String) {
    dataTextField.text = text
  }
}

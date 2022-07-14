//
//  SecondViewController.swift
//  TransferApp
//
//  Created by MyMacBook on 13.07.2022.
//

import UIKit

protocol UpdatingDataController: class {
  var updatingData: String { get set }
}

class SecondViewController: UIViewController, UpdatingDataController {
  
  @IBOutlet var dataTextField: UITextField!
  
  @IBAction func saveDataWithProperty(_ sender: UIButton) {
      self.navigationController?.viewControllers.forEach{ viewController in
      (viewController as? UpdatableDataController)?.updatedData = dataTextField.text ?? ""
    }
  }
    
  var updatingData: String = ""
  
  var handleUpdatedDataDelegate: DataUpdateProtocol?
  
  var completionHandler: ((String) -> Void)?
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateTextFieldData(withText: updatingData)
  }
  
  // update data in the textField
  private func updateTextFieldData(withText text: String) {
    dataTextField.text = text
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "toFirstScreen":
      prepareFirstScreen(segue)
    default:
      break
    }
  }
  
  private func prepareFirstScreen(_ segue: UIStoryboardSegue) {
    guard let destinationController = segue.destination as? ViewController else {   
      return
    }
    destinationController.updatedData = dataTextField.text ?? ""
  }
  
  @IBAction  func saveDataWithDelegate(_ sender: UIButton) {
    let updatedData = dataTextField.text ?? ""
    
    // call out delegate method
    handleUpdatedDataDelegate?.onDataUpdate(data: updatedData)
    
    // go back to previous screen
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction func  saveDataWithClosure(_ sender: UIButton) {
    let updatedData  = dataTextField.text ?? ""
    
    completionHandler?(updatedData)
    
    navigationController?.popViewController(animated: true)
  }
  
}

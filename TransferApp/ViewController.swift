//
//  ViewController.swift
//  TransferApp
//
//  Created by MyMacBook on 13.07.2022.
//

import UIKit

protocol UpdatableDataController: class {
  var updatedData: String {get set}
}

class ViewController: UIViewController, UpdatableDataController, DataUpdateProtocol {
  
  func onDataUpdate(data: String) {
    updatedData = data
    updatedLabel(withText: data)
  }
            
  @IBOutlet var dataLabel: UILabel!
  
  var updatedData: String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updatedLabel(withText: updatedData)
  }
  
  private func updatedLabel(withText text: String) {
    dataLabel.text = updatedData
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // define segue identifier
    switch segue.identifier {
    case "toEditScreen":
      // work at transfer
      prepareEditScreen(segue)
    default:
      break
    }
  }
  
  private func prepareEditScreen(_ segue: UIStoryboardSegue) {
    // safely take out, extract an optional value
    guard let destinationController = segue.destination as? SecondViewController else {
      return
    }
    destinationController.updatingData = dataLabel.text ?? ""
  }

  @IBAction func editDataWithProperty(_ sender: UIButton) {
    // get VC where the transfer takes place
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! UpdatingDataController
    
    // transfer data
    editScreen.updatingData = dataLabel.text ?? ""
    
    // go over to the next screen
    navigationController?.pushViewController(editScreen as! UIViewController, animated: true)
  }
  
  @IBAction func unwindToFirstScreen(_ segue: UIStoryboardSegue) { }
  
  
  @IBAction func editDataWithDelegate(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
    // transferring data
    editScreen.updatingData = dataLabel.text ?? ""
    
    // establish current class as a delegate
    editScreen.handleUpdatedDataDelegate = self
    
    // open next screen
    navigationController?.pushViewController(editScreen, animated: true)  
  }
  
  @IBAction func editDataWithClosure(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
    
    editScreen.updatingData = dataLabel.text ?? ""
    
    editScreen.completionHandler = { [unowned self] updatedValue in
      updatedData = updatedValue
      updatedLabel(withText: updatedValue)
    }
    navigationController?.pushViewController(editScreen, animated: true)  
  }
  
}


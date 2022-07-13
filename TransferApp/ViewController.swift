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

class ViewController: UIViewController, UpdatableDataController {

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

  @IBAction func editDataWithProperty(_ sender: UIButton) {
    // get VC where the transfer takes place
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! UpdatingDataController
    
    // transfer data
    editScreen.updatingData = dataLabel.text ?? ""
    
    // go over to the next screen
    navigationController?.pushViewController(editScreen as! UIViewController, animated: true)
  }

}


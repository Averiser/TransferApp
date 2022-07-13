//
//  ViewController.swift
//  TransferApp
//
//  Created by MyMacBook on 13.07.2022.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var dataLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
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


//
//  ViewController.swift
//  myApp2
//
//  Created by Sunrise Sunrise on 8/20/20.
//  Copyright © 2020 Sunrise Sunrise. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {
    
var titleText = ""
var descriptionText = ""
 
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = 5
        
        self.descriptionTF.delegate = self
        titleTF.addTarget(nil, action:Selector(("firstResponderAction:")), for:.editingDidEndOnExit)
        descriptionTF.addTarget(nil, action:Selector(("firstResponderAction:")), for:.editingDidEndOnExit)
        titleTF.text = titleText
        descriptionTF.text = descriptionText
       
        labelTitle.text = "Title of task"
        labelDescription.text = "Description of task"
        labelTitle.textColor = .white
        labelDescription.textColor = .white
        
    }
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var labelDescription: UILabel!
    
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
       return true
   }
    override func viewWillAppear(_ animated: Bool) {
    view.setGradientBackground()
       
    super.viewWillAppear(animated)
}
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion: {
           _ in
            self.view.setGradientBackground()
       })
       
    }
    
}

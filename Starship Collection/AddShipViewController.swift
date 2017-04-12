//
//  AddShipViewController.swift
//  Starship Collection
//
//  Created by Josh Arntz on 4/11/17.
//  Copyright © 2017 Mr. Bear. All rights reserved.
//

import UIKit

class AddShipViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var shipPhoto: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var shipNameLabel: UITextField!
    @IBOutlet weak var addUpdateButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    var starship : Starship? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if starship != nil {
            shipPhoto.image = UIImage(data: starship!.image! as Data)
            shipNameLabel.text = starship!.name
            addUpdateButton.setTitle("Update", for: .normal)
            
        } else {
            deleteButton.isHidden = true
            
            }
        
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        shipPhoto.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
  
    
    @IBAction func photosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func addUpdateButtonTapped(_ sender: Any) {
        
         if starship != nil {
         starship!.name = shipNameLabel.text!
         starship!.image = UIImagePNGRepresentation(shipPhoto.image!)! as NSData
         } else {
         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
         let ship = Starship(context: context)
         ship.name = shipNameLabel.text
         ship.image = UIImagePNGRepresentation(shipPhoto.image!)! as NSData
         }
          (UIApplication.shared.delegate as! AppDelegate).saveContext()
          navigationController?.popViewController(animated: true)
 
    }
  
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(starship!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
}

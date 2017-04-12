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
    
    @IBOutlet weak var shipNameLabel: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
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
    }

    @IBAction func photosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addShipTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let ship = Starship(context: context)
        ship.name = shipNameLabel.text
        ship.image = UIImagePNGRepresentation(shipPhoto.image!)! as NSData
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
        
        
        
    }
    
}

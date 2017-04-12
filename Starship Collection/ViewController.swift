//
//  ViewController.swift
//  Starship Collection
//
//  Created by Josh Arntz on 4/11/17.
//  Copyright © 2017 Mr. Bear. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var starships : [Starship] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            starships = try context.fetch(Starship.fetchRequest())
            print(starships)
        }
        catch {
            print("There was an error!")
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starships.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let selectedStarship = starships[indexPath.row]
        cell.textLabel?.text = selectedStarship.name!
        cell.imageView?.image = UIImage(data: selectedStarship.image! as Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let starship = starships[indexPath.row]
        performSegue(withIdentifier: "addShipSegue", sender: starship)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! AddShipViewController
        nextVC.starship = sender as? Starship
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


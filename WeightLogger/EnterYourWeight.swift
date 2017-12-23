//
//  EnterYourWeight.swift
//  WeightLogger
//
//  Created by 黃健偉 on 2017/12/23.
//  Copyright © 2017年 黃健偉. All rights reserved.
//

import UIKit
import CoreData

class EnterYourWeight: UIViewController {

    @IBOutlet var txtWeight: UITextField!
    @IBOutlet var units: UISwitch!
    
    @IBAction func btnSavePressed(_ sender: Any) {
        if let weight = txtWeight.text {
            if (weight.isEmpty == false) {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let ent = NSEntityDescription.entity(forEntityName: "UserWeights", in: context)!

                print ("111")
                //Instance of our custom class, reference to entity
                let newWeight = UserWeights(entity: ent, insertInto: context)
                
                //Fill in the Core Data
                newWeight.weight = weight
                if (units.isOn) {
                    newWeight.units = "kg"
                } else {
                    newWeight.units = "lbs"
                }
                
                let dateFormatter = DateFormatter()
                let currentDate = Date()
                dateFormatter.locale = Locale.current
                dateFormatter.dateStyle = DateFormatter.Style.full
                newWeight.date = dateFormatter.string(from: currentDate)
                print(newWeight)
                do {
                    try context.save()
                } catch {
                    fatalError("Failure to save context: \(error)")
                }
            } else {
                //User carelessly pressed save button without entering weight.
                let alert:UIAlertController = UIAlertController(title: "No Weight Entered", message: "Enter your weight before pressing save.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(result)in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            print("No element text for the UITextField 'txtWeight'")
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

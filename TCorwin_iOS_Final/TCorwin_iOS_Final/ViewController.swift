//
//  ViewController.swift
//  TCorwin_iOS_Final
//
//  Created by Figmints on 3/5/18.
//  Copyright © 2018 NEIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Stack1 Properties
    @IBOutlet weak var bandTextField: UITextField!
    @IBOutlet weak var bandNameLabel: UILabel!
    
    //MARK: Stack2 Properties
    @IBOutlet weak var bandImg: UIImageView!
    @IBOutlet weak var bandSummary: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //handles text field input using the delgate callbacks
        bandTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        bandNameLabel.text = bandTextField.text
    }
    
    
    //MARK: Actions
    @IBAction func findBand(_ sender: UIButton) {
        //on click event actions here
        bandNameLabel.text = bandTextField.text;

        //GET band name from User Input
        let band = bandTextField.text
        
        //PUT into urlString
        let urlString = "http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist=" + band! + "&api_key=82ae11f9e30bbf96818865a3f78d14ac&format=json"
        
        //Test URL from API
        //let url = URL(string: "http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist=Cher&api_key=82ae11f9e30bbf96818865a3f78d14ac&format=json")
        //send to url
        let url = URL(string: urlString)
        print (url as Any)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil
            {
                print ("ERROR")
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        //TRIALS
//                        typealias JSONArray = [JSONDictionary]
//                        let myJson = try JSONSerialization.jsonObject(with: jsonData) as? JSONArray
                        
                        
                        let myJson = try JSONSerialization.jsonObject(with: content, options:.allowFragments) as! [String:Any]
                        
                        //Original HERE
//                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject

                        
                        
//                        print (myJson)
                        
                        //main JSON array artist
                        if let bandInfo = myJson["artist"] as? NSDictionary
                        {
                            //print (bandInfo)
                            
                            //test with images
                            if let img = bandInfo["image"]
                            {
//                                print (img)
//                                print ((img as AnyObject)[0])
                                let first = ((img as AnyObject)[0])
                                print (first!)
//                                if let top = first["text"]
//                                {
//                                    //LEAVING OFF HERE
//                                    print (top)
//                                }
                                var array = [String]()
                                let t = String(describing: first)
                                array.append(t)
                                print(array[0])
                                
//                                let i = String(describing: img)
//                                DispatchQueue.main.async(execute:)
//                                {
//                                  self.bandImg.image = i
//                                };)
                            }
                            
                            //specific array within main JSON array stats -> listeners, playcount
                            if let info = bandInfo["stats"]
                            {
                                //print (info)
                                //convert AnyObject to String
                                let s = String(describing: info)
                                //Run on the Main Thread for no errors
                                DispatchQueue.main.async(execute:
                                {
                                    //set the textfield to JSON array data
                                    self.bandSummary.text = s
                                })
                            }
                        }
                    }
                    catch
                    {
                        //catch the error
                    }
                }
            }
        }
        task.resume()
        
        
        
        
        
        
    }
    
    

}



import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        artistText.delegate = self
    }    
    
    @IBOutlet weak var artistInfo: UITextView!
    @IBOutlet weak var artistText: UITextField!
    @IBAction func getInfo(_ sender: UIButton) {
        
        //GET artist
        let originalArtist = artistText.text
        
        let artist = originalArtist?.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)

      
//        if string.range(of:"Swift") != nil {
//            print("exists")
//        }
        
        //JSON call
        let urlString = "http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist=" + artist! + "&api_key=82ae11f9e30bbf96818865a3f78d14ac&format=json"
        
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error ) in
            if error != nil {
                print("Error no JSON data")
            } else {
                let content = data
                do {
                    let myJson = try JSONSerialization.jsonObject(with: content!, options:.allowFragments) as! [String:Any]
//                    let myJson = try JSONSerialization.jsonObject(with: content!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    
                    print(myJson)
                    
                    if let aInfo = myJson["artist"] as? NSDictionary {
//                        if let info = aInfo["stats"]  {
//                            //Parse data into a string
//                            let s = String(describing: info)
//                            DispatchQueue.main.async(execute: {
////                                self.artistInfo.text = s
//                            })
//                        }
                        if let contents = aInfo["bio"] as? NSDictionary {
                            print(aInfo)
                            if let bio = contents["content"] {
                                print(bio)
                                let s = String(describing: bio)
                                DispatchQueue.main.async(execute: {
                                    self.artistInfo.text = s
                                    self.artistInfo.isScrollEnabled = true
                                })
                            }
                        }
                    }
                } catch {
                    //catch errors
                }
            }
        }
        task.resume()
    }
}


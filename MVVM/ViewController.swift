//
//  ViewController.swift
//  MVVM
//
//  Created by Alexander Romanenko on 05.02.2021.
//  Copyright © 2021 Alexander Romanenko. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var NameId: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var textBlok: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selector: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    
    let parser = Parser()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parser.getParsedData {
            data in
            
            self.textBlok.text = data.data[0]?.data.text
            self.textField.placeholder = data.data[0]?.data.text
            let variant1 = data.data[2]?.data.variants[0].text
            let variant2 = data.data[2]?.data.variants[1].text
            let variant3 = data.data[2]?.data.variants[2].text
            self.selector.setTitle(variant1, forSegmentAt: 0)
            self.selector.setTitle(variant2, forSegmentAt: 1)
            self.selector.setTitle(variant3, forSegmentAt: 2)
            
            
            let string: String = (data.data[1]?.data.url)!
            self.imageView.setImage(string, placeholder: "Image")
        }
        
        self.selector.addTarget(self, action: #selector(self.selectedValue), for: .valueChanged)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped))
        tap.delegate = self
        self.imageView.addGestureRecognizer(tap)
        
        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(textFieldTapped))
        textField.addGestureRecognizer(textFieldTap)
        
        let textBlokTap = UITapGestureRecognizer(target: self, action: #selector(textBlokTapped))
        textBlok.addGestureRecognizer(textBlokTap)
    }
    

    @objc func textBlokTapped(sender: UITapGestureRecognizer) {
       parser.getParsedData(comp: { (Json) in
        self.age.text = Json.data[0]?.name
        })
    }
    
    @objc func textFieldTapped(sender: UITapGestureRecognizer) {
        parser.getParsedData(comp: { (Json) in
            self.age.text = Json.data[0]?.name
        })
        
    }
    @objc func viewTapped(sender: UITapGestureRecognizer) {
        parser.getParsedData { (Json) in
            self.age.text = Json.data[1]?.name
            print("привет")
        }
    }
    @objc func selectedValue(target: UISegmentedControl) {
        if target == self.selector {
            
            switch target.selectedSegmentIndex {
            case 0:
                parser.getParsedData { (Json) in
                    let id = Json.data[2]?.data.variants[0].id
                        self.age.text = "ID \(String(describing: id!))"
                    
                }
            case 1:
                parser.getParsedData { (Json) in
                    let id = Json.data[2]?.data.variants[1].id
                       self.age.text = "ID \(String(describing: id!))"
                    
                }
            case 2:
                parser.getParsedData { (Json) in
                    let id = Json.data[2]?.data.variants[2].id
                        self.age.text = "ID \(String(describing: id!))"
            
                }
            default:
                break
            }
        }
    }
}
extension UIImageView {
    func setImage(_ imageUrl: String, placeholder: String){
        self.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: placeholder))
    }
}




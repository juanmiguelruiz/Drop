//
//  SettingsViewController.swift
//  Drop
//
//  Created by Juan Miguel on 20/05/2020.
//  Copyright © 2020 Juan Miguel. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var unit: Bool! = true

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var appIconButton: UIButton!
    @IBOutlet weak var infoDarkMode: UIButton!
    @IBOutlet weak var aboutUsButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBAction func infoDarkModeButton(_ sender: Any) {

        if NSLocale.current.languageCode == "es" {

            let alert = UIAlertController(title: "Bienvenido al lado oscuro", message: "Si activas el modo oscuro en tu dispositivo, nosotros también 🌚", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        }

        let alert = UIAlertController(title: "Welcome to the dark side", message: "If you activate the dark mode on your device, we will also 🌚", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        present(alert, animated: true, completion: nil)
    }

    @IBAction func aboutUsButton(_ sender: Any) {

        UIView.animate(withDuration: 0.6,
            animations: {
                self.aboutUsButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.6) {
                    self.aboutUsButton.transform = CGAffineTransform.identity
                }
            })
    }

    @IBAction func backButton(_ sender: Any) {
        UIView.animate(withDuration: 0.6,
            animations: {
                self.backButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.6) {
                    self.backButton.transform = CGAffineTransform.identity
                }
            })
    }


    @IBAction func changeAppIconButton(_ sender: Any) {
        UIView.animate(withDuration: 0.6,
            animations: {
                self.appIconButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.6) {
                    self.appIconButton.transform = CGAffineTransform.identity
                }
            })
    }



    @IBAction func segmentSelected(_ sender: Any) {
        let index = segmentedControl.selectedSegmentIndex

        switch index {

        case 0:
            UserDefaults.standard.set(index, forKey: "segmentSelected")
            UserDefaults.standard.synchronize()
            unit = false
            UserDefaults.standard.set(unit, forKey: "unit")

            print("c")

        case 1:
            UserDefaults.standard.set(index, forKey: "segmentSelected")
            UserDefaults.standard.synchronize()
            unit = true
            UserDefaults.standard.set(unit, forKey: "unit")

            print("f")



        default:
            break
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        appIconButton.layer.cornerRadius = 15
        backButton.layer.cornerRadius = 15
        infoDarkMode.layer.cornerRadius = 15
        aboutUsButton.layer.cornerRadius = 15


        if let value = UserDefaults.standard.value(forKey: "segmentSelected") {
            let selectedIndex = value as! Int
            segmentedControl.selectedSegmentIndex = selectedIndex
        }


        // Do any additional setup after loading the view.



    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {


        if let destination = segue.destination as? ViewController {
            if unit == false {
                destination.unit = false

            } else {
                destination.unit = true
            }
        }

    }

}






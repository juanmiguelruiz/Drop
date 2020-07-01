//
//  AboutUsViewController.swift
//  Drop
//
//  Created by Juan Miguel on 21/05/2020.
//  Copyright © 2020 Juan Miguel. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!


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

        dismiss(animated: true, completion: nil)

    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        backButton.layer.cornerRadius = 15

    }



}

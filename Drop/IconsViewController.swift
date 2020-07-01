//
//  IconsViewController.swift
//  Drop
//
//  Created by Juan Miguel on 20/05/2020.
//  Copyright © 2020 Juan Miguel. All rights reserved.
//

import UIKit

class IconsViewController: UIViewController {

    let application = UIApplication.shared

    @IBOutlet weak var restoreButton: UIButton!
    @IBOutlet weak var backButton: UIButton!


    @IBAction func changeDefaultIconButton(_ sender: Any) {

        changeAppIcon(to: .primaryAppIcon)


    }



    @IBAction func changeBlueIconButton(_ sender: Any) {

        changeAppIcon(to: .blueAppIcon)

    }



    @IBAction func changeDarkIconButton(_ sender: Any) {

        changeAppIcon(to: .darkAppIcon)

    }



    @IBAction func restoreIconDefault(_ sender: Any) {

        UIView.animate(withDuration: 0.6,
            animations: {
                self.restoreButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.6) {
                    self.restoreButton.transform = CGAffineTransform.identity
                }
            })

        changeAppIcon(to: .primaryAppIcon)

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

        dismiss(animated: true, completion: nil)

    }


    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.layer.cornerRadius = 15
        restoreButton.layer.cornerRadius = 15



    }


    enum AppIcon: String {
        case primaryAppIcon
        case blueAppIcon
        case darkAppIcon
    }

    func changeAppIcon(to appIcon: AppIcon) {
        let appIconValue: String? = appIcon == .primaryAppIcon ? nil : appIcon.rawValue
        application.setAlternateIconName(appIconValue)


    }


}

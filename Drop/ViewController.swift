//
//  ViewController.swift
//  WeatherAPP
//
//  Created by Juan Miguel on 15/05/2020.
//  Copyright © 2020 Juan Miguel. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces


class ViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate, GMSAutocompleteViewControllerDelegate, getWeatherDelegate {

    let locationManager = CLLocationManager()
    var unit: Bool! = nil
    let acController = GMSAutocompleteViewController()



    var getConnections: Connections!

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var temperatureLabel2: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var iconLabel: UIImageView!
    @IBOutlet weak var preferencesButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!

    @IBAction func autocompleteButton(_ sender: Any) {

        cityTextField.resignFirstResponder()

        let filter = GMSAutocompleteFilter()
        filter.type = .city
        acController.autocompleteFilter = filter

        acController.primaryTextColor = .gray
        acController.primaryTextHighlightColor = .black
        acController.secondaryTextColor = .gray

        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }


    @IBAction func locationButton(_ sender: Any) {

        UIView.animate(withDuration: 0.6,
            animations: {
                self.locationButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.6) {
                    self.locationButton.transform = CGAffineTransform.identity
                }
            })

        location()
        cityTextField.text = ""

    }

    @IBAction func preferencesButton(_ sender: Any) {

        UIView.animate(withDuration: 0.6,
            animations: {
                self.preferencesButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.6) {
                    self.preferencesButton.transform = CGAffineTransform.identity
                }
            })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        populateValues()
        location()

    }

    var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }


    func location() {

        locationManager.delegate = self

        if CLLocationManager.authorizationStatus() == .notDetermined {

            self.locationManager.requestWhenInUseAuthorization()
        }

        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()

        if locationManager.location != nil {
            locationManagerDidPauseLocationUpdates(locationManager)
        }

    }


    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {

        let locValue: CLLocationCoordinate2D = manager.location!.coordinate
        let lat = locValue.latitude as Double
        let lon = locValue.longitude as Double

        print("lat, lon: \(lat), \(lon)")

        if NSLocale.current.languageCode == "es" {
            getConnections.weatherByLocationES(lat: lat, lon: lon)

        } else {
            getConnections.weatherByLocation(lat: lat, lon: lon)

        }
    }

    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {

        let alertView = UIAlertController(title: "Error", message: "No ha sido posible utilizar la aplicación", preferredStyle: .alert)
        let button = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertView.addAction(button)

        dismiss(animated: true, completion: nil)
    }


    override open var prefersStatusBarHidden: Bool {
        return true
    }

    private func populateValues() {
        preferencesButton.layer.cornerRadius = 15

        cityLabel.text = ""
        temperatureLabel.text = "-"
        temperatureLabel2.text = "-"
        maxTempLabel.text = "-"
        minTempLabel.text = "-"
        feelsLikeLabel.text = "-"
        descriptionLabel.text = ""
        humidityLabel.text = "-"
        cloudsLabel.text = "-"
        windSpeedLabel.text = "-"
        pressureLabel.text = "-"
        iconLabel.isHidden = true
        cityTextField.text = ""
        cityTextField.delegate = self
        cityTextField.returnKeyType = UIReturnKeyType.done
        cityTextField.enablesReturnKeyAutomatically = true
        if unit == nil {
            unit = true
        }

        unit = UserDefaults.standard.bool(forKey: "unit")


        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        getConnections = Connections(delegate: self)

    }

    func selectIconWeather(mainw: String, des: String) {


        if mainw == "Thunderstorm" {
            self.iconLabel.image = UIImage(named: "rayos")

        } else if mainw == "Snow" {
            self.iconLabel.image = UIImage(named: "nieve")

        } else if mainw == "Drizzle" {
            self.iconLabel.image = UIImage(named: "lluvia nubosa")

        } else if mainw == "Clear" {
            self.iconLabel.image = UIImage(named: "sol")

        } else if mainw == "Cloud" && des == "pocas nubes" {
            self.iconLabel.image = UIImage(named: "nubes y sol")

        } else if mainw == "Cloud" {
            self.iconLabel.image = UIImage(named: "nubes")

        } else if (mainw == "Rain" && des == "lluvia helada") {
            self.iconLabel.image = UIImage(named: "nieve")

        } else if (mainw == "Rain" && des == "lluvia ligera intensidad lluvia") || (mainw == "Rain" && des == "aguacero") || (mainw == "Rain" && des == "lluvia intensa lluvia intensa") || (mainw == "Rain" && des == "lluvia irregular") {
            self.iconLabel.image = UIImage(named: "lluvia")

        } else if mainw == "Rain" {
            self.iconLabel.image = UIImage(named: "lluvia nubosa")

        } else {
            self.iconLabel.image = UIImage(named: "niebla")
        }
    }


    func weatherOK(weatherReport: Weather) {

        DispatchQueue.main.async {

            let sunrise = self.timeStringFromUnixTime(unixTime: weatherReport.sunrise)
            let sunset = self.timeStringFromUnixTime(unixTime: weatherReport.sunset)

            self.cityLabel.text = weatherReport.city
            self.descriptionLabel.text = weatherReport.description.capitalized
            self.cloudsLabel.text = "\(weatherReport.clouds) %"
            self.windSpeedLabel.text = "\(weatherReport.windSpeed) m/s"
            self.humidityLabel.text = "\(weatherReport.humidity) %"
            self.pressureLabel.text = "\(weatherReport.pressure) Pa"
            self.sunriseLabel.text = "\(sunrise)"
            self.sunsetLabel.text = "\(sunset)"



            if self.unit == false {

                self.temperatureLabel.text = "\(Int(round(weatherReport.celsius)))º"
                self.temperatureLabel2.text = "\(Int(round(weatherReport.celsius)))º"
                self.maxTempLabel.text = "\(Int(round(weatherReport.celsiusMax)))"
                self.minTempLabel.text = "\(Int(round(weatherReport.celsiusMin)))"
                self.feelsLikeLabel.text = "\(Int(round(weatherReport.celsiusFeelLike)))º"

            } else if self.unit == true {

                self.temperatureLabel.text = "\(Int(round(weatherReport.farenheit)))º"
                self.temperatureLabel2.text = "\(Int(round(weatherReport.farenheit)))º"
                self.maxTempLabel.text = "\(Int(round(weatherReport.farenheitMax)))"
                self.minTempLabel.text = "\(Int(round(weatherReport.farenheitMin)))"
                self.feelsLikeLabel.text = "\(Int(round(weatherReport.farenheitFeelsLike)))º"

            }

            self.iconLabel.isHidden = false
            self.selectIconWeather(mainw: weatherReport.mainWeather, des: weatherReport.description)

            self.locationManager.stopUpdatingLocation()
        }
    }


    func weatherNO(error: NSError) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Ha ocurrido un error inténtelo más tarde", preferredStyle: .alert)
            let accept = UIAlertAction(title: "OK", style: .default, handler: nil)

            alert.addAction(accept)

            self.present(alert, animated: true, completion: nil)
        }
    }


    func textFieldShouldClear(_ textField: UITextField) -> Bool {

        self.cityTextField.text = ""

        return true
    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        self.cityTextField.resignFirstResponder()

        return true
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        view.endEditing(true)
    }


    func timeStringFromUnixTime(unixTime: Double) -> String {

        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()

        dateFormatter.timeZone = TimeZone(abbreviation: "CEST") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm" //Specify your format that you want

        let strDate = dateFormatter.string(from: date)

        return strDate
    }


    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {

        dismiss(animated: true, completion: nil)

        self.cityTextField.text = place.name

        if NSLocale.current.languageCode == "es" {
            getConnections.weatherByCityES(cityTextField.text!.urlEncoded)

        } else {
            getConnections.weatherByCity(cityTextField.text!.urlEncoded)

        }
    }


    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {

        print(error.localizedDescription)
    }


    func wasCancelled(_ viewController: GMSAutocompleteViewController) {

        dismiss(animated: true, completion: nil)
    }

}


extension String {

    var urlEncoded: String {

        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlUserAllowed)!
    }


    var trimmed: String {

        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }


}


//
//  Weather.swift
//  WeatherAPP
//
//  Copyright © 2020 Juan Miguel. All rights reserved.
//

import Foundation

struct Weather {

    let city: String
    let country: String
    let lat: Double
    let lon: Double
    let mainWeather: String
    let description: String
    let temperature: Double
    let humidity: Int
    let pressure: Double
    let clouds: Int
    let windSpeed: Double
    let rainThreeHours: Double?
    let maxTemp: Double
    let minTemp: Double
    let feelsLike: Double
    let sunrise: Double
    let sunset: Double
    
    var celsius: Double{
        get{
            return temperature - 273.15
        }
    }
    
    var celsiusMax: Double{
         get{
             return maxTemp - 273.15
         }
     }
    
    var celsiusFeelLike: Double{
            get{
                return feelsLike - 273.15
            }
        }
    
    var celsiusMin: Double{
         get{
             return minTemp - 273.15
         }
     }
    
    var farenheit: Double{
           get{
                return (temperature - 273.15) * 1.8 + 32
           }
       }
    
    var farenheitMax: Double{
              get{
                   return (maxTemp - 273.15) * 1.8 + 32
              }
          }
    
    var farenheitMin: Double{
              get{
                   return (minTemp - 273.15) * 1.8 + 32
              }
          }
    
    var farenheitFeelsLike: Double{
        get{
             return (feelsLike - 273.15) * 1.8 + 32
        }
    }
    
    init(dataset:[String:AnyObject]){
        
        let sys = dataset["sys"] as! [String:AnyObject]
        let coord = dataset["coord"] as! [String:AnyObject]
        let weather = dataset["weather"]![0] as! [String:AnyObject]
        let main = dataset["main"] as! [String:AnyObject]
        let wind = dataset["wind"] as! [String:AnyObject]
        
        city = dataset["name"] as! String
        country = sys["country"] as! String
        lat = coord["lat"] as! Double
        lon = coord["lon"] as! Double
        mainWeather = weather["main"] as! String
        description = weather["description"] as! String
        temperature = main["temp"] as! Double
        humidity = main["humidity"] as! Int
        pressure = main["pressure"] as! Double
        clouds = dataset["clouds"]!["all"] as! Int
        windSpeed = wind["speed"] as! Double
        minTemp = main["temp_min"] as! Double
        maxTemp = main["temp_max"] as! Double
        feelsLike = main["feels_like"] as! Double
        sunrise = sys["sunrise"] as! Double
        sunset = sys["sunset"] as! Double
        
        if dataset["rain"] != nil {
            rainThreeHours = dataset["rain"]!["3h"] as? Double
        }else{
            rainThreeHours = nil
        }
        
    }

}





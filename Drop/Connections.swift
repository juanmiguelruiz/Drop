//
//  Connections.swift
//  WheatherApp
//
//  Copyright © 2019 Juan Miguel. All rights reserved.
//

import UIKit

protocol getWeatherDelegate {
    func weatherOK(weatherReport: Weather)
    func weatherNO(error: NSError)
}

class Connections {
    
    fileprivate let url = "https://api.openweathermap.org/data/2.5/weather"
    fileprivate let key = "API_KEY"
    
    fileprivate let delegate: getWeatherDelegate
    
    init(delegate: getWeatherDelegate) {
        self.delegate = delegate
    }
    
    
    func weatherByCityES(_ city: String) {
        let requestURL = URL(string: "\(url)?q=\(city)&APPID=\(key)&lang=es")!
        weather(requestURL)
    }
    
    func weatherByLocationES(lat:Double, lon:Double){
        let requestURL = URL(string: "\(url)?&APPID=\(key)&lat=\(lat)&lon=\(lon)&lang=es")!
        weather(requestURL)
    }
    
    func weatherByCity(_ city: String) {
          let requestURL = URL(string: "\(url)?q=\(city)&APPID=\(key)")!
          weather(requestURL)
      }
      
      func weatherByLocation(lat:Double, lon:Double){
          let requestURL = URL(string: "\(url)?&APPID=\(key)&lat=\(lat)&lon=\(lon)")!
          weather(requestURL)
      }
    
    func weather(_ requestURLWeather:URL){
        
        let session = URLSession.shared
        session.configuration.timeoutIntervalForRequest = 5
        
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURLWeather as URL)
        
        let task = session.dataTask(with: urlRequest as URLRequest){
            (data,response,error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if(statusCode==200){
                
                do{
                    let parseData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:Any]
                    let weather = Weather(dataset: parseData as [String:AnyObject])
                    
                    self.delegate.weatherOK(weatherReport: weather)
                   
                    print("Weather Forecast: \(weather)")
                    
                }catch let jsonError as NSError{
                   
                    self.delegate.weatherNO(error: jsonError)
                   
                    print("Error:\(jsonError)")
                    
                }
            }
        }
        task.resume()
        
        
    }
    
}

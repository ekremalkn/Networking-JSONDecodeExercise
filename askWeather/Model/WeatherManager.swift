//
//  WeatherManager.swift
//  askWeather
//
//  Created by Ekrem Alkan on 2.10.2022.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=73983865cbccd363575138d317ce8967&units=metric"
    
    
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
        print(urlString)
        
    }
    //MARK: - Networking
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            task.resume()
            
            
        }
        
        
    }
    
    //MARK: - JSONDecode

    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do {
            let decodedData = try  decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.name)
            print(decodedData.weather[0].description)
        
        } catch {
            print(error)
        }
        
        
    }
    
    
}



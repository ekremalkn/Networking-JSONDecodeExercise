//
//  WeatherManager.swift
//  askWeather
//
//  Created by Ekrem Alkan on 2.10.2022.
//

import Foundation

protocol WeatherManagerDelegate {
    func updateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=73983865cbccd363575138d317ce8967&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
        
        
    }
    
    func fetchWeatherWithLocation(latitude: Double, longitude: Double){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
        
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
                DispatchQueue.main.async {
                    if let safeData = data {
                        if let weather = self.parseJSON(weatherData: safeData){
                            let VC = ViewController()
                            VC.updateWeather(self, weather: weather)
                        }
                    }
                }
                
            }
            task.resume()
            
            
        }
        
        
    }
    
    //MARK: - JSONDecode

    func parseJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try  decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let tempMax = decodedData.main.temp_max
            let tempMin = decodedData.main.temp_min
            let tempFeelsLike = decodedData.main.feels_like
            let description = decodedData.weather.description
            let name = decodedData.name
            
            let weather = WeatherModel(weatherId: id, cityName: name, temperature: temp, tempMax: tempMax, tempMin: tempMin, tempFeelsLike: tempFeelsLike, description: description)
            return weather
           
        
        } catch {
            print(error)
            return nil
        }
        
        
    }
    
 

   
    
    
}



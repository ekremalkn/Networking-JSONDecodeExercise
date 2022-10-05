//
//  WeatherModel.swift
//  askWeather
//
//  Created by Ekrem Alkan on 2.10.2022.
//

import Foundation

struct WeatherModel {
    let weatherId: Int
    let cityName: String
    let temperature: Double
    let tempMax: Double
    let tempMin: Double
    let tempFeelsLike: Double
    let description: String
    
    var temperatureString: String{
        return String(format: "%.1f", temperature)
    }
    
    var weatherName: String {
        switch weatherId {
        case 200...232:
            return "thunderstorm"
        case 300...321:
            return "drizzle"
        case 500...531:
            return "rain"
        case 600...622:
            return "snow"
        case 701...781:
            return "fog"
        case 801...804:
            return "cloud"
            
        default:
            return "sun"
    }
    
    
        
        
    }
    
}

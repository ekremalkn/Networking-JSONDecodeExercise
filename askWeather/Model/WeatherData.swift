//
//  WeatherData.swift
//  askWeather
//
//  Created by Ekrem Alkan on 2.10.2022.
//

import Foundation

struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable{
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
}

struct Weather: Codable{
    let description: String
    let id: Int
    
    
}

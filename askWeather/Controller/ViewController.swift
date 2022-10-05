//
//  ViewController.swift
//  askWeather
//
//  Created by Ekrem Alkan on 2.10.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    
   
    
    
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        
        
    }
    
    
    //MARK: - Update Data

    
    func updateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        print("Şehir: \(weather.cityName), Açıklama: \(weather.description), Derece: \(weather.temperatureString), MaxDerece: \(weather.tempMax), MinDerece: \(weather.tempMin), Hissedilen Sıcaklık: \(weather.tempFeelsLike) "
                  )
 
    }

    

}

extension ViewController: UITextFieldDelegate {
    
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        
        searchTextField.endEditing(true)
      
    }
    
    //MARK: - SearchTextField set up
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
    
}


//MARK: - Location

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            weatherManager.fetchWeatherWithLocation(latitude: lat, longitude: lon)
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    
    @IBAction func locationButtonPressed(_ sender: Any){
        locationManager.requestLocation()
        
    }
    
    
    
   
    
}


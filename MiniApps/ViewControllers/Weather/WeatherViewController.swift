//
//  ViewController.swift
//  MiniApps
//
//  Created by Evgeniy Maksimov on 04.09.2024.
//

import UIKit
import CoreLocation

final class WeatherViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var nameCity: UILabel!
    @IBOutlet var currentTemp: UILabel!
    @IBOutlet var descriptionTemp: UILabel!
    @IBOutlet var weatherStackView: UIStackView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    // MARK: - Private properties
    private let locationManager = CLLocationManager()
    private let networkManager = NetworkManager.shared
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        weatherStackView.isHidden = true
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
}
    // MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            networkManager.fetchWeather(
                latitude: location.coordinate.latitude,
                longtitude: location.coordinate.longitude) { [unowned self] result in
                    switch result {
                    case .success(let weatherData):
                        let weather = weatherData
                        nameCity.text = weather.location.name
                        currentTemp.text = "\(Int(weather.current.tempC))"
                        descriptionTemp.text = weather.current.condition.text
                        activityIndicator.stopAnimating()
                        weatherStackView.isHidden = false
            
                    case .failure(let failure):
                        print(failure)
                    }
                }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
                
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("Отклонено")
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
}


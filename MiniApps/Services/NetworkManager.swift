//
//  NetworkManager.swift
//  MiniApps
//
//  Created by Evgeniy Maksimov on 04.09.2024.
//

import Foundation

enum NetworkError: Error {
    case noData
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchWeather(latitude: Double, longtitude: Double, complishion: @escaping (Result<Weather,NetworkError>) -> Void) {
        let url = URL(string:"http://api.weatherapi.com/v1/current.json?key=31191968db3342ebbb5135739240509&q=\(latitude),\(longtitude)&aqi=no&lang=ru")!
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data, let responce else {
                print(error?.localizedDescription ?? "No error" )
                complishion(.failure(.noData))
                return
            }
            
            print(responce)
            
            do {
                let weatherData = try JSONDecoder().decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    complishion(.success(weatherData))
                }
            } catch {
                complishion(.failure(.noData))
            }
        }.resume()
    }
    
    func fetchImage(form url: String, complishion: @escaping(Result<Data, NetworkError>) -> Void) {
        let urlImage = URL(string: url)!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: urlImage) else {
                complishion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                complishion(.success(imageData))
            }
        }
    }
}

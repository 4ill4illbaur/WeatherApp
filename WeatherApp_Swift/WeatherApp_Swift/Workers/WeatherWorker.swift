//
//  WeatherWorker.swift
//  WeatherApp_Swift
//
//  Created by Бауржан Еркен on 04.08.2024.
//

import Foundation

typealias Failure = (Any) -> Void
typealias Success<T> = (T) -> Void

final class WeatherWorker {
    private var APIKey = "edc7a5919d83452ea4b81548240304"
    
    func getCurrent(city: String,failure: @escaping (Failure),
                    success: @escaping Success<Current>) {
        let parameters = ["key": APIKey ,
                          "q": city]
        NetworkManager.shared.fetchData(From: "current.json", parameters: parameters) { result in
            switch result {
            case .success(let data):
                //обработать данные
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print (json)
                    
                    let jsonDecoder = JSONDecoder()
                    
                    let result: Current = try jsonDecoder.decode(Current.self, from: data)
                    
                    success(result)
                    
                    print(result.location.country)
                    print(result.current.tempC)
                } catch {
                    print("Error:\(error)")
                }
                
                print(data)
            case .failure(let error):
                //обработать ошибку
                print(error.localizedDescription) }
        }
    }
                
                
                
                func getForecast (city: String,
                                  failure: @escaping (Failure),
                                  success: @escaping Success<Forecast>) {
                    let parameters:[String: Any ] = ["key": APIKey,
                                      "q": city ,
                                      "days": 7]
                    
                    NetworkManager.shared.fetchData(From: "forecast.json", parameters: parameters) {result in
                        switch result {
                        case .success(let data):
                            //обработать данные
                            do {
                                
                                let json = try JSONSerialization.jsonObject(with: data, options: [])
                                print (json)
                                
                                let jsonDecoder = JSONDecoder()
                                
                                let result: Forecast = try jsonDecoder.decode(Forecast.self, from: data)
                                
                                success(result)
                                
                                //                                print(result.location.country)
                                //                                print(result.current.tempC)
                            } catch {
                                print("Error:\(error)")
                            }
                            
                            print(data)
                        case .failure(let error):
                            //обработать ошибку
                            print(error.localizedDescription)
                            } }
                        }
                    }
                
        

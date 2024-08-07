//
//  ViewController.swift
//  WeatherApp_Swift
//
///
/////  Created by Бауржан Еркен on 04.08.2024.
//

import UIKit

//edc7a5919d83452ea4b81548240304

//
//struct DailyWeather {
//  let date: String
//  let description: String
//  let minTemp: Double
//  let maxTemp: Double
//}


class ViewController: UIViewController {
  

  private var forecast: [Forecastday] = []
  private var current: Current?
  private var worker = WeatherWorker()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        loadData()
//        LoadData2()
        
   }
    
    // Do any additional setup after loading the view.
    }
    
    
// MARK: - Private
private extension ViewController {
    
    func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func loadData() {
       worker.getCurrent(city: "Tokyo", failure: { error in }, success: { [weak self] current in
         guard let self = self else { return }

         self.current = current
         DispatchQueue.main.async {
           self.countryLabel.text = " \(current.location.country) \(current.current.tempC) °C "
           self.tempLabel.text = " \(current.location.localtime)"
         }

         // Get forecast after receiving current weather
         self.worker.getForecast(city: "Tokyo", failure: { error in }, success: { [weak self] current in
           guard let self = self else { return }

           self.forecast = current.forecast?.forecastday ?? []
           DispatchQueue.main.async {
             self.tableView.reloadData()
           }
         })
       })
     }
   }

   // MARK: - UITableViewDelegate, UITableViewDataSource
   extension ViewController: UITableViewDelegate, UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return forecast.count
     }
     
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let day = forecast[indexPath.row]
           let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellForeCast", for: indexPath) as? WeatherUITableViewCell

           cell?.titleLabel?.text = day.date // Assuming date is available in ForecastDay
           cell?.dayTempLabel?.text = "\(day.day?.maxtempC ?? Double.nan)°C" // Use day.day?.maxtempC for day temp
           cell?.nightTempLabel?.text = "\(day.day?.mintempC ?? Double.nan)°C" // Use day.day?.mintempC for night temp

           return cell ?? UITableViewCell()
     }
   }


//
//  WeatherUITableViewCell.swift
//  WeatherApp_Swift
//
//  Created by Бауржан Еркен on 04.08.2024.
//

import UIKit

class WeatherUITableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!    
    @IBOutlet weak var dayTempLabel: UILabel!
    
    @IBOutlet weak var nightTempLabel: UILabel!
    
    
    
    
    
    
    
    
    public func setupCell(title: String, dayTempC: Double, nightTempC: Double) {
        titleLabel.text = title
        dayTempLabel.text = "\(dayTempC)°C" // Отобразите температуру днем
        nightTempLabel.text = "\(nightTempC)°C" // Отобразите температуру ночью
    }
    
}


//
//  Forecast.swift
//  WeatherApp_Swift
//
//  Created by Бауржан Еркен on 04.08.2024.
//

import Foundation

// MARK: - Forecast
struct Forecast: Decodable {
    let current: CurrentClass?
    let forecast: ForecastClass?
    let location: Location
}

enum WindDir: String, Codable {
    case s = "S"
    case ssw = "SSW"
    case sw = "SW"
    case wsw = "WSW"
}

// MARK: - ForecastClass
struct ForecastClass: Decodable {
    let forecastday: [Forecastday]?
}

// MARK: - Forecastday
struct Forecastday: Decodable {
    let date: String?
    let dateEpoch: Double?
    let day: Day?
    let astro: Astro?
    let hour: [Hour]?

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro, hour
    }
}

// MARK: - Astro
struct Astro: Decodable {
    let sunrise, sunset, moonrise, moonset: String?
    let moonPhase: String?
    let moonIllumination: Int?

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
    }
}

// MARK: - Day
struct Day: Decodable {
    let maxtempC, maxtempF, mintempC, mintempF: Double?
    let avgtempC, avgtempF, maxwindMph, maxwindKph: Double?
    let totalprecipMm, totalprecipIn, avgvisKM, avgvisMiles: Double?
    let avghumidity, dailyWillItRain, dailyChanceOfRain, dailyWillItSnow: Double?
    let dailyChanceOfSnow: Double?
    let condition: Condition?
    let uv: Double?

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case maxtempF = "maxtemp_f"
        case mintempC = "mintemp_c"
        case mintempF = "mintemp_f"
        case avgtempC = "avgtemp_c"
        case avgtempF = "avgtemp_f"
        case maxwindMph = "maxwind_mph"
        case maxwindKph = "maxwind_kph"
        case totalprecipMm = "totalprecip_mm"
        case totalprecipIn = "totalprecip_in"
        case avgvisKM = "avgvis_km"
        case avgvisMiles = "avgvis_miles"
        case avghumidity
        case dailyWillItRain = "daily_will_it_rain"
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyWillItSnow = "daily_will_it_snow"
        case dailyChanceOfSnow = "daily_chance_of_snow"
        case condition, uv
    }
}



// MARK: - Hour
struct Hour: Decodable {
    let timeEpoch: Double?
    let time: String?
    let tempC, tempF: Double?
    let isDay: Double?
    let condition: Condition?
    let windMph, windKph: Double?
    let windDegree: Double?
    let windDir: WindDir?
    let pressureMB: Double?
    let pressureIn: Double?
    let precipMm, precipIn, humidity, cloud: Double?
    let feelslikeC, feelslikeF, windchillC, windchillF: Double?
    let heatindexC, heatindexF, dewpointC, dewpointF: Double?
    let willItRain, chanceOfRain, willItSnow, chanceOfSnow: Double?
    let visKM, visMiles, gustMph: Double?
    let gustKph: Double?
    let uv: Double?

    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case windchillC = "windchill_c"
        case windchillF = "windchill_f"
        case heatindexC = "heatindex_c"
        case heatindexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case willItRain = "will_it_rain"
        case chanceOfRain = "chance_of_rain"
        case willItSnow = "will_it_snow"
        case chanceOfSnow = "chance_of_snow"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
        case uv
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timeEpoch = try container.decodeIfPresent(Double.self, forKey: .timeEpoch)
        self.time = try container.decodeIfPresent(String.self, forKey: .time)
        self.tempC = try container.decodeIfPresent(Double.self, forKey: .tempC)
        self.tempF = try container.decodeIfPresent(Double.self, forKey: .tempF)
        self.isDay = try container.decodeIfPresent(Double.self, forKey: .isDay)
        self.condition = try container.decodeIfPresent(Condition.self, forKey: .condition)
        self.windMph = try container.decodeIfPresent(Double.self, forKey: .windMph)
        self.windKph = try container.decodeIfPresent(Double.self, forKey: .windKph)
        self.windDegree = try container.decodeIfPresent(Double.self, forKey: .windDegree)
//        self.windDir = try container.decodeIfPresent(WindDir.self, forKey: .windDir)
        if let windDirValue = try container.decodeIfPresent(String.self, forKey: .windDir){
            self.windDir = WindDir(rawValue: windDirValue)
        } else {
            self.windDir = nil
        }
        
        
        
        self.pressureMB = try container.decodeIfPresent(Double.self, forKey: .pressureMB)
        self.pressureIn = try container.decodeIfPresent(Double.self, forKey: .pressureIn)
        self.precipMm = try container.decodeIfPresent(Double.self, forKey: .precipMm)
        self.precipIn = try container.decodeIfPresent(Double.self, forKey: .precipIn)
        self.humidity = try container.decodeIfPresent(Double.self, forKey: .humidity)
        self.cloud = try container.decodeIfPresent(Double.self, forKey: .cloud)
        self.feelslikeC = try container.decodeIfPresent(Double.self, forKey: .feelslikeC)
        self.feelslikeF = try container.decodeIfPresent(Double.self, forKey: .feelslikeF)
        self.windchillC = try container.decodeIfPresent(Double.self, forKey: .windchillC)
        self.windchillF = try container.decodeIfPresent(Double.self, forKey: .windchillF)
        self.heatindexC = try container.decodeIfPresent(Double.self, forKey: .heatindexC)
        self.heatindexF = try container.decodeIfPresent(Double.self, forKey: .heatindexF)
        self.dewpointC = try container.decodeIfPresent(Double.self, forKey: .dewpointC)
        self.dewpointF = try container.decodeIfPresent(Double.self, forKey: .dewpointF)
        self.willItRain = try container.decodeIfPresent(Double.self, forKey: .willItRain)
        self.chanceOfRain = try container.decodeIfPresent(Double.self, forKey: .chanceOfRain)
        self.willItSnow = try container.decodeIfPresent(Double.self, forKey: .willItSnow)
        self.chanceOfSnow = try container.decodeIfPresent(Double.self, forKey: .chanceOfSnow)
        self.visKM = try container.decodeIfPresent(Double.self, forKey: .visKM)
        self.visMiles = try container.decodeIfPresent(Double.self, forKey: .visMiles)
        self.gustMph = try container.decodeIfPresent(Double.self, forKey: .gustMph)
        self.gustKph = try container.decodeIfPresent(Double.self, forKey: .gustKph)
        self.uv = try container.decodeIfPresent(Double.self, forKey: .uv)
    }
}

//// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}

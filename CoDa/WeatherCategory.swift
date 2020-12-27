

import Foundation
// создаем структуры в которых прописываем ключи по которым будем получать нужные данные
struct WeatherCategory: Codable {
    let timezone: String
    let daily: [Daily]
    
}

struct Daily: Codable {
    let dt: Int
    let temp: Temp
    var date: Date {
        Date(timeIntervalSince1970: TimeInterval(dt))
    }
}

struct Temp: Codable {
    let day: Double
    let night: Double
}



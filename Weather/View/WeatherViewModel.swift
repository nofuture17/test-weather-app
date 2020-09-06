import UIKit

struct WeatherViewModel {
    private let weather: Weather
    private let iconImage: UIImage
    
    init(weather: Weather) {
        self.weather = weather
        let iconMapper = WeatherKindIconMapper(kind: weather.kind)
        iconImage = iconMapper.getIconImage()
    }
    
    var temperature: String {
        return String(Int(weather.temperature)) + "˚C"
    }
    var appearentTemperature: String {
        return "Looks like: " + String(Int(weather.appearentTemperature)) + "˚C"
    }
    var humidity: String {
        return String(Int(weather.humidity)) + "%"
    }
    var pressure: String {
        return String(Int(weather.pressure)) + "mm"
    }
    var icon: UIImage {
        return iconImage
    }
}

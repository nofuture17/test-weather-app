import UIKit

struct Weather {
    enum Kind {
        case clear, rain, cloudy, partlyCloudy, sleet, snow, someOther
    }
    
    let temperature: Double
    let appearentTemperature: Double
    let humidity: Double
    let pressure: Double
    let kind: Kind
}

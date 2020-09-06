import UIKit

struct WeatherKindIconMapper {
    private let kind: Weather.Kind
    
    init(kind: Weather.Kind) {
        self.kind = kind
    }
    
    func getIconImage() -> UIImage {
        switch kind {
        case .clear:
            return UIImage(named: "clear")!
        case .rain:
            return UIImage(named: "rain")!
        case .cloudy:
            return UIImage(named: "cloudy")!
        case .partlyCloudy:
            return UIImage(named: "partly-cloudy")!
        case .sleet:
            return UIImage(named: "sleet")!
        case .snow:
            return UIImage(named: "snow")!
        default:
            return UIImage(named: "unpredicted-icon")!
        }
    }
}

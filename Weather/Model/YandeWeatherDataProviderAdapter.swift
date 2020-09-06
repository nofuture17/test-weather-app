import YandexWeather

class YandeWeatherDataProviderAdapter: WeatherDataProviderProtocol {
    private let provider: YandexWeather.WeatherDataProvider
    
    init(provider: YandexWeather.WeatherDataProvider) {
        self.provider = provider
    }
    
    func setLocation(_ location: Location) {
        provider.setLocation(location)
    }
    
    func getCurrentWeather(complete: @escaping (Weather?, String?) -> Void) {
        provider.getCurrentWeather(complete: {(response, error) in
            if let error = error {
                complete(nil, error)
                return
            }
            guard let response = response else {
                complete(nil, "Ошибка обращения к сервису")
                return
            }
            complete(self.convertWeather(response: response), nil)
        })
    }
    
    private func convertWeather(response: YandexWeather.WeatherResponse) -> Weather {
        return Weather(temperature: response.fact.temp, appearentTemperature: response.fact.feels_like, humidity: response.fact.humidity, pressure: response.fact.pressure_mm, kind: convertWeatherKind(kind: response.fact.condition))
    }

    private func convertWeatherKind(kind: String) -> Weather.Kind {
        switch kind {
        case "clear":
            return Weather.Kind.clear
        case "cloudy":
            return Weather.Kind.cloudy
        case "partly-cloudy":
            return Weather.Kind.partlyCloudy
        case "rain":
            return Weather.Kind.rain
        case "moderate-rain":
            return Weather.Kind.rain
        case "heavy-rain":
            return Weather.Kind.rain
        case "wet-snow":
            return Weather.Kind.sleet
        case "snow":
            return Weather.Kind.snow
        default:
            return Weather.Kind.someOther
        }
    }
}

extension Location: YandexWeather.Location {}

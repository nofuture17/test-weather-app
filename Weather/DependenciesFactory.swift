import YandexWeather

class DependenciesFactory {
    static func getWeatherDataProvider() -> WeatherDataProviderProtocol {
        let yandexWeatherProvider = YandexWeather.WeatherDataProvider(key: "07366492-7f91-45a7-b49e-937efc2770e6")
        return YandeWeatherDataProviderAdapter(provider: yandexWeatherProvider)
    }
}

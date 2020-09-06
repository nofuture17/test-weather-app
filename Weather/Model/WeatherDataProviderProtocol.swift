protocol WeatherDataProviderProtocol {
    func setLocation(_ location: Location)
    func getCurrentWeather(complete: @escaping (Weather?, String?) -> Void)
}

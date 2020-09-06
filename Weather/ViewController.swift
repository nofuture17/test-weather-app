//
//  ViewController.swift
//  Weather
//
//  Created by Анна on 03.09.2020.
//  Copyright © 2020 ar2041@bk.ru. All rights reserved.
//

import UIKit
//TODO вынести клент в пакет, подключить и добавить адаптер
class ViewController: UIViewController {
    // MARK: - view
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var watherIconView: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var appearentTemperatureLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        refreshWeather()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appearLocation()
        refreshWeather()
    }
    
    private func updateUIWith(weather: Weather) {
        let viewModel = WeatherViewModel(weather: weather)
        watherIconView.image = viewModel.icon
        pressureLabel.text = viewModel.pressure
        humidityLabel.text = viewModel.humidity
        temperatureLabel.text = viewModel.temperature
        appearentTemperatureLabel.text = viewModel.appearentTemperature
    }
    
    private func hideRefreshButton() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            self.refreshButton.alpha = 0
        })
    }
    
    private func showRefreshButton() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            self.refreshButton.alpha = 1
        })
    }
    
    private func alert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
    
    // MARK: - model
    private lazy var weatherProvider: WeatherDataProviderProtocol = {
        let provider = DependenciesFactory.getWeatherDataProvider()
        provider.setLocation(location)
        return provider
    }()
    private lazy var location: Location = {
        return LocationDataProvider().getCurrentLocation()
    }()
    
    // MARK: - viewModel
    private func appearLocation() {
        locationLabel.text = location.name
    }
    
    private func refreshWeather() {
        hideRefreshButton()
        DispatchQueue.global().async {
            self.weatherProvider.getCurrentWeather(complete: {
                (weather: Weather?, error: String?) in
                DispatchQueue.main.async {
                    self.showRefreshButton()
                    guard let weather = weather else {
                        var message = "Не удалось получить данные погоды"
                        if let error = error {
                            message = message + ": " + error
                        }
                        self.alert(message: message)
                        return
                    }
                    self.updateUIWith(weather: weather)
                }
            })
        }
    }
}


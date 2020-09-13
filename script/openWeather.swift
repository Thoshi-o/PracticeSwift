/*
 Sample delegate , execute in playground
 Need to add Const file in Sources directory
*/

import UIKit
import PlaygroundSupport

protocol WeatherDelegate {
    func callOpenWeatherMap() -> Void
    func createRequestURL() -> String
    func parseJson(_ data:Data)  -> NSDictionary?
}

extension WeatherDelegate {
    func parseJson(_ data:Data) -> NSDictionary? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
            return json
        } catch {
            return nil
        }
    }
    func callOpenWeatherMap() {
        let requestURL = URL(string : createRequestURL())
        let task = URLSession.shared.dataTask(with: requestURL!, completionHandler: { data, response, error in
            guard let json = self.parseJson(data!) else {return}
            print(json)
        })
        task.resume()
    }
}

class Forecaster {
    var delegate : WeatherDelegate?
    func forecast () {
        guard let delegate = delegate else {
            print("There is nothing to forecast today")
            return
        }
        
        if type(of: delegate) == ForecastOfCity.self {
            delegate.callOpenWeatherMap()
        }
        
        // TODO another type of forecast
    }
}

class ForecastOfCity : WeatherDelegate {
    private let city : String
    init (city : String) {
        self.city = city
    }
    func createRequestURL() -> String {
        return Constants.baseURL.appendingFormat("weather?q=\(self.city)&appid=\(Constants.apiKey)")
    }
}

let forecaster = Forecaster()
let city = ForecastOfCity(city : "Tokyo")
forecaster.delegate = city
forecaster.forecast()


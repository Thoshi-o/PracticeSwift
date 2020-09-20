/*
 Sample delegate , execute in playground
 Need to add Const file in Sources directory
*/

import UIKit
import PlaygroundSupport

protocol WeatherDelegate {
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
    func callOpenWeatherMap(weatherCompletionHandler:@escaping (_ Data : NSDictionary? ,Error?) -> NSDictionary?) {
        let requestURL = URL(string : createRequestURL())
        let task = URLSession.shared.dataTask(with: requestURL!, completionHandler: { data, response, error in
            guard let json = self.parseJson(data!) else {return}
            print(type(of:json))
            weatherCompletionHandler(json,nil)
        })
        task.resume() // notice asynchronus
    }
    func convertTime(_ time:String) {
        
    }
}

class TimeConverter {
    func convertTime (_ time:Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "Asia/Tokyo")
        dateFormatter.dateFormat = "yyyyMMddHH"
        dateFormatter.string(from: Date())
    }
}

class Forecaster {
    var delegate : WeatherDelegate?
    var test : NSDictionary?
    func forecast () {
        guard let delegate = delegate else {
            print("There is nothing to forecast today")
            return
        }
        
        if type(of: delegate) == ForecastOfCity.self {
            delegate.callOpenWeatherMap(weatherCompletionHandler:{ data ,error in
                if let resData = data{
                    print(resData)
                }
                return data;
            })
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



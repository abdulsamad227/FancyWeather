import Foundation
import CoreData
import RxSwift
class WeatherViewModel {
    var weatherModel = PublishSubject<WeatherModel>()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let historyViewModel = HistoryViewModel.shared
    
    public func getData(for city: String) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=25286c71d78f4ce52c1b304b12dfec90") else {return}
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, respon, error in
            if error != nil {
                print("here 1")
                print(error!.localizedDescription)
                return
            }
            if let safeData = data {
                self.fetchData(data: safeData)
            }
        }
        task.resume()
    }
    
    func fetchData(data: Data) {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(Weather.self, from: data)
            let newWeatherModel = WeatherModel(context: self.context)
            newWeatherModel.cityName = decodedData.name
            newWeatherModel.tempreture = round(10 * decodedData.main.temp) / 10
            newWeatherModel.image = self.getProperImageBased(on: decodedData.weather.last!.id)
            self.weatherModel.onNext(newWeatherModel)
            
            try self.context.save()
            // new data has been added to cache so we need to load new data also
            self.historyViewModel.loadDataFromCache()
        } catch {
            print("here 2")
            print(error.localizedDescription)
        }
        
    }
    
    func getProperImageBased(on id: Int) -> String{
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.sun"
        default:
            return "cloud"
        }
    }
    
}



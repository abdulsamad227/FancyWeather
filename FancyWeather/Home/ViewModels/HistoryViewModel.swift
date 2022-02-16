//
//  CellViewModel.swift
//  FancyWeather
//
//  Created by Abdulsamad on 14/02/2022.
//

import Foundation
import CoreData
import RxSwift
import RxRelay
class HistoryViewModel {
    static let shared = HistoryViewModel()
    var historyModel = PublishRelay<[WeatherModel]>()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public func loadDataFromCache() {
        print("dataFromCache")
        let requst: NSFetchRequest<WeatherModel> = WeatherModel.fetchRequest()
        do {
            let weathers = try context.fetch(requst)
            historyModel.accept(weathers)
        } catch {
            print("Error")
        }
    }
    
}

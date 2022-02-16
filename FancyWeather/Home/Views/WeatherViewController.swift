//
//  ViewController.swift
//  FancyWeather
//
//  Created by Abdulsamad on 14/02/2022.
//

import UIKit
import RxSwift
import RxCocoa
class WeatherViewController: UIViewController {
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherConditionImageView: UIImageView!
    @IBOutlet weak var tempretureLabel: UILabel!
    
    let weatherViewModel = WeatherViewModel()
    private var weatherModel: PublishSubject<WeatherModel>?
    let bag = DisposeBag()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // binding view with viewModel
        weatherModel = weatherViewModel.weatherModel
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        bindUI()
    }

    func bindUI() {
        var chosenCity: String?
        searchBar.rx.text.orEmpty
            .subscribe(onNext: {
                value in
                chosenCity = value
            })
            .disposed(by: bag)
        
        searchBar.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: {
                guard chosenCity != nil  else {return}
                self.weatherViewModel.getData(for: chosenCity!)
                self.searchBar.resignFirstResponder()
            })
            .disposed(by: bag)
        
        searchBtn.rx.tap.subscribe(
            onNext: {
                guard chosenCity != ""  else {return}
                self.weatherViewModel.getData(for: chosenCity!)
                self.searchBar.resignFirstResponder()
            }
        )
        .disposed(by: bag)
        
        if let weatherModel = weatherModel {
            weatherModel.subscribe(onNext: {
                weather in
                DispatchQueue.main.async {
                    self.cityLabel.text = weather.cityName
                    self.tempretureLabel.text = "\(weather.tempreture) C"
                    self.weatherConditionImageView.image = UIImage(systemName: weather.image!)
                }
            }).disposed(by: bag)
        }
    }
}


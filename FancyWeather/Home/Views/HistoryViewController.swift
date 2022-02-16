//
//  RecentViewController.swift
//  FancyWeather
//
//  Created by Abdulsamad on 14/02/2022.
//

import UIKit
import RxSwift
import RxCocoa
class HistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var historyModel: PublishRelay<[WeatherModel]>?
    private var historyViewModel = HistoryViewModel.shared
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(HistoryCustomTableViewCell.nib(), forCellReuseIdentifier: HistoryCustomTableViewCell.id)
        historyModel = historyViewModel.historyModel
        bindUI()
        historyViewModel.loadDataFromCache()
    }
    
    func bindUI() {
        historyModel?.bind(to: tableView.rx.items(cellIdentifier: HistoryCustomTableViewCell.id,cellType: HistoryCustomTableViewCell.self)) {
            (row , element, cell) in
          
            if let image = element.image, let cityName = element.cityName {
                cell.weatherImage.image = UIImage(systemName: image)
                cell.cityLabel.text = cityName
                cell.tempretureLabel.text = "\(element.tempreture) C"
            }
//
        }
        .disposed(by: bag)
        
        
    }
    
}

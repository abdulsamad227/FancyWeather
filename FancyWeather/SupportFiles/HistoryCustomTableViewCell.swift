//
//  HistoryCustomCellTableViewCell.swift
//  FancyWeather
//
//  Created by Abdulsamad on 14/02/2022.
//

import UIKit

class HistoryCustomTableViewCell: UITableViewCell {
    static let id = "HistoryCell"
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempretureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "HistoryCustomTableViewCell", bundle: nil)
    }
    
   
}

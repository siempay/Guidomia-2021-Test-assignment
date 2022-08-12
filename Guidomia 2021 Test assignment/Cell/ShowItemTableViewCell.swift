//
//  ShowItemTableViewCell.swift
//  Guidomia 2021 Test assignment
//
//  Created by Brahim El Mssilha on 12/8/2022.
//

import UIKit

class ShowItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stackRating: UIStackView!
    @IBOutlet weak var imageViewCar: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    
    @IBOutlet weak var labelBottom: UILabel!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setupRating(rate: Int) {
        
        stackRating.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for _ in 0..<rate {
            
            let label = UILabel()
            label.text = "⭐️"
            stackRating.addArrangedSubview(label)
        }
        
        if rate <= 3 {
            trailingConstraint.constant = -stackRating.frame.size.width * 0.3
        }
    }
    
}

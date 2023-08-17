//
//  ProductCell.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/13/23.
//

import UIKit

class ProductCell: PageCollectionCell {
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var empty: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindViewModel(_ viewModel: Product) {
        let price = String(viewModel.Price.clean)
        let unit = "triệu / m\u{00B2}"
        let priceWithUnit = price + unit
        
        let font: UIFont = .boldSystemFont(ofSize: 16)
        let fontUnit: UIFont = .boldSystemFont(ofSize: 14)
        let colorUnit: UIColor = UIColor(hex: "#607D8B")!
        let attPrice: NSMutableAttributedString = NSMutableAttributedString(string: priceWithUnit, attributes: [.font:font])
        attPrice.setAttributes([.font: fontUnit], range: NSRange(location:priceWithUnit.count - 5, length: 4))
        attPrice.setAttributes([.foregroundColor: colorUnit], range: NSRange(location:priceWithUnit.count - 5, length: 5))

        self.priceLabel.attributedText = attPrice
        self.nameLabel.text = viewModel.Title
        self.addressLabel.text = viewModel.Address
        self.thumb.setImage(with: URL(string: viewModel.Images)) {[unowned self] (_,error,_,_) in
            if error == nil {
                empty.hidden()
            } else {
                empty.visible()
            }
        }
    }
}

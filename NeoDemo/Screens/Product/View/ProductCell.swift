//
//  ProductCell.swift
//  NeoDemo
//
//  Created by Apple on 21/06/24.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productTitleLabel: UILabel!
    
    @IBOutlet weak var productCategory: UILabel!
    
    @IBOutlet weak var productPrice: UILabel!
    
    var product: ProdData? {
        didSet {
            productConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func productConfiguration(){
        guard let product else {return}
        
        productTitleLabel.text = product.name
        productCategory.text = product.producer
        productPrice.text = "Rs. \(product.cost)"
        productImageView.setImage(with: product.product_images)
    }
    
}

//
//  ActivitiesCell.swift
//  Demo
//
//  Created by CLships on 2024/6/12.
//

import UIKit
import Kingfisher

class ActivitiesCell: UICollectionViewCell {
    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var idL: UILabel!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var subView: ActivitiesSubView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setView(obj:DemoResults.DataList){
        idL.text = String(obj.id)
        titleL.text = obj.title
        
        if let url = URL(string: obj.thumbnailUrl) {
            KingfisherManager.shared.retrieveImage(with: url) { [self] result in
                switch result {
                case .success(let value):
                    imgV.image = value.image
                case .failure(_):
                    print("Error downloading image: ActivitiesCell(id).\(obj.id)")
                    break;
                }
            }
        }else{
            print("Error id:\(obj.id) thumbnailUrl")
        }
        
        if let count = obj.product?.count {
            if count > 0 {
                print("api_6 id:\(obj.id) product count:\(count)")
                self.subView.setProductData(data: obj.product!)
            }else{
                print("api_6 product empty")
            }
        }
    }
}

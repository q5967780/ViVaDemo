//
//  ActivitiesSubCell.swift
//  Demo
//
//  Created by CLships on 2024/6/12.
//

import UIKit
import Kingfisher

class ActivitiesSubCell: UICollectionViewCell {
    
    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var idL: UILabel!
    @IBOutlet weak var titleL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setView(obj:DemoResults.DataList.DataProduct){
        idL.text = String(obj.id)
        titleL.text = obj.title
        
        if let url = URL(string: obj.thumbnailUrl) {
            print("url id:\(obj.id), link:\(obj.thumbnailUrl)")
            KingfisherManager.shared.retrieveImage(with: url) { [self] result in
                switch result {
                case .success(let value):
                    imgV.image = value.image
                case .failure(_):
                    print("Error downloading image: CampaignCell(id).\(obj.id)")
                    break;
                }
            }
        }else{
            print("Error id:\(obj.id) thumbnailUrl")
        }
    }
}

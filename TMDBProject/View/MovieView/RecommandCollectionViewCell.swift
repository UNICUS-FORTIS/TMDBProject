//
//  RecommandCollectionViewCell.swift
//  TMDBProject
//
//  Created by LOUIE MAC on 2023/08/17.
//

import UIKit
import Kingfisher

class RecommandCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backdropForRCMD: UIImageView!
    @IBOutlet weak var titleForRCMD: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backdropForRCMD.image = nil
    }
    
    func configureCell(item: Recommand) {
        DispatchQueue.main.async {
            self.titleForRCMD.text = item.title
            if let backDropPath = item.backdropPath {
                let imageUrl = URL.createRecommandationIMG(for: backDropPath)
                self.backdropForRCMD.kf.setImage(with: imageUrl)
            } else {
                print("noimage")
            }
        }
    }
    
    
}

//
//  MovieCollectionViewCell.swift
//  TMDBProject
//
//  Created by LOUIE MAC on 2023/08/12.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        posterImageView.contentMode = .scaleAspectFit
        contentView.backgroundColor = .clear
    }

    func cellConfigure(item: Movie) {
        DispatchQueue.main.async {
            let posterURL = URL.createRecommandationIMG(for: item.posterPath)
            self.posterImageView.kf.setImage(with: posterURL)
            // MARK: - 모서리가 이상하게 깎임.
//            self.posterImageView.layer.cornerRadius = self.posterImageView.frame.width/6
//            self.posterImageView.clipsToBounds = true
        }
    }
}



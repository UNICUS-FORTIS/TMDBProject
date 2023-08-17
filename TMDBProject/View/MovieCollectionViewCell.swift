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
        
        titleLabel.font = .boldSystemFont(ofSize: 12)
        titleLabel.numberOfLines = 0
        posterImageView.contentMode = .scaleAspectFit
        contentView.backgroundColor = .clear
    }

    func cellConfigure(item: Movie) {
        DispatchQueue.main.async {
            self.titleLabel.text = item.title
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/original\(item.posterPath)")
            self.posterImageView.kf.setImage(with: imageUrl)
            // MARK: - 모서리가 이상하게 깎임.
            self.posterImageView.layer.cornerRadius = self.posterImageView.frame.width/6
            self.posterImageView.clipsToBounds = true
        }
    }
}



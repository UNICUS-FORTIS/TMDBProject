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
        titleLabel.font = .boldSystemFont(ofSize: 12)
        titleLabel.numberOfLines = 0
        contentView.backgroundColor = .clear

    }
    
    func cellConfigure(item: Movie) {
        DispatchQueue.main.async {
            self.titleLabel.text = item.title
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/original\(item.posterPath)")
            self.posterImageView.kf.setImage(with: imageUrl)
        }
    }
}



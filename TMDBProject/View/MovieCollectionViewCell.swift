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
    @IBOutlet weak var releasedLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.image = UIImage(named: "demo")
        posterImageView.contentMode = .scaleAspectFit
        titleLabel.font = .boldSystemFont(ofSize: 12)
        titleLabel.numberOfLines = 0
        releasedLabel.font = .systemFont(ofSize: 11)
        contentView.backgroundColor = .clear
    }
    
    func cellConfigure(item: Movie) {
        
        titleLabel.text = item.title
        releasedLabel.text = item.released
        DispatchQueue.main.async {
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/original\(item.poster)")
            self.posterImageView.kf.setImage(with: imageUrl)
        }
    }
}


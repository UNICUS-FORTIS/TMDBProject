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
        
        posterImageView.contentMode = .scaleAspectFill
        contentView.backgroundColor = .clear
        posterImageView.backgroundColor = .clear
    }

    func cellConfigure(item: Movie) {
        DispatchQueue.main.async {
            let posterURL = URL.getMovieImage(for: item.posterPath)
            self.posterImageView.kf.setImage(with: posterURL)
        }
    }
    
    override func layoutSubviews() {
        self.posterImageView.layer.cornerRadius = self.posterImageView.frame.width/6
        self.posterImageView.clipsToBounds = true
    }
}



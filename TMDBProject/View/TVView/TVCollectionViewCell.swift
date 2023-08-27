//
//  TVCollectionViewCell.swift
//  TMDBProject
//
//  Created by LOUIE MAC on 2023/08/21.
//

import UIKit

class TVCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backDropImageView.image = nil
        posterImageView.image = nil
        titleLabel.text = nil
    }
    
    
    func cellConfigure(item: TV) {
        DispatchQueue.main.async {
            let posterUrl = URL.getMovieImage(for: item.posterPath)
            let backDropUrl = URL.getMovieImage(for: item.backdropPath)
            self.posterImageView.kf.setImage(with: posterUrl)
            self.backDropImageView.kf.setImage(with: backDropUrl)
            self.titleLabel.text = item.name
            self.titleLabel.font = .boldSystemFont(ofSize: 25)
            self.titleLabel.numberOfLines = 0
            self.titleLabel.backgroundColor = .init(white: 1, alpha: 0.7)
            self.backDropImageView.contentMode = .scaleAspectFill
            self.backDropImageView.alpha = 0.7
            self.posterImageView.contentMode = .scaleAspectFit
            // MARK: - 모서리가 이상하게 깎임.
            //            self.posterImageView.layer.cornerRadius = self.posterImageView.frame.width/6
            //            self.posterImageView.clipsToBounds = true
        }
    }
}

//
//  DetailViewController.swift
//  TMDBProject
//
//  Created by LOUIE MAC on 2023/08/15.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    var movie: Movie?
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var descriptionTV: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .black
        setupUI()
    }
    
    private func setupUI() {
        backdropImageView.contentMode = .scaleAspectFill
        backdropImageView.alpha = 0.7
        titleLabel.font = .boldSystemFont(ofSize: 25)
        titleLabel.numberOfLines = 0
        rateLabel.font = .boldSystemFont(ofSize: 22)
        descriptionTV.font = .systemFont(ofSize: 17)
        descriptionTV.textAlignment = .left
        descriptionTV.isEditable = false
    }
    
    
    func setupDetails(item: Movie) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let backdropURL = URL(string: "https://image.tmdb.org/t/p/original\(item.backdrop)")
            let posterURL = URL(string: "https://image.tmdb.org/t/p/original\(item.poster)")
            self.backdropImageView.kf.setImage(with: backdropURL)
            self.posterImageView.kf.setImage(with: posterURL)
            self.titleLabel.text = item.title
            self.rateLabel.text = String(item.rate)
            self.descriptionTV.text = item.overview
            print(#function)
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
}

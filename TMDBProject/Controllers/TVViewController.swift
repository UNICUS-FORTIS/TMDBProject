//
//  TVViewController.swift
//  TMDBProject
//
//  Created by LOUIE MAC on 2023/08/21.
//

import UIKit

class TVViewController: UIViewController {
    
    
    let networkmanager = NetworkManager.shared
    
    @IBOutlet weak var collectionTVView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var tvDataArray:[TV] = []
    var tvTopRatedArray:[TVTopRated] = []
    var tvPopularArray:[PopularTV] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCVCell()
        registerTVCell()
        //        registerCVHeader()
        configureCollectionView()
        collectionTVView.dataSource = self
        tableView.dataSource = self
        tableView.rowHeight = 120
        loadAllDatas()
    }
    
    
    private func registerCVCell() {
        let nib = UINib(nibName: TVCollectionViewCell.identifier, bundle: nil)
        collectionTVView.register(nib, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
    }
    
    private func registerTVCell() {
        let nib = UINib(nibName: TVTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TVTableViewCell.identifier)
    }
    
    //    private func registerCVHeader() {
    //        let headerNib = UINib(nibName: "TVHeaderCollectionReusableView", bundle: nil)
    //        collectionTVView.register(headerNib,
    //        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
    //        withReuseIdentifier: "TVHeaderCollectionReusableView")
    //    }
    
    private func loadAllDatas() {
        let tvGroup = DispatchGroup()
        
        tvGroup.enter()
        DispatchQueue.global().async {
            self.fetchTrendingData(term: "week")
            tvGroup.leave()
        }
        
        tvGroup.enter()
        DispatchQueue.global().async {
            self.fetchPopularTVData()
            tvGroup.leave()
        }

        tvGroup.enter()
        DispatchQueue.global().async {
            self.fetchTopRatedTVData()
            tvGroup.leave()
        }
        
        tvGroup.notify(queue: .main) {
            self.collectionTVView.reloadData()
            self.tableView.reloadData()
            print(self.tvTopRatedArray.count, self.tvPopularArray.count)
        }
    }
    
    private func fetchTrendingData(term: String) {
        
        networkmanager.fetchTVData(url: URL.createTredingTVURL(for: term)) { [weak self] trending in
            self?.tvDataArray = trending.results
            self?.collectionTVView.reloadData()
        }
    }
    
    private func fetchPopularTVData() {
        networkmanager.fetchGenericTVData(url: URL.popularTVURL, dataModel: PopularTVData.self) { [weak self] popularTV in
            self?.tvPopularArray = popularTV.results
            self?.tableView.reloadData()
        }
    }
    
    private func fetchTopRatedTVData() {
        networkmanager.fetchGenericTVData(url: URL.topratedTVURL, dataModel: TopRatedData.self) { [weak self] topRated in
            self?.tvTopRatedArray = topRated.results
            self?.tableView.reloadData()
        }
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let spacing:CGFloat = 10
        let width = collectionTVView.frame.width - spacing*2
        let height = collectionTVView.frame.height
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: spacing*2)
        layout.minimumLineSpacing = spacing * 2
        layout.scrollDirection = .horizontal
        //        layout.headerReferenceSize = CGSize(width: collectionTVView.frame.width, height: 20)
        collectionTVView.collectionViewLayout = layout
        collectionTVView.showsHorizontalScrollIndicator = false
        collectionTVView.isPagingEnabled = true
    }
    
    @IBAction func segmentedCtrTapped(_ sender: UISegmentedControl) {
        tableView.reloadData()
        print(tvTopRatedArray.count, tvPopularArray.count)
    }
}


extension TVViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionTVView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as? TVCollectionViewCell else { return UICollectionViewCell() }
        cell.cellConfigure(item: tvDataArray[indexPath.item])
        
        return cell
    }
    
    //    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //
    //    if kind == UICollectionView.elementKindSectionHeader {
    //
    //        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TVHeaderCollectionReusableView", for: indexPath) as? TVHeaderCollectionReusableView else { return UICollectionReusableView() }
    //
    //    view.titleLabel.text = "TV Trending"
    //
    //    return view
    //
    //    } else {
    //        return UICollectionReusableView() }
    //    }
}

extension TVViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentControl.selectedSegmentIndex == 0 {
            return tvPopularArray.count
        } else {
            return tvTopRatedArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TVTableViewCell.identifier) as? TVTableViewCell else { return UITableViewCell() }
        
        if segmentControl.selectedSegmentIndex == 0 {
            cell.cellConfigureForTopRated(item: tvTopRatedArray[indexPath.item])
        } else {
            cell.cellConfigureForPopular(item: tvPopularArray[indexPath.item])
        }
        
        return cell
    }
}

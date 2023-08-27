//
//  ThirdIntroViewController.swift
//  TMDBProject
//
//  Created by LOUIE MAC on 2023/08/27.
//

import UIKit
import SnapKit

class ThirdIntroViewController: UIViewController {

    let startButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Get Started", for: .normal)
        btn.tintColor = .systemPink
        btn.layer.cornerRadius = 18
        btn.clipsToBounds = true
        btn.backgroundColor = .black
        btn.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        view.addSubview(startButton)
        
        startButton.snp.makeConstraints { make in
            make.width.equalTo(view).multipliedBy(0.7)
            make.height.equalTo(50)
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-150)
        }
    }
    
    @objc func startButtonTapped() {
        let userdefault = UserDefaults.standard
        userdefault.set(true, forKey: "isLoggedIn")
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: MovieViewController.identifier) as! MovieViewController

        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    

  
}

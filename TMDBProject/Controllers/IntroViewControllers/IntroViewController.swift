//
//  IntroViewController.swift
//  TMDBProject
//
//  Created by LOUIE MAC on 2023/08/27.
//

import UIKit

class IntroViewController: UIPageViewController {
    
    
    private var list: [UIViewController] = []
    var pageControl : UIPageControl!
    
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.list = [FirstIntroViewController(),
                     SecondIntroViewController(),
                     ThirdIntroViewController()]
        
        dataSource = self
        delegate = self
        
        guard let first = list.first else {return}
        setViewControllers([first], direction: .forward, animated: true)
        
        pageControl = UIPageControl(frame: CGRect(x:0, y:self.view.frame.height - 100, width:self.view.frame.width, height:50))
        pageControl.backgroundStyle = .prominent
        pageControl.backgroundColor = .clear
        pageControl.numberOfPages = list.count
        
        view.addSubview(pageControl)
    }
}


extension IntroViewController: UIPageViewControllerDataSource {
    
    // MARK: - 이전화면으로 전환했을때 호출됨 - 프린트 찍어봄
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        let previousIndex = currentIndex - 1
        return previousIndex < 0 ? nil : list[previousIndex]
    }
    
    // MARK: - 다음화면으로 전환했을때 호출됨  - 프린트 찍어봄
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        let nextIndex = currentIndex + 1
        return nextIndex >= list.count ? nil : list[nextIndex]
    }
    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//            return list.count
//    }
//
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        guard let first = viewControllers?.first, let index = list.firstIndex(of: first) else { return 0 }
//        return index
//    }
    
}

extension IntroViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed,
           let currentViewController = pageViewController.viewControllers?.first,
           let currentIndex = list.firstIndex(of: currentViewController) {
            pageControl.currentPage = currentIndex
        }
    }
}

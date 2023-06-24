//
//  DestinationHeaderContainer.swift
//  Discover
//
//  Created by Alexander Korchak on 24.06.2023.
//

import SwiftUI

struct DestinationHeaderContainer: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        let pageViewController = CustomPageViewController()
        return pageViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
}

class CustomPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    let firstVc = UIHostingController(rootView: Text("First"))
    let secondVc = UIHostingController(rootView: Text("Second"))
    let thirdVc = UIHostingController(rootView: Text("Third"))
    
    lazy var allControllers: [UIViewController] = [
        firstVc,
        secondVc,
        thirdVc
    ]
    
    init() {
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.systemGray5
        UIPageControl.appearance().currentPageIndicatorTintColor = .red
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        setViewControllers([firstVc], direction: .forward, animated: true)
        
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = allControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        if index == 0 {
            return nil
        }
        
        return allControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = allControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        if index == allControllers.count - 1 {
            return nil
        }
        
        return allControllers[index + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        allControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
}

struct DestinationHeaderContainer_Previews: PreviewProvider {
    static var previews: some View {
        DestinationHeaderContainer()
        NavigationView {
            
            PopularDestinationDetailsView(destination: Destination(name: "Paris",
                                                                   country: "France",
                                                                   imageName: "La_Tour_Eiffel",
                                                                   latitude: 48.859565,
                                                                   longitude: 2.353235))
        }
    }
}

//
//  MainTabBarViewController.swift
//  Touch Grass
//
//  Created by Joseph Somerville on 10/18/23.
//

import UIKit

struct ToolbarItem {
    let title: String
    let icon: UIImage
}

class MainTabBarViewController: UITabBarController {
    
    private let toolbarHeight: CGFloat = 50.0 // or whatever height you desire
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    var toolbarItemsList: [ToolbarItem] = [] // Populate this list as needed
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: "3A9F64")
        
        setupToolbar()
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: CreateTripViewController())
        let vc3 = UINavigationController(rootViewController: UserProfileViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "plus")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.tabBarItem.image = UIImage(systemName: "person.fill")
        
        setViewControllers([vc1, vc2, vc3], animated: true)
    }
    
    private func setupToolbar() {
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: toolbarHeight),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        // Populate the toolbar
        for item in toolbarItemsList {
            let button = createToolbarButton(item: item)
            stackView.addArrangedSubview(button)
        }
    }
    
    private func createToolbarButton(item: ToolbarItem) -> UIButton {
        let button = UIButton()
        button.setTitle(item.title, for: .normal)
        button.setImage(item.icon, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -15, right: 0)
        return button
    }
    
    // Functions to add or remove items from the toolbar as needed
    func addItemToToolbar(item: ToolbarItem) {
        let button = createToolbarButton(item: item)
        stackView.addArrangedSubview(button)
    }
    
    func removeItemFromToolbar(at index: Int) {
        let view = stackView.arrangedSubviews[index]
        stackView.removeArrangedSubview(view)
        view.removeFromSuperview()
    }
}

//
//  ViewController.swift
//  Touch Grass
//
//  Created by Joseph Somerville on 10/18/23.
//

import UIKit

struct ToolbarItem {
    let title: String
    let icon: UIImage
    let action: () -> Void
}


class MainTabBarViewController: UITabBarController {
    
    private let toolbarHeight: CGFloat = 50.0 // or whatever height you desire
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    // Lazily initialized actions:
    lazy var kayakingAction: () -> Void = {
        if let navVC = self.viewControllers?.first as? UINavigationController,
           let homeVC = navVC.viewControllers.first as? HomeViewController {
            print("Calling displayEventsOnMap with tag 'kayaking'")
            homeVC.displayEventsOnMap(withTag: "kayaking")
        }
    }



    lazy var hikingAction: () -> Void = {
        if let homeVC = self.viewControllers?.first as? HomeViewController {
            homeVC.displayEventsOnMap(withTag: "hiking")
        }
    }

    
    
    
    lazy var toolbarItemsList: [ToolbarItem] = {
        return [
            ToolbarItem(title: "Kayaking", icon: UIImage(systemName: "water.waves") ?? UIImage(), action: kayakingAction),
            ToolbarItem(title: "Hiking", icon: UIImage(systemName: "figure.hiking") ?? UIImage(), action: hikingAction)
            // ... other items
        ]
    }()

    
    
    

    
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
        
        // Populate the toolbar with hardcoded items
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

        // Add action
        button.addTarget(self, action: #selector(toolbarButtonPressed(sender:)), for: .touchUpInside)
        button.tag = toolbarItemsList.firstIndex(where: { $0.title == item.title }) ?? 0 // Use the tag property to identify the button
        
        return button
    }

    @objc func toolbarButtonPressed(sender: UIButton) {
        let item = toolbarItemsList[sender.tag]
        print("Button pressed: \(item.title)")  // Add this line to debug
        item.action()
    }

}


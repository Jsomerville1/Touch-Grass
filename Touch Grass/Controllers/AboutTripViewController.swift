//
//  AboutTripViewController.swift
//  Touch Grass
//
//  Created by Joseph Somerville on 10/18/23.
//

import UIKit

class AboutTripViewController: UIViewController {

    
    // Define the UI components
    private let titleLabel = UILabel()
    private let organizerLabel = UILabel()
    private let tripLocationLabel = UILabel()
    private let tripDistanceLabel = UILabel()
    private let categoryImageView = UIImageView()
    private let categoryLabel = UILabel()
    private let currentPeopleCountLabel = UILabel()
    private let maxPeopleCountLabel = UILabel()
    
    var event: Event? {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15.0
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        titleLabel.text = "About the Trip"
        view.addSubview(titleLabel)
        
        organizerLabel.numberOfLines = 0
        view.addSubview(organizerLabel)
        
        tripLocationLabel.numberOfLines = 0
        view.addSubview(tripLocationLabel)
        
        tripDistanceLabel.numberOfLines = 0
        view.addSubview(tripDistanceLabel)
        
        // Assuming you have the icons for each category
        categoryImageView.contentMode = .scaleAspectFit
        view.addSubview(categoryImageView)
        
        categoryLabel.numberOfLines = 0
        view.addSubview(categoryLabel)
        
        currentPeopleCountLabel.numberOfLines = 0
        view.addSubview(currentPeopleCountLabel)
        
        maxPeopleCountLabel.numberOfLines = 0
        view.addSubview(maxPeopleCountLabel)
        

    }
    
    private func setupConstraints() {
        let padding: CGFloat = 10
 
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        organizerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            organizerLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            organizerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            organizerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
        
        tripLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tripLocationLabel.topAnchor.constraint(equalTo: organizerLabel.bottomAnchor, constant: padding),
            tripLocationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            tripLocationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
        
        tripDistanceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tripDistanceLabel.topAnchor.constraint(equalTo: tripLocationLabel.bottomAnchor, constant: padding),
            tripDistanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            tripDistanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: tripDistanceLabel.bottomAnchor, constant: padding),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            categoryLabel.trailingAnchor.constraint(equalTo: categoryImageView.leadingAnchor, constant: -padding),
            categoryLabel.bottomAnchor.constraint(equalTo: categoryImageView.bottomAnchor)
        ])
        
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryImageView.centerYAnchor.constraint(equalTo: categoryLabel.centerYAnchor),
            categoryImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            categoryImageView.widthAnchor.constraint(equalToConstant: 24),
            categoryImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        currentPeopleCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentPeopleCountLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: padding),
            currentPeopleCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            currentPeopleCountLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -padding/2)
        ])
        
        maxPeopleCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            maxPeopleCountLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: padding),
            maxPeopleCountLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: padding/2),
            maxPeopleCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }

    
    private func updateUI() {
        guard let event = event else { return }
        organizerLabel.text = "Organizer: \(event.tripHost)"
        tripLocationLabel.text = "Trip Name: \(event.tripName)"
        tripDistanceLabel.text = "Distance: \(event.distance)" // Assuming tripDescription contains the distance. Adjust as needed.
        categoryLabel.text = "Category:  \(event.tag.capitalized)"
        currentPeopleCountLabel.text = "Current Persons: \(event.current)"
        maxPeopleCountLabel.text = "Maximum Persons: \(event.max)"
        
        // Update category image based on tag
        switch event.tag {
        case "hiking":
            categoryImageView.image = UIImage(named: "hiking-icon") // Replace with your image name
        case "kayaking":
            categoryImageView.image = UIImage(named: "kayaking-icon") // Replace with your image name
        default:
            break
        }
    }
    
    
    
    
}

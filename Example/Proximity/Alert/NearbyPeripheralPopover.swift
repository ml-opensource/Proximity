//
//  NearbyPeripheralPopover.swift
//  Proximity
//
//  Created by Eric Kunz on 2/20/19.
//  Copyright © 2019 Eric Kunz. All rights reserved.
//

import UIKit
import Proximity

final class NearbyPeripheralPopover: AlertCard {
	
	// MARK: - Properties
	
	private let peripheral: Peripheral
	private let stackView = UIStackView()
	private let nameLabel = UILabel()
	private let descriptionLabel = UILabel()
	private let bookButton = UIButton()
	private let moreTimesButton = UIButton()
	
	override var preferredContentSize: CGSize {
		get {
			return CGSize(width: 400, height: 250)
		}
		set {}
	}
	
	// MARK: - Initialization
	
	init(peripheral: Peripheral) {
		self.peripheral = peripheral
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - View Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		styleView()
		addSubviews()
		
		nameLabel.text = peripheral.name
		if let data = peripheral.manufacturerData {
			descriptionLabel.text = String(data: data, encoding: .utf8)
		}
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		stackView.frame = view.bounds.insetBy(dx: 32, dy: 32)
	}
	
}

extension NearbyPeripheralPopover {
	
	private func styleView() {
		view.backgroundColor = .white
	}
	
	private func addSubviews() {
		addStackView()
		addNameLabel()
		addDescriptionLabel()
		addBookButton()
	}
	
	private func addStackView() {
		view.addSubview(stackView)
		stackView.spacing = 24
		stackView.axis = .vertical
		stackView.alignment = .center
	}
	
	private func addNameLabel() {
		stackView.addArrangedSubview(nameLabel)
		nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
		nameLabel.setContentHuggingPriority(.required, for: .vertical)
		nameLabel.numberOfLines = 0
		nameLabel.textAlignment = .center
	}
	
	private func addDescriptionLabel() {
		stackView.addArrangedSubview(descriptionLabel)
		descriptionLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
		descriptionLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
		descriptionLabel.numberOfLines = 0
		descriptionLabel.textAlignment = .center
	}
	
	private func addBookButton() {
		stackView.addArrangedSubview(bookButton)
		let blue = UIColor(displayP3Red: 0, green: 122.0 / 255.0, blue: 1, alpha: 1)
		bookButton.setTitleColor(blue, for: .normal)
		bookButton.setTitle("Ok", for: .normal)
		bookButton.addTarget(self, action: #selector(bookButtonTapped), for: .touchUpInside)
		bookButton.setContentHuggingPriority(.required, for: .vertical)
	}
}

extension NearbyPeripheralPopover {
	
	@objc private func bookButtonTapped() {
		dismiss(animated: true, completion: nil)
	}
	
}


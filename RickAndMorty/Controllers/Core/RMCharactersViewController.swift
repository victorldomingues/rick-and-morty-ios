//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Victor Domingues on 26/10/23.
//

import UIKit

/// Controller to show characters
final class RMCharactersViewController: UIViewController {
    
    private let characterViewList  = CharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        view.addSubview(characterViewList)
        
        setUpView()
    }
    
    private func setUpView() {
        NSLayoutConstraint.activate([
            characterViewList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterViewList.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterViewList.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterViewList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Victor Domingues on 28/10/23.
//

import Foundation
import UIKit

final class CharacterListViewViewModel : NSObject {
    
    func fetchCharacters(){
        RMService.shared.execute( .listCharactersRequest,
                                  expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                // print(String(describing: model))
                print("Total: "+String(model.info.count))
                print("Page result count: "+String(model.results.count))
            case .failure(let error):
                print(String(describing: error))
            }
            
        }
    }
}

extension  CharacterListViewViewModel: UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemGreen
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        let height = width * 1.5
        return CGSize(
            width: width, height: height
        )
    }
}

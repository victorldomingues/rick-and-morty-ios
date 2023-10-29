//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Victor Domingues on 28/10/23.
//

import Foundation
import UIKit

protocol RMCharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
}

final class RMCharacterListViewViewModel : NSObject {
    
    public weak var delegate: RMCharacterListViewViewModelDelegate?
    
    private var characters:  [RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = RMCharacterCollectionCellViewModel(
                    characterName: character.name, characterStatus: character.status, characterImageURL: URL(string: character.image)
                )
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var cellViewModels: [RMCharacterCollectionCellViewModel] = []
    
    public func fetchCharacters(){
        RMService.shared.execute( .listCharactersRequest,
                                  expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let responseModel):
                let results  =  responseModel.results
                self.characters = results
                DispatchQueue.main.async {
                    self.delegate?.didLoadInitialCharacters()
                }
                // print(String(describing: model))
                print("Total: "+String(responseModel.info.count))
                print("Page result count: "+String(responseModel.results.count))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension  RMCharacterListViewViewModel: UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
                                                            for: indexPath) as? RMCharacterCollectionViewCell else {
            fatalError("Unsopported cell")
        }

        cell.configure(with: cellViewModels[indexPath.row])
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

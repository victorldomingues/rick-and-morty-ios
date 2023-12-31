//
//  RMCharacterCollectionViewCellModel.swift
//  RickAndMorty
//
//  Created by Victor Domingues on 28/10/23.
//

import Foundation

final class RMCharacterCollectionCellViewModel {
    
    public let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageURL: URL?
    
    init(
        characterName: String,
        characterStatus: RMCharacterStatus,
        characterImageURL: URL?
    ){
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageURL = characterImageURL
    }
    
    public var characterStatusText: String {
        return "Status: \(characterStatus.text)"
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        
        // TODO: Abstract to image manager
        
        guard let url = characterImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let request  =  URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){ data, _, error in
            guard let data  = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}

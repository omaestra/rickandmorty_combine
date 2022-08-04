//
//  UIImage+.swift
//  RickAndMorty-Combine
//
//  Created by omaestra on 17/6/21.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                return
            }
            // maybe try dispatch to main
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
        task.resume()
    }
}

//
//  APIClient2.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import Foundation

protocol APIClient2 {
    func send(_ request: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void)
}

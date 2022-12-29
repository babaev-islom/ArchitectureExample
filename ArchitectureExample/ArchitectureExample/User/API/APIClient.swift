//
//  APIClient.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import Foundation

protocol APIClient {
    func send(_ request: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void)
}

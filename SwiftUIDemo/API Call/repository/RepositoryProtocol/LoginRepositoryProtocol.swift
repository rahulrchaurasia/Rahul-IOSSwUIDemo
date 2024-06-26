//
//  LoginRepositoryProtocol.swift
//  SwiftUIDemo
//
//  Created by Rahul Chaurasia on 05/05/24.
//

import Foundation

protocol LoginRepositoryProtocol {
    func fetchUserData(email: String) async throws -> UserResponse?
}

//
//  ServicesFactory.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import Foundation

typealias ServicesAlias = HasNetworkService & HasDatabaseService

var Services: ServicesAlias { // swiftlint:disable:this variable_name
    return ServicesFactory()
}

final class ServicesFactory: ServicesAlias {
    lazy var networkService: NetworkService = NetworkServiceImp()
    lazy var databaseService: DatabaseService = DatabaseServiceImp()
}

// MARK: Singletons

private final class SingletonsPool {

}

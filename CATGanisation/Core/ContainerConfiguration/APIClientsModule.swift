//
//  APIClientsModule.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 12.09.2021.
//

import Alamofire
import Swinject
import SwinjectAutoregistration

class APIClientsModule: Assembly {
    func assemble(container: Container) {
        container.autoregister(Session.self) {
            // Change here parameters as timeout time, SSL pinning & other HTTP session related stuff
            return Session.default
        }.inObjectScope(.container)
        container.autoregister(BaseAPIClient.self, initializer: BaseAPIClient.init)
        container.autoregister(AuthApi.self) {
            return AuthAPIClient(container.resolve(Session.self)!)
        }.inObjectScope(.weak)
        container.autoregister(CatsApi.self, initializer: CatsAPIClient.init)
    }
}

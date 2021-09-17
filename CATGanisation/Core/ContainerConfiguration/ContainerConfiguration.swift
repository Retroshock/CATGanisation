//
//  ContainerConfiguration.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 12.09.2021.
//

import Swinject

var appContainer = Container()
var assembler: Assembler = Assembler([APIClientsModule(), ServiceModule()], container: appContainer)

func resolve<Service>(_ type: Service.Type) -> Service {
    guard let service = assembler.resolver.resolve(type) else {
        fatalError("Cannot find service of type \(type)")
    }
    return service
}

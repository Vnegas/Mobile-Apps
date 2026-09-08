//
//  app_router.swift
//  Calibracion
//
//  Created by Nicole Alfaro on 8/9/26.
//

import SwiftUI

enum AppRoute: Hashable {
    case mainMenu

    case herbicidas
    case fungicidas
    case dosificacion
    case ayuda

    case herbicidasVelFija
    case herbicidasVolFijo
    case herbicidasVolAplic

    case fungicidasArea
    case fungicidasPlanta
}

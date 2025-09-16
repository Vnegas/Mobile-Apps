//
//  extensiones.swift
//  Calibracion
//
//  Created by Camila Rodriguez Aguila on 28/8/25.
//

import SwiftUI
import UIKit

extension View {
    /// Oculta el teclado llamando a resignFirstResponder
    func ocultarTeclado() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                      to: nil, from: nil, for: nil)
    }
    
    /// Modifier que cierra el teclado al hacer tap fuera de los TextFields
    func salirTecladoTap() -> some View {
        self.onTapGesture {
            ocultarTeclado()
        }
    }
}

// MARK: - UIApplication Extension
extension UIApplication {
    /// Método alternativo para cerrar el teclado
    func terminarEdicion() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

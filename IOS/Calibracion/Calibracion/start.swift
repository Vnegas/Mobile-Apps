//
//  start.swift
//  Calibracion
//
//  Created by vnegas on 15/10/24.
//  Copyright 2023-2024-2025 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct start: View {
    @Binding var startBind: Bool

    @State private var path = NavigationPath()
    @State private var showPopup = false

    var body: some View {
        GeometryReader { geometry in

            NavigationStack(path: $path) {

                VStack {
                    Spacer(minLength: geometry.size.height * 0.02)

                    // MARK: - UCR Logo

                    Image("ucr_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: geometry.size.width * 0.45,
                            height: geometry.size.height * 0.2
                        )

                    Spacer(minLength: geometry.size.height * 0.03)

                    // MARK: - EEAFBM Logo

                    Image("eeafb")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: geometry.size.width * 0.7,
                            height: geometry.size.height * 0.1
                        )

                    Spacer(minLength: geometry.size.height * 0.05)

                    // MARK: - App Title

                    Text("Calibración")
                        .foregroundColor(.black)
                        .font(
                            .custom(
                                "NotoSerifDisplay-ExtraCondensedItalic",
                                size: geometry.size.width * 0.11
                            )
                        )
                        .fontWeight(.bold)

                    Spacer(minLength: geometry.size.height * 0.02)

                    // MARK: - App Version

                    Text("V1.0")
                        .foregroundColor(.black)
                        .font(
                            .custom(
                                "NotoSerifDisplay-ExtraCondensedItalic",
                                size: geometry.size.width * 0.08
                            )
                        )
                        .fontWeight(.bold)

                    Spacer(minLength: geometry.size.height * 0.25)

                    // MARK: - Enter App Button

                    Button {
                        // Main Menu becomes the first destination
                        path.removeLast(path.count)
                        path.append(AppRoute.mainMenu)

                    } label: {

                        Text("Entrar")
                            .foregroundColor(.black)
                            .font(
                                .custom(
                                    "GlacialIndifference-Regular",
                                    size: geometry.size.width * 0.09
                                )
                            )
                            .tracking(15)
                            .frame(
                                width: geometry.size.width,
                                height: geometry.size.height * 0.1
                            )
                            .background(Color.accentColor)
                    }
                }
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height
                )
                .overlay(
                    PopupView(
                        showPopup: $showPopup,
                        geometry: geometry
                    )
                    .opacity(showPopup ? 1 : 0)
                )
                .onAppear {
                    showPopup = true
                }

                // MARK: - Navigation destinations

                .navigationDestination(for: AppRoute.self) { route in

                    switch route {

                    case .mainMenu:
                        menu(path: $path)

                    case .herbicidas:
                        herbicidas(path: $path)

                    case .fungicidas:
                        fungicidas(path: $path)

                    case .dosificacion:
                        dosificacion(path: $path)

                    case .ayuda:
                        ayuda(path: $path)

                    case .herbicidasVelFija:
                        herbicidas_vel_fija(path: $path)

                    case .herbicidasVolFijo:
                        herbicidas_vol_fijo(path: $path)

                    case .herbicidasVolAplic:
                        herbicidas_vol_apl(path: $path)

                    case .fungicidasArea:
                        fungicidas_area(path: $path)

                    case .fungicidasPlanta:
                        fungicidas_planta(path: $path)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


// MARK: - Popup

struct PopupView: View {
    @Binding var showPopup: Bool
    let geometry: GeometryProxy

    var body: some View {

        VStack {

            Spacer(minLength: geometry.size.height * 0.02)

            Text("ADVERTENCIA")
                .foregroundColor(.red)
                .font(
                    .custom(
                        "GlacialIndifference-Regular",
                        size: geometry.size.width * 0.07
                    )
                )

            Spacer(minLength: geometry.size.height * 0.02)

            HStack {

                Spacer(minLength: geometry.size.width * 0.05)

                Text("""
                Descargo de responsabilidad:
                El uso de la aplicación móvil Calibración y sus resultados corre por cuenta y riesgo propio del usuario.
                La Universidad de Costa Rica no asumirá ninguna responsabilidad por cualquier pérdida o daño causado por el uso o la información generada en esta aplicación.
                """)
                .foregroundColor(.black)
                .font(
                    .custom(
                        "GlacialIndifference-Regular",
                        size: geometry.size.width * 0.04
                    )
                )
                .multilineTextAlignment(.center)

                Spacer(minLength: geometry.size.width * 0.05)
            }

            Spacer(minLength: geometry.size.height * 0.02)

            // Accept Button

            Button {
                showPopup = false
            } label: {

                Text("Aceptar")
                    .font(
                        .custom(
                            "GlacialIndifference-Regular",
                            size: geometry.size.width * 0.05
                        )
                    )
                    .frame(
                        width: geometry.size.width * 0.3,
                        height: geometry.size.height * 0.07
                    )
                    .foregroundColor(.accentColor)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(
                                        Color.accentColor,
                                        lineWidth: 2
                                    )
                            )
                    )
            }
            .padding(.bottom, geometry.size.height * 0.02)
        }
        .frame(
            width: geometry.size.width * 0.85,
            height: geometry.size.height * 0.6
        )
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}


#Preview {
    start(startBind: .constant(true))
}

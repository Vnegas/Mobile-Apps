//
//  ContentView.swift
//  Calibracion
//
//  Created by vnegas on 25/9/24.
//  Copyright 2023-2024 Sebastian Venegas Brenes https://github.com/Vnegas/Mobile-Apps
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("menu_bg")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                
                LazyVStack {
                    Text("Calibracion")
                        .foregroundColor(.white)
                        .font(.custom("NotoSerifDisplay-ExtraCondensedItalic", size: 44))
                        .fontWeight(.bold)
                    
                    
                    NavigationLink(destination: herbicidas()) {
                        Text("HERBICIDAS")
                            .frame(width: 300, height: 100, alignment: .center)
                            .background(Color.white).foregroundColor(.accent)
                        
                    }.border(Color.accent, width: 5).cornerRadius(80)
                    
                }
            }
        }
    }
    
    
    
}

#Preview {
    ContentView()
}

// FUENTES
// Cambria
// GlacialIndifference-Regular
// NotoSerifDisplay-ExtraCondensed
// NotoSerifDisplay-ExtraCondensedItalic

/*
 init() {
     for familyName in UIFont.familyNames {
         print(familyName)
         for fontName in UIFont.fontNames(forFamilyName:
                                             familyName) {
             print("-- \(fontName)")
         }
     }
 }
 */

// ATRAS BOTON
/*
 @Environment(\.presentationMode) private var
     presentationMode: Binding<PresentationMode>
 
 
 Spacer()
     .navigationBarBackButtonHidden(true)
     .toolbar(content: {
         ToolbarItem(placement:
                 .navigationBarLeading) {
                     Button(action: {
                         presentationMode.wrappedValue.dismiss()
                     }, label: {
                         Text("Atrás").foregroundColor(.black)
                     })
                            
                }
    })
 */

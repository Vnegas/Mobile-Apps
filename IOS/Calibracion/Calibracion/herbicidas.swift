//
//  herbicidas.swift
//  Calibracion
//
//  Created by vnegas on 25/9/24.
//

import SwiftUI

struct herbicidas: View {
    
    @Environment(\.presentationMode) private var
        presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
    }
}

#Preview {
    herbicidas()
}

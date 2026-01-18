//
//  ContentView.swift
//  kokuhaku_visionos
//
//  Created by Mia Pienitz on 16.01.26.
//

import SwiftUI
import RealityKit
#if os(xros)
    // Only compile this block when building for visionOS 26 or newer
    import RealityKitContent
#endif

struct ContentView: View {
    var body: some View {
        VStack {
            #if os(xros)
                Model3D(named: "Scene", bundle: realityKitContentBundle)
                    .padding(.bottom, 50)
            #else
                Text("3D content requires visionOS 26.0")
                    .padding(.bottom, 50)
                Text("RealityKitContent not available on this OS")
                    .padding(.bottom, 50)
            #endif
            Text("Hello, world!")
        }.padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}

//
//  PhotoLibSwiftUIApp.swift
//  Shared
//
//  Created by Marat Say on 7/6/20.
//

import SwiftUI

@main
struct PhotoLibSwiftUIApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView(deps: Dependencies())
    }
  }
}

struct PhotoLibSwiftUIApp_Previews: PreviewProvider {
  static var previews: some View {
    /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
  }
}

//
//  SwiftUIDemoApp.swift
//  SwiftUIDemo
//
//  Created by Rahul Chaurasia on 25/02/23.
//

import SwiftUI

@main
struct SwiftUIDemoApp: App {
    
   @StateObject   var listViewModel: ListViewModel = ListViewModel()
    var body: some Scene {
        WindowGroup {
          
            NavigationView {
               HomeUIView()
                
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewModel)
            
            /*************************environmentObject**********************************/
            // Note : environmentObject hold all the data which it get
            // and carry till NavigationView hirearchy exist.
            
            /* Yo Use : refer ListView
            @EnvironmentObject var listViewModel : ListViewModel
             get all the ListViewModel data
            /**************************************************************************/ */
             
        }
    }
}

struct Previews_SwiftUIDemoApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

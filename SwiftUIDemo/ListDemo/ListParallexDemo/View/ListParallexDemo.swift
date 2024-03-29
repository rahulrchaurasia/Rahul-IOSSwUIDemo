//
//  ListParallexDemo.swift
//  SwiftUIDemo
//
//  Created by Rahul Chaurasia on 30/12/23.
//

import SwiftUI


struct ListParallexDemo: View {
    
    //@StateObject var homeData = HomeViewModel()
    
    @EnvironmentObject var homeData: HomeViewModel
    @Environment(\.colorScheme) var scheme

    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        ScrollView {
            // Since we're pinning header view
            parallexheader
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .overlay(
            // Only Safe Area
            (scheme == .dark ? Color.black : Color.white)
                .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.top)
                .ignoresSafeArea(.all, edges: .top)
                .opacity(homeData.offset > 250 ? 1 : 0)
            ,alignment: .top
        )
        // Used it EnvironmentObject for accessing all sub objects
       // .environmentObject(homeData)
    }
}


private extension ListParallexDemo {
    
    func handleDismissAll(){
        
        if #available(iOS 15, *){
            
            dismiss()
        }else{
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    var parallexheader : some View {
        
        LazyVStack(alignment: .leading, spacing: 15, pinnedViews: [.sectionHeaders], content: {

            // Parallax header
            GeometryReader { reader -> AnyView in
                let offset = reader.frame(in: .global).minY
                if -offset > 0 {
                    DispatchQueue.main.async {
                        self.homeData.offset = -offset
                    }
                }
                return AnyView(
                    Image("food")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            width: UIScreen.main.bounds.width,
                            height: 250 + (offset > 0 ? offset : 0)
                        )
                        .cornerRadius(2)
                        .offset(y: (offset > 0 ? -offset : 0))
                        .overlay(
                            HStack {
                                Button(action: {}, label: {
                                    Image(systemName: "arrow.left")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.white)
                                })

                                Spacer()

                                Button(action: {}, label: {
                                    Image(systemName: "suit.heart.fill")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.white)
                                })
                            }
                            .padding()
                            , alignment: .top
                        )
                )
            }
            .frame(height: 250)

            // Cards
            Section(header: HeaderView(){
                
                handleDismissAll()
            }) {
                // Tabs with content
                ForEach(tabsItems) { tab in
                    VStack(alignment: .leading, spacing: 15, content: {
                        Text(tab.tab)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.bottom)
                            .padding(.leading)

                        ForEach(tab.foods) { food in
                            CardView(food: food)
                        }

                        Divider()
                            .padding(.top)
                    })
                    .tag(tab.tab)
                    .overlay(
                        GeometryReader { reader -> Text in
                            // Calculate tab
                            let offset = reader.frame(in: .global).minY
                            // Top area plus header size 100
                            let height = UIApplication.shared.windows.first!.safeAreaInsets.top + 100
                            if offset < height && offset > 50 && homeData.selectedTab != tab.tab {
                                DispatchQueue.main.async {
                                    self.homeData.selectedTab = tab.tab
                                }
                            }
                            return Text("")
                        }
                    )
                }
            }
        })
    }
}
#Preview {
    ListParallexDemo()
}

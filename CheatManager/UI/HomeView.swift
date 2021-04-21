//
//  HomeView.swift
//  CheatManager
//
//  Created by evelyn on 2021-04-16.
//

import SwiftUI
import UIKit

let net = NetworkHandling()

struct HomeView: View {
	@State var image: UIImage = UIImage(named: "Stickerpack")!
    
    // TODO: Handle this via JSON parsing from API without freezing the UI
    @State var featuredCheats: [StoreCheat] = []
    
    let arcadeCheats = [
        StoreCheat(id: "11", author: "rpwnage", version: "0.0.1", description:"Lorem ipsum dolor kernel picknic dpick Lorem ipsum dolor kernel picknic dpick Lorem ipsum dolor kernel picknic dpick ", gameIcon: "SubwaySurfersIcon", gameBanner: "Stickerpack", gameName: "Subway Surfers", gameBundleID: "com.some.bundle", gameVersion: "17.2.3"),
        StoreCheat(id: "11", author: "rpwnage", version: "0.0.1", description:"Lorem ipsum dolor kernel picknic dpick Lorem ipsum dolor kernel picknic dpick Lorem ipsum dolor kernel picknic dpick ", gameIcon: "SubwaySurfersIcon", gameBanner: "Stickerpack", gameName: "Subway Surfers", gameBundleID: "com.some.bundle", gameVersion: "17.2.3")
    ]
	
    var body: some View {
        NavigationView {
            List {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
							ForEach(featuredCheats) { featuredCheat in
                                // TODO: Show CheatDetailView with the data from featured card
								FeaturedCardView(image: $image, mod: FeaturedPage.CardPackage(imglink: featuredCheat.gameBanner, title: featuredCheat.gameName, mod: Mod(icon: "", name: featuredCheat.gameName, id: featuredCheat.id, gameBundleID: featuredCheat.gameBundleID, gameName: featuredCheat.gameName, maintainer: featuredCheat.author)).mod)
									.frame(width: 300, height: 200)
									.padding()
							}
                        }
                    }
                    Spacer()
                }.onAppear {
                    CMAPI().getFeaturedCheats { (featuredCheats) in
                        self.featuredCheats = featuredCheats.data
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Arcade Games")
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                    HStack() {
                            ForEach(arcadeCheats) { cheat in
                                MarketRowView(storeCheat: cheat)
                                    .padding(.leading)
                            }
                        }
                }.padding(.leading, 5)
            }
			.navigationTitle(Text("Market"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

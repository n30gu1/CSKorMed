//
//  LearnMoreView.swift
//  CSKorMed
//
//  Created by Sung Park on 7/21/23.
//

import SwiftUI

struct LearnMoreView: View {
    var name: String
    var location: String
    var treatment: String
    var method: String
    var efficacy: String
    
    @State private var showMore = false
    
    @Namespace private var animation
    
    var body: some View {
        ZStack {
            if !showMore {
                Text("\(name)")
                    .matchedGeometryEffect(id: "Name", in: animation)
                    .font(.system(size: 8))
                    .padding(4)
                    .glassBackgroundEffect()
                    .rotation3DEffect(Angle(degrees: 45.0), axis: (1, 0, 0))
                    .rotation3DEffect(Angle(degrees: 45.0), axis: (0, 1, 0))
            }
            
            if showMore {
                VStack(alignment: .leading) {
                    Text(name)
                        .matchedGeometryEffect(id: "Name", in: animation)
                        .font(.title)
                    Divider()
                    if !location.isEmpty {
                        HStack(alignment: .top) {
                            Text("위치")
                                .bold()
                            Text(location)
                        }
                    }
                    if !treatment.isEmpty {
                        HStack(alignment: .top) {
                            Text("주치")
                                .bold()
                            Text(treatment)
                        }
                    }
                    if !method.isEmpty {
                        HStack(alignment: .top) {
                            Text("침구법")
                                .bold()
                            Text(method)
                        }
                    }
                    if !efficacy.isEmpty {
                        HStack(alignment: .top) {
                            Text("효능")
                                .bold()
                            Text(efficacy)
                        }
                    }
                }
                .padding()
                .glassBackgroundEffect()
                .offset(y: -150)
            }
        }
        .padding()
        .onTapGesture {
            withAnimation(.spring) {
                self.showMore.toggle()
            }
        }
        .frame(maxWidth: 450, alignment: .bottom)
    }
}

#Preview {
    LearnMoreView(
        name: "TestComponent",
        location: "Location",
        treatment: "Treatment",
        method: "Method",
        efficacy: "Efficacy"
    )
    .tag("z")
}

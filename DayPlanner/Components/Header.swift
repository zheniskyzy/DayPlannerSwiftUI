//
//  Header.swift
//  DayPlanner
//
//  Created by Madina Olzhabek on 20.11.2024.
//

import SwiftUI

struct Header: View {
    
    @State var leftImage: String = ""
    @State var rightImage: UIImage? = nil
    var onLeftImageTapped: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            Image(systemName: leftImage)
                .foregroundStyle(Color.white)
                .font(.title)
                .padding(30)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    onLeftImageTapped?()
                }

            if let image = rightImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundStyle(.white)
                    .frame(width: 55, height: 55)
                    .background(Color.plannerYellow)
                    .cornerRadius(12)
            } else {
                Rectangle()
                    .fill(.plannerYellow.opacity(0.3))
                    .frame(width: 55, height: 55)
                    .cornerRadius(12)
                    .overlay {
                        Image(systemName: "person.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white.opacity(0.7))
                    }
            }
            
        }
        .padding(.trailing, 30)
    }
}

#Preview {
    ZStack {
        Color.plannerGreen.ignoresSafeArea()
        Header()
    }
    
}

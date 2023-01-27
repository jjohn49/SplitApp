//
//  TripSummary.swift
//  SplitApp
//
//  Created by John Johnston on 1/26/23.
//

import SwiftUI

struct TripSummary: View {
    //maybe add a confetti cannon
    var body: some View {
        ScrollView {
            Text("What Happens in Vegas... You Get The Rest ").font(.largeTitle).padding()
            Spacer(minLength: 50)
            TopPayers()
            
            Text("Congratulations to Jack Who Fronted").font(.title).padding()
            //ChartView()
        }.foregroundColor(.blue).bold()
    }
}

struct TopPayers: View{
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10).stroke()
            HStack(alignment: .bottom){
                Podium(height: 100, place: 2, user: Users(_id: "JJ", password: "", fName: "", lName: "", email: ""))
                Podium(height: 150, place: 1, user: Users(_id: "Jack", password: "", fName: "", lName: "", email: ""))
                Podium(height: 50, place: 3, user: Users(_id: "John", password: "", fName: "", lName: "", email: ""))
            }.padding()
        }.padding()
        
    }
}

struct Podium: View{
    let height: CGFloat
    let place: Int
    let user: Users
    var body: some View{
        VStack{
            UserProfilePicture(user: user)
            ZStack {
                Rectangle()
                Text("\(place)").foregroundColor(.white).bold().font(.largeTitle)
            }.frame(height: height)
        }
    }
}

struct UserProfilePicture: View{
    let user: Users
    var body: some View{
        ZStack(alignment: .bottom) {
            Circle()
            ZStack {
                RoundedRectangle(cornerRadius: 7).frame(height: 30).foregroundColor(.gray)
                Text(user._id).foregroundColor(.white)
            }
        }
    }
}

struct TripSummary_Previews: PreviewProvider {
    static var previews: some View {
        TripSummary()
    }
}

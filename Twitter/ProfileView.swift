//
//  ProfileView.swift
//  Twitter
//
//  Created by Zainul on 27/06/23.
//

import SwiftUI

struct DataUserModel : Identifiable {
    let id : String = UUID().uuidString
    let image : String
    let imageFeed : String
    let name : String
    let caption : String
    let username : String
    let commentCount : Int
    let retweetCount : Int
    let likeCount : Int
    let viewCount : Int
    let isVerfied : Bool
}

class DataUser : ObservableObject {
    @Published var dataUserArray : [DataUserModel] = []
    
    init() {
        getUser()
    }
    
    func getUser() {
        let user1 = DataUserModel(image: "zainul", imageFeed: "feed", name: "Zainul", caption: "Hello World", username: "@zainuull_", commentCount: 100, retweetCount: 150, likeCount: 900, viewCount: 40, isVerfied: true)
        
        let user2 = DataUserModel(image: "basyar", imageFeed: "feed1", name: "Basyar", caption: "twitter clone", username: "@basyar123", commentCount: 20, retweetCount: 10, likeCount: 200, viewCount: 20, isVerfied: false)
        
        let user3 = DataUserModel(image: "zainul", imageFeed: "feed2", name: "Zainul", caption: "lagi bobo", username: "@zainuull_", commentCount: 160, retweetCount: 215, likeCount: 900, viewCount: 40, isVerfied: true)
        
        let user4 = DataUserModel(image: "basyar", imageFeed: "feed3", name: "Basyar", caption: "Semeru 🇮🇩", username: "@basyar123", commentCount: 200, retweetCount: 300, likeCount: 400, viewCount: 20, isVerfied: false)
        
        let user5 = DataUserModel(image: "zainul", imageFeed: "feed6", name: "Zainul", caption: "Beautiful", username: "@zainuull_", commentCount: 10, retweetCount: 150, likeCount: 400, viewCount: 400, isVerfied: true)
        
        //Append
        self.dataUserArray.append(user1)
        self.dataUserArray.append(user2)
        self.dataUserArray.append(user3)
        self.dataUserArray.append(user4)
        self.dataUserArray.append(user5)
    }
}


struct ProfileView: View {
    
    @StateObject var dataUser : DataUser = DataUser()
    
    let transition : AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    
    
    @State var sectionTab : Int = 1
    

    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottom){
                
                CircleAdd()
                    .zIndex(2)
                
                TabView(selection: $sectionTab){
                    Home()
                        .tabItem {
                            Image(systemName: "house.fill")
                        }.tag(1)
                    
                    Search()
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                        }.tag(2)
                    
                    Notifications()
                        .tabItem {
                            Image(systemName: "bell")
                        }.tag(3)
                    
                    Email()
                        .tabItem {
                            Image(systemName: "mail")
                        }.tag(4)
                }.accentColor(.black)
                
            }
        }
        .environmentObject(dataUser)
    }
}


// MARK: HOME
struct Home: View {
    
    @EnvironmentObject var dataUser : DataUser
    @AppStorage("signed_in") var isSignedIn : Bool = false
    @State var selection : String = "Untuk Anda"
    
    let filterOption : [String] = [
    "Untuk Anda", "Mengikuti"
    ]
    
    init() {
        let attributes : [NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor.systemBlue
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected)
    }
    
    var body: some View {
        ZStack(alignment: .top){

            VStack{
                HStack{
                    Photo(image: "zainul", width: 40, height: 40)
                    Spacer()
                    Button {
                        SignOut()
                    } label: {
                        Image("twitter")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .offset(x:-180)
                    }
                    
                }
                .padding(.leading)
                Picker(selection: $selection) {
                    ForEach(filterOption, id: \.self) { index in
                        Text(index)
                            .tag(index)
                    }
                } label: {
                    
                }
                .pickerStyle(SegmentedPickerStyle())

            }
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .zIndex(3)
            
            
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading, spacing: 20){
                    ForEach(dataUser.dataUserArray) { user in
                        Feed(image: user.image, name: user.name, caption: user.caption, username: user.username, imageFeed: user.imageFeed, commentCount: user.commentCount, retweetCount: user.retweetCount, likeCount: user.likeCount, viewCount: user.viewCount)
                    }
                }
                .padding(.top,100)
            }
            
        }
        .font(.title2)
    }
}

extension Home {
    func SignOut() {
        withAnimation(.spring()) {
            isSignedIn = false
        }
    }
}

struct Feed : View {
    
    
    @State var isRetweet : Bool = false
    @State var isLike : Bool = false
    
    let image : String
    let name : String
    let caption : String
    let username : String
    let imageFeed : String
    let commentCount : Int
    @State var retweetCount : Int
    @State var likeCount : Int
    let viewCount : Int
    
    var body : some View {
        VStack(alignment: .leading){
            HStack{
                Photo(image: image, width: 50, height: 50)
                
                Text(name)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.blue)
                
                Text(username)
                    .foregroundColor(.gray)
                
                Text(" -2h")
                    .foregroundColor(.gray)

            }.font(.system(size:16))
            
            Text(caption)
                .font(.system(size:16))
            
            Image(imageFeed)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 350, height: 400)
                .cornerRadius(20)
            
            HStack(spacing: 25){
                HStack {
                    Image(systemName: "message")
                    Text("\(commentCount)")
                }
                HStack {
                    Image(systemName: "arrow.up.arrow.down")
                        .onTapGesture {
                            isRetweet.toggle()
                            if isRetweet {
                                retweetCount += 1
                            } else {
                                retweetCount -= 1
                            }
                        }
                    Text("\(retweetCount)")
                }
                .foregroundColor(isRetweet ? .green : .black)
                
                HStack {
                    Image(systemName: isLike ? "heart.fill" : "heart")
                        .onTapGesture {
                            isLike.toggle()
                            if isLike {
                                likeCount += 1
                            } else {
                                likeCount -= 1
                            }
                        }
                    Text("\(likeCount)")
                }
                .foregroundColor(isLike ? .red : .black)
                
                HStack{
                    Image(systemName: "chart.bar")
                    Text("\(viewCount)")
                }
                Image(systemName: "square.and.arrow.down")
            }.font(.callout)
        }
    }
}


// MARK: SEARCH
struct Search : View {
    
    @State var textFieldText : String = ""
    
    var body : some View{
        ZStack {
            ScrollView{
                VStack(alignment: .leading){
                    HStack {
                        Photo(image: "zainul", width: 40, height: 40)
                        TextField("Search on Twitter", text: $textFieldText)
                            .font(.headline)
                            .padding(.horizontal)
                            .frame(height: 40)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(20)
                        
                        Image(systemName: "gearshape")
                    }
                    .font(.title2)
                    .overlay(
                        Capsule()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 1)
                            .offset(y:10)
                        ,alignment: .bottom
                    )
                    
                    Text("Tren untuk Anda")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.vertical)
                    
                    VStack(alignment: .leading, spacing: 25) {
                        TrenList(title1: "Sedang tren dalam topik Indonesia", title2: "Umur 25", title3: "17,2 rb Tweet")
                        
                        TrenList(title1: "Sedang tren dalam topik Indonesia", title2: "EMANG BOLEH SEGANTENG INI", title3: "12,1 rb Tweet")
                        
                        TrenList(title1: "Sedang tren dalam topik Indonesia", title2: "Arafah", title3: "106 rb Tweet")
                        
                        TrenList(title1: "Sedang tren dalam topik Indonesia", title2: "Pandeglang", title3: "19,2 rb Tweet")
                        
                        Text("Tampilkan lebih banyak")
                            .foregroundColor(.blue)
                            .offset(y:5)
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 2)
                            .offset(y:-5)
                    }
                    

                    
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .zIndex(5)
    }
}


// MARK: LIVE
struct Live : View {
    var body : some View {
        ZStack{
            ScrollView {
                VStack(alignment: .leading){
                    HStack(spacing: 30){
                        Photo(image: "zainul", width: 40, height: 40)
                        Text("Twitter")
                            .font(.title)
                    }
                }
            }
        }
    }
}


//MARK: NOTIFICATIONS
struct Notifications : View {
    
    @State var isSelected : Bool = false
    @State var xEdge : Double = -130
    @State var selection : String = "Sebutkan"
    
    let filterOption : [String] = [
    "Senua", "Terverifikasi", "Sebutkan"
    ]
    
    var body : some View {
        ZStack{
            ScrollView {
                VStack(spacing: 5){
                    HStack(spacing: 20) {
                        Photo(image: "zainul", width: 40, height: 40)
                        Text("Notifikasi")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                        Image(systemName: "gearshape")
                    }
                    Spacer()
                    HStack{
                        Picker(selection: $selection) {
                            ForEach(filterOption, id: \.self) { index in
                                Text(index)
                                    .tag(index)
                            }
                        } label: {
                            
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Text("There is nothing here")
                        .font(.title)
                        .foregroundColor(.gray)
                        .offset(y:UIScreen.main.bounds.height * 0.35)
                }.padding(.horizontal)
            }
        }
    }
}


//MARK: EMAIL
struct Email: View {
    
    @State var textFieldText : String = ""
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 10){
                HStack {
                    Photo(image: "zainul", width: 40, height: 40)
                    TextField("Search Direct Message", text: $textFieldText)
                        .font(.headline)
                        .padding(.horizontal)
                        .frame(height: 40)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
                    
                    Image(systemName: "gearshape")
                }
                .overlay(
                    Capsule()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 1)
                        .offset(y:10)
                    ,alignment: .bottom
                )
                
                Spacer()
                
                Text("Selamat datang di kotak masuk Anda!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Katakan sesuatu, bagikan Tweet dan lainnya lewat percakapan pribadi dengan orang lain di Twitter.")
                    .foregroundColor(.gray)
                
                Text("Tulis pesan")
                    .font(.system(size:18, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(.black)
                    .cornerRadius(20)
                    .offset(y:19)
                
                Spacer()
                
            }.padding(.horizontal)
        }
    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

// MARK: COMPONENTS
struct Photo: View {
    
    let image : String
    let width : CGFloat
    let height : CGFloat
    
    var body: some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .clipShape(Circle())
    }
}

struct TrenList: View {
    
    let title1 : String
    let title2 : String
    let title3 : String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title1)
                .foregroundColor(.gray)
            Text(title2)
                .fontWeight(.semibold)
            Text(title3)
                .foregroundColor(.gray)
        }
        .font(.headline)
    }
}

struct CircleAdd: View {
    
    @AppStorage("signed_in") var isSignedIn : Bool = false
    
    var body: some View {
        Button {
            SignOut()
        } label: {
            Circle()
                .fill(Color("primary"))
                .overlay(
                    Image(systemName: "plus")
                        .font(.system(size:25))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                )
                .frame(width: 60, height: 60)
                .offset(x:140, y:-65)
        }
    }
}


extension CircleAdd {
    func SignOut() {
        withAnimation(.spring()) {
            isSignedIn = false
        }
    }
}

//
//  DetailView.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 26/09/22.
//

import SwiftUI
import StarRateView

struct DetailView: View {
    
    @StateObject var detailVM: DetailViewModel
    @StateObject var imgVM: GameImageViewModel
    
    @State private var showMore = false
    @State private var liked = false
    private var currentGame: Result? = nil
    private var currentFavoriteGame: FavoriteGames? = nil
    @State private var temporaryDetail: FavoriteGameModel? = nil
    
    init(game: Result? = nil, favoriteGame: FavoriteGames? = nil){
        if game != nil {
            _imgVM = StateObject(wrappedValue: GameImageViewModel(backgroundImage: game?.backgroundImage ?? ""))
            _detailVM = StateObject(wrappedValue: DetailViewModel(id: String(game?.id ?? 0)))
            self.currentGame = game
            
        } else {
            _imgVM = StateObject(wrappedValue: GameImageViewModel(backgroundImage: favoriteGame?.image ?? ""))
            _detailVM = StateObject(wrappedValue: DetailViewModel(id: String(favoriteGame?.idGame ?? 0)))
            self.currentFavoriteGame = favoriteGame
        }
        
    }
    
    
    var body: some View {
        ZStack{
            Color.theme.background.ignoresSafeArea()
            if detailVM.getDetailIsError {
                ErrorPageView(title: "Oops! Connection lost!", title2: "Please check your internet connection and try again", withButton: true, tryAgainAction: {
                    
                    if currentFavoriteGame != nil {
                        if let currentFavoriteGame = currentFavoriteGame {
                            detailVM.reloadDetail(id: String(currentFavoriteGame.idGame ))
                        }
                    } else {
                        if let currentGame = currentGame {
                            detailVM.reloadDetail(id: String(currentGame.id ?? 0))
                        }
                    }
                })
            } else {
                ZStack {
                    GameBackgroundView
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 5){
                            GameLabelView
                            RateView
                            DescriptionView
                            DetailInfoList
                            StoreView
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                } // zstack
                .foregroundColor(Color.theme.primaryText)
                .redacted(reason: detailVM.detailGame == nil ? .placeholder : [])
            }
        }
    }
}


extension DetailView {
    
    private var GameBackgroundView: some View {
        VStack{
            if let image = imgVM.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                    .overlay( LinearGradient(gradient: Gradient(colors: [.theme.background.opacity(0.25), .theme.background]), startPoint: .top, endPoint: .bottom))
                    .clipped()
                    .ignoresSafeArea()
            } else if imgVM.isLoading {
                Color.gray.opacity(0.5)
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                    .overlay( LinearGradient(gradient: Gradient(colors: [.theme.background.opacity(0.25), .theme.background]), startPoint: .top, endPoint: .bottom))
                    .clipped()
                    .ignoresSafeArea()
            } else {
                VStack {
                    Image("noimage")
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text("No Image")
                        .font(.caption)
                        .foregroundColor(.theme.primaryText)
                }.opacity(0.5)
                    .padding(.bottom, 120)
                    .frame(width: UIScreen.main.bounds.width, height: 300)
            }
            Spacer()
        }
    }
    
    private var GameLabelView: some View {
        HStack {
            Text(detailVM.detailGame?.name ?? "-")
                .font(.title)
                .fontWeight(.heavy)
            Spacer()
            
            Button {
                if currentGame == nil {
                    if let currentFavoriteGame = currentFavoriteGame {
                        if temporaryDetail == nil {
                            temporaryDetail = detailVM.doAddToFavorites(game: FavoriteGameModel(
                                idGame: Int(currentFavoriteGame.idGame),
                                name: currentFavoriteGame.name ?? "Aurel",
                                genres: currentFavoriteGame.genres ?? "",
                                rating: currentFavoriteGame.rating ,
                                releasedDate: currentFavoriteGame.releasedDate ?? "",
                                image: currentFavoriteGame.image ?? ""))
                        } else {
                            detailVM.doAddToFavorites(game: FavoriteGameModel(
                                idGame: Int(temporaryDetail?.idGame ?? 0),
                                name: temporaryDetail?.name ?? "Aurel",
                                genres: temporaryDetail?.genres ?? "",
                                rating: temporaryDetail?.rating ?? 0.0 ,
                                releasedDate: temporaryDetail?.releasedDate ?? "",
                                image: temporaryDetail?.image ?? ""))
                        }
                        
                    }
                } else {
                    if let currentGame = currentGame {
                        detailVM.doAddToFavorites(game: FavoriteGameModel(
                            idGame: currentGame.id ?? 0,
                            name: currentGame.name ?? "Aurel",
                            genres: GameViewUtils.loadGenres(genres: currentGame.genres ?? []),
                            rating: currentGame.rating ?? 0.0,
                            releasedDate: currentGame.released ?? "",
                            image: currentGame.backgroundImage ?? ""))
                    }
                }
                
            } label: {
                Image(systemName: detailVM.isFavorite ? "heart.fill" : "heart")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(detailVM.isFavorite ? .theme.pink : .theme.primaryText)
            }
            
            
        }
        
        .padding(.top, 150)
    }
    
    private var RateView: some View {
        HStack{
            StarRateView(starCount: 5, rate: detailVM.detailGame?.rating ?? 0.0)
                .starSize(15)
                .starPadding(3)
            Text(String(format: "%.2f", detailVM.detailGame?.rating ?? 0.0))
                .font(.system(size: 13))
                .padding(.top, 3)
            
            Spacer()
        }
        .padding(.bottom)
    }
    
    private var DescriptionView: some View {
        VStack {
            let description = detailVM.detailGame?.descriptionRaw ?? "-"
            let descriptionTitle = description.prefix(description.count / 4)
            let descriptionRemaining = description.suffix(description.count - (description.count / 4))
            VStack(spacing: 0){
                if showMore {
                    Text(descriptionTitle + descriptionRemaining)
                        .multilineTextAlignment(.leading)
                        .font(.caption)
                        .frame(maxWidth:UIScreen.main.bounds.width - 25)
                    
                    
                    Button {
                        withAnimation {
                            showMore.toggle()
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("Show Less")
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding(.bottom)
                                .foregroundColor(Color.theme.primaryText)
                        }
                    }
                    
                }
                else {
                    
                    Text(descriptionTitle)
                        .multilineTextAlignment(.leading)
                        .font(.caption)
                        .frame(maxWidth:UIScreen.main.bounds.width - 25)
                    
                    Button {
                        withAnimation {
                            showMore.toggle()
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("Show More")
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding(.bottom)
                                .foregroundColor(Color.theme.primaryText)
                        }
                    }
                    
                }
            }
            
            
        }
    }
    
    private var DetailInfoList: some View {
        VStack {
            DetailItemView(
                title: "Platforms",
                description: GameViewUtils.loadPlatforms(platforms: detailVM.detailGame?.platforms ?? []))
            DetailItemView(
                title: "Genre",
                description: GameViewUtils.loadGenres(genres: detailVM.detailGame?.genres ?? []))
            DetailItemView(
                title: "Developer",
                description: GameViewUtils.loadDevelopers(developers: detailVM.detailGame?.developers ?? []))
            DetailItemView(
                title: "Age rating",
                description: detailVM.detailGame?.esrbRating?.name ?? "-")
            DetailItemView(
                title: "Release Date",
                description: DateFormatterUtil.formatDate(date: detailVM.detailGame?.released ?? "-"))
            DetailItemView(
                title: "Publiser",
                description: GameViewUtils.loadPublishers(publishers: detailVM.detailGame?.publishers ?? []))
            DetailItemView(
                title: "Website",
                description: detailVM.detailGame?.website ?? "-")
        }
        
    }
    
    private var StoreView: some View {
        VStack(alignment: .leading){
            Text("Where to buy")
                .foregroundColor(Color.theme.primaryText.opacity(0.7))
                .font(.caption)
                .padding(.bottom)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    if let stores = detailVM.detailGame?.stores {
                        ForEach(stores, id: \.id){ store in
                            StoreButtonVIew(storeName: store.store?.name ?? ""
                            )
                        }
                    }
                }
            }
        }
        .padding(.vertical)
    }
}



struct TextView: UIViewRepresentable {
    var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        textView.textAlignment = .justified
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}

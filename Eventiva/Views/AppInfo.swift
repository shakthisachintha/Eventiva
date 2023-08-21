import SwiftUI

struct AppInfo: View {
    var body: some View {
        VStack{
            VStack(spacing: 20) {
            Image("app-icon-eventiva") // Replace "AppLogo" with the name of your app logo image asset
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            
            Text("Eventiva")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Eventiva enables users to set and track countdowns to important events like birthdays, anniversaries, holidays, etc.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .foregroundColor(.gray)
            
            Divider()
            
            Text("-Developers-")
                .font(.headline)
            
            Text("Shakthi Sachintha")
                .foregroundColor(.gray)
            Text("Sakun Chamikara")
                .foregroundColor(.gray)
            Text("Tuan Burah (20210833/W1868945)")
                .foregroundColor(.gray)
            Text("Thenuka Weeratunga")
                .foregroundColor(.gray)
            
            
            
        }.padding()
            Spacer()
            Text("App version: v1.0.0")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct AppInfo_Previews: PreviewProvider {
    static var previews: some View {
        AppInfo()
    }
}

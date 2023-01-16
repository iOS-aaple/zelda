//
//  ContentView.swift
//  loginView
//
//  Created by mohammed alsaad on 15/01/2023.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import GoogleSignInSwift
struct Login_signupView: View {
    var body: some View {
        
        Login_signupHomeView()
            .preferredColorScheme(.dark)
    }
}

struct login_signupView_Previews: PreviewProvider {
    static var previews: some View {
        Login_signupView()
    }
}

struct Login_signupHomeView : View {
    
    @State var index = 0
    var body: some View{
        
        NavigationView{
            
            GeometryReader{_ in
                
                VStack{
                    
                    
                    ZStack{
                       // animationSequence()
                        SignUP(index: self.$index)
                            .zIndex(Double(self.index))
                        Login(index: self.$index)
                        
                    }
                    
                    HStack(spacing: 15){
                        
                        Rectangle()
                            .fill(Color("Color1"))
                            .frame(height: 1)
                            .offset(y:-150)
                        Text("OR")
                            .offset(y:-150)
                        Rectangle()
                            .fill(Color("Color1"))
                            .frame(height: 1)
                            .offset(y:-150)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 200)
                    
                    
                    HStack(spacing: 30){
                        
                        Button(action: {
                            
                        }) {
                            
                            Image("fb")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        }
                        .offset(y:-150)
                        
                        Button(action: {
                            loginUsingGoogle()
                        }) {
                            
                            Image("google")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        }
                        .offset(y:-150)
                    }
                    .padding(.top, 30)
                }
                .padding(.vertical)
            }
            .background(Image("background").edgesIgnoringSafeArea(.all))
            .offset(y: 60)
        }
    }
    func loginUsingGoogle(){
        
           guard let clientID = FirebaseApp.app()?.options.clientID else { return }
           guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}

                  // Create Google Sign In configuration object.
                  let config = GIDConfiguration(clientID: clientID)

                  GIDSignIn.sharedInstance.configuration = config
           
           GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult , err in
                      
                      if err != nil {
                          
       //                       showErrorMessage = true
       //                       errorMessage = "\(err!.localizedDescription)"
                         print("\(err!.localizedDescription)")
                      } else {
                          
                          
                  
                          self.sendData(signInResult: signInResult!)
                          
                      }
                  }
       }
    
    func sendData(signInResult:GIDSignInResult) {
        
        let signInResult = signInResult.user
            // set the data from the google
            var userID = String()
            let userName = "\(signInResult.profile!.givenName!) \(signInResult.profile!.familyName!)"
            let userEmail = "\(signInResult.profile!.email)"
            let userPassword = ""
            let userImageProfile = "\(signInResult.profile!.imageURL(withDimension: 300)!)"
        
            
            
            // generate id for the user
            
            for chart in userEmail {
                if chart != "." {
                    
                    if chart != "@" {
                        let indexItem = userID.index(userID.endIndex, offsetBy: 0)
                        userID.insert(chart, at: indexItem)
                    }
                    
                }
            }
            
        let path = "profileImages/go\(userID).png"
            
            // save profile image to the storage
            
            if let  imageURL = URL(string: userImageProfile) {
                
                URLSession.shared.dataTask(with: imageURL) { data, response, error in
                    
                    // upload image to storage
                    DispatchQueue.main.async {
                        
                        let storageRef : StorageReference!
                            storageRef = Storage.storage().reference().child(path)
                            storageRef.putData(data!)
                        
                    }
                }.resume()
            } // end of imageURL
            
            
            // save user information to the database
//        let user = User(id: userID, name: userName,email: userEmail, password: userPassword, profileImage: path,jewelry:100)
//
//            var dbRef : DatabaseReference!
//                dbRef = Database.database().reference().child("Users").child("\(userID)")
//                dbRef.setValue(["fullName":user.name,"email":user.email,"password":user.password,"profileImage":user.profileImage])
            
           
            
            // navigate to home
            
        guard let idToken = signInResult.idToken else { return }
    
        let accessToken = signInResult.accessToken
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
        
        Auth.auth().signIn(with: credential) { authResult, error in
               
            if error != nil {
                print("\(error!.localizedDescription)")
            } else {
                
                let user = User(id: authResult!.user.uid, name: userName,email: userEmail, password: userPassword, profileImage: path,jewelry:100)
                    
                    var dbRef : DatabaseReference!
                        dbRef = Database.database().reference().child("Users").child("\(authResult!.user.uid)")
                        dbRef.setValue(["fullName":user.name,"email":user.email,"password":user.password,"profileImage":user.profileImage])
                
            }
        }
        
           
        }
    

    
}


struct CShapeLogin : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            path.move(to: CGPoint(x: rect.width, y: 100))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: 0))
            
        }
    }
}


struct CShape1 : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            path.move(to: CGPoint(x: 0, y: 100))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
        }
    }
}

//struct Login : View {
//    
//    @State var email = ""
//    @State var pass = ""
//    @Binding var index : Int
//    
//    var body: some View{
//        
//        ZStack(alignment: .bottom) {
//            
//            VStack{
//                
//                HStack{
//                    
//                    VStack(spacing: 10){
//                        
//                        Text("Login")
//                            .foregroundColor(self.index == 0 ? .white : .gray)
//                            .font(.title)
//                            .fontWeight(.bold)
//                        
//                        Capsule()
//                            .fill(self.index == 0 ? Color.blue : Color.clear)
//                            .frame(width: 100, height: 5)
//                    }
//                    
//                    Spacer(minLength: 0)
//                }
//                .padding(.top, 30)
//                
//                VStack{
//                    
//                    HStack(spacing: 15){
//                        
//                        Image(systemName: "envelope.fill")
//                            .foregroundColor(Color("Color4"))
//                        
//                        TextField("Email Address", text: self.$email)
//                    }
//                    
//                    Divider().background(Color.white.opacity(0.5))
//                }
//                .padding(.horizontal)
//                .padding(.top, 40)
//                
//                VStack{
//                    
//                    HStack(spacing: 15){
//                        
//                        Image(systemName: "eye.slash.fill")
//                            .foregroundColor(Color("Color4"))
//                        
//                        SecureField("Password", text: self.$pass)
//                    }
//                    
//                    Divider().background(Color.white.opacity(0.5))
//                }
//                .padding(.horizontal)
//                .padding(.top, 30)
//                
//                HStack{
//                    
//                    Spacer(minLength: 0)
//                    
//                    Button(action: {
//
//                    }) {
//
//                        Text("Forget Password?")
//                            .foregroundColor(Color.white.opacity(1))
//
//
//
//                    }
//                    
//                }
//                .padding(.horizontal)
//                .padding(.top, 30)
//            }
//            .padding()
//            .padding(.bottom, 65)
//            .background(Color("Color2"))
//            .clipShape(CShape())
//            .contentShape(CShape())
//            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
//            .onTapGesture {
//                
//                self.index = 0
//                
//            }
//            .cornerRadius(35)
//            .padding(.horizontal,20)
//            
//            
//            Button(action: {
//                
//            }) {
//                
//                Text("LOGIN")
//                    .foregroundColor(.white)
//                    .fontWeight(.bold)
//                    .padding(.vertical)
//                    .padding(.horizontal, 50)
//                    .background(Color("Color3"))
//                    .clipShape(Capsule())
//                    .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
//            }
//            .offset(y: 25)
//            .opacity(self.index == 0 ? 1 : 0)
//        }
//        
//    }
//        
//}

// SignUP Page

//struct SignUP : View {
//
//    @State var email = ""
//    @State var pass = ""
//    @State var Repass = ""
//    @Binding var index : Int
//
//    var body: some View{
//
//        ZStack(alignment: .bottom) {
//
//            VStack{
//
//                HStack{
//
//                    Spacer(minLength: 0)
//
//                    VStack(spacing: 10){
//
//                        Text("SignUp")
//                            .foregroundColor(self.index == 1 ? .white : .gray)
//                            .font(.title)
//                            .fontWeight(.bold)
//
//                        Capsule()
//                            .fill(self.index == 1 ? Color.blue : Color.clear)
//                            .frame(width: 100, height: 5)
//                    }
//                }
//                .padding(.top, 30)
//
//                VStack{
//
//                    HStack(spacing: 15){
//
//                        Image(systemName: "envelope.fill")
//                            .foregroundColor(Color("Color4"))
//
//                        TextField("Email Address", text: self.$email)
//                    }
//
//                    Divider().background(Color.white.opacity(0.5))
//                }
//                .padding(.horizontal)
//                .padding(.top, 40)
//
//                VStack{
//
//                    HStack(spacing: 15){
//
//                        Image(systemName: "eye.slash.fill")
//                            .foregroundColor(Color("Color4"))
//
//                        SecureField("Password", text: self.$pass)
//                    }
//
//                    Divider().background(Color.white.opacity(0.5))
//                }
//                .padding(.horizontal)
//                .padding(.top, 30)
//
//
//
//                VStack{
//
//                    HStack(spacing: 15){
//
//                        Image(systemName: "eye.slash.fill")
//                            .foregroundColor(Color("Color4"))
//
//                        SecureField("Password", text: self.$Repass)
//                    }
//
//                    Divider().background(Color.white.opacity(0.5))
//                }
//                .padding(.horizontal)
//                .padding(.top, 30)
//            }
//            .padding()
//            .padding(.bottom, 65)
//            .background(Color("Color2"))
//            .clipShape(CShape1())
//            .contentShape(CShape1())
//            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
//            .onTapGesture {
//
//                self.index = 1
//
//            }
//            .cornerRadius(35)
//            .padding(.horizontal,20)
//
//            // Button
//
//            Button(action: {
//
//            }) {
//
//                Text("SIGNUP")
//                    .foregroundColor(.white)
//                    .fontWeight(.bold)
//                    .padding(.vertical)
//                    .padding(.horizontal, 50)
//                    .background(Color("Color3"))
//                    .clipShape(Capsule())
//                    .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
//            }
//            .offset(y: 25)
//
//            .opacity(self.index == 1 ? 1 : 0)
//        }
//     //    .offset(y: 50)
//    }
    
        
//}

var images : [UIImage]! = [
    UIImage(named: "image0")!,
    UIImage(named: "image1")!,
    UIImage(named: "image2")!,
    UIImage(named: "image3")!,
    UIImage(named: "image4")!,
    UIImage(named: "image5")!,
    UIImage(named: "image6")!,
    UIImage(named: "image7")!,
    UIImage(named: "image8")!,
    UIImage(named: "image9")!,
    UIImage(named: "image10")!,
    UIImage(named: "image11")!,
    UIImage(named: "image12")!,
    UIImage(named: "image13")!,
    UIImage(named: "image14")!

]

let animatedImages = UIImage.animatedImage(with: images, duration: 0.8)


struct animationSequence : UIViewRepresentable{
    
    
    func makeUIView(context: Context) -> UIView {
        
        let seqAnimview = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        let seqImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 190))
        seqImage.clipsToBounds = true
        seqImage.layer.cornerRadius = 20
        seqImage.autoresizesSubviews = true
        seqImage.contentMode = UIView.ContentMode.scaleAspectFit
        seqImage.image = animatedImages
        seqAnimview.addSubview(seqImage)
        return seqAnimview
        
        
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<animationSequence>) {
        
    }
        
}


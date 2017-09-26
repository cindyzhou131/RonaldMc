

import UIKit

class MainMenuView: UIView {
    
    var scrollView: UIScrollView! = UIScrollView()
    var headerImage: UIImageView! = UIImageView()
    var headerLabel: UILabel! = UILabel()
    
  
    
    var imageData: Data!
    var imageURL: URL!
    var image: UIImage?
    var scrollBottom: NSLayoutConstraint?
    var sectionView: BaseView = BaseView()
 /////given default titles and texts
    //var extensionInformation: [UIView?] = [nil, UILabel(), UILabel(), UILabel()]
    var sectionText = ["*information about RHMS","*information about family*", "Ann Arbor", ""]
   // var sectionText = ["I love to eat food, i like to eat all the foods", "Home is where the heart is, I am always home because I travel with my heart. My heart rests in my body. I am always home", "wahtever there is not much to say", "the conversation ender" ]
    var sectionLabels:[UILabel] = []
    var sectionTitles: [String] = ["Home", "Family", "Ann Arbor", "Map"]
    
   // var sectionTitles: [String] = ["Food", "Home", "Whatever", "Okay"]
    
    
    func setMainSections(_ titles:[String],_ text:[String]){
        sectionText = text
        sectionTitles = titles
        labelGenerator()
    }
    
    
    
    func labelGenerator(){
        
        for text in sectionText{
            let newLabel = UILabel()
            newLabel.numberOfLines = 0
            newLabel.text = text
            newLabel.backgroundColor = .orange
            newLabel.sizeToFit()
            sectionLabels.append(newLabel)
        }
        
        
    }
    func setUp(){
        headerLabel.text = "Here is an introduction to nothing. I am an app tester."

        let margin = self.layoutMarginsGuide
        let screenSize = UIScreen.main.bounds
        print(screenSize)
        
        labelGenerator()

        
        /**** picture not working ***/
        imageURL = URL(fileURLWithPath: "https://upload.wikimedia.org/wikipedia/commons/7/71/2010-kodiak-bear-1.jpg")
        imageData = try? Data(contentsOf: imageURL)
        if imageData != nil{
            image = UIImage(data: imageData)
            
        }
        headerImage.image = image
        
        
        /**** SCROLL VIEW ******/
        self.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(red: 1, green: 228/255, blue: 1, alpha: 1)
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: margin.topAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        // self.he
        scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        print(margin)
        
        
        /******** HEADER SET UP ***********/
        scrollView.addSubview(headerLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        ///headerImage
        if headerImage.image != nil{
            scrollView.addSubview(headerImage)
            headerImage.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            headerImage.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant: headerImage.frame.height).isActive = true
            headerImage.frame.size.width = screenSize.width
        }
        
        
        ///headerLabel
      //  headerLabel.text = headerInformation
        headerLabel.isHidden = false
        headerLabel.numberOfLines = 0
        headerLabel.frame.size.height = screenSize.height/6
        headerLabel.backgroundColor = UIColor(red: 224/255, green: 1, blue: 1, alpha: 1)
        
        headerLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        headerLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        headerLabel.centerXAnchor.constraint(equalTo:scrollView.centerXAnchor).isActive = true
        
        if headerImage.image != nil{
            headerLabel.topAnchor.constraint(equalTo: headerImage.topAnchor).isActive = true
            
        }else{
            headerLabel.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            
        }
        
        
        headerLabel.bottomAnchor.constraint(equalTo: headerLabel.topAnchor, constant: headerLabel.frame.height).isActive = true
        sectionView.setUp(sectionTitles, sectionLabels, screenSize)
        scrollView.addSubview(sectionView)
        
        sectionView.translatesAutoresizingMaskIntoConstraints = false
        sectionView.widthAnchor.constraint(equalTo: headerLabel.widthAnchor).isActive = true
        sectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: sectionView.bottomAnchor).isActive = true
        /******* END OF HEADER SET UP ************/
        
        
    }
    
}


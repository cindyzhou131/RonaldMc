//
//  MenuBar.swift
//  RHM_App
//
//  Created by Cindy Zhou on 8/15/17.
//  Copyright © 2017 Cindy Zhou. All rights reserved.
//

import UIKit


class MenuBar: NSObject {
    let whatview1 = UIView()
    let wherebutton1 = UIButton()
    let whybutton1 = UIButton()
    
    
    var donateButton = UIButton()
    
    var menu: SimpleBackgoundView?
    var menuTable: BaseView? = nil
    var blank = UIView()
    var menuTableFrame = UIView()
    let whatview = UIView()
    let wherebutton = UIButton()
    let whybutton = UIButton()
    lazy var buttonSectionPlace: ButtonSection = ButtonSection()

    var menuTitles: [String] = ["Home", "Places", "Maps"]
    var menuExtensions: [UIView?] { get{return [nil, buttonSectionPlace, nil]} set(v){}}
    
    func setMenuInformation(_ titles: [String], _ extensionView: [UIView]){
        if(titles.count == extensionView.count){
            menuTitles = titles
            menuExtensions = extensionView
        }else{
            print("Titles don't match extensionView")
        }

        
    }

    
    func showMenu(){
        
        if let window = UIApplication.shared.keyWindow{
            
            menu = SimpleBackgoundView(frame: window.frame)
            menu!.frame = window.frame
            
            // superView.addSubview(menu!)
            let screensize = UIScreen.main.bounds
           // menuTable.translatesAutoresizingMaskIntoConstraints = false
/******* vvvvv GOTTA FIX THE SHIT vvvvv ******/
            /** first it doesn't respond to touch****/
            /***** miniview ****/
            buttonSectionPlace.setUp(["nyc", "la", "paris"])
            buttonSectionPlace.frame = CGRect(x: screensize.minX, y: screensize.minY + 20 , width: menu!.frame.width / 1.3, height: 3 * buttonSectionPlace.sectionButtons[0].frame.height)
            //addMenuSectionButton()
//            buttonSectionPlace.frame = CGRect(x: 0, y: 0, width: screensize.width/3, height: whybutton.frame.height + wherebutton.frame.height)

            /////**** so you have to provide the frame size with the correct height or the section wont display the right size ***///

            window.addSubview(menu!)

            //THE VIEWS MUST NOT THE CONNECTED LIKE IT CAN'T BE
            // menuTable.setUp(["Home", "What", "Fam"],[whatview, whatview, whatview], screensize) //CAUSE TAHT MEANS TAHT THE THEY SHARING THE SAME OBJECT AND THAT FUCKS THIGNS UP
            if menuTable == nil{
                menuTable = BaseView()
                menuTable?.setUp(menuTitles,menuExtensions, screensize) //////this should be called once or itll throw error
            }
            
            //window.translatesAutoresizingMaskIntoConstraints = false
        /**** CONSTRAINTS *****/
            /*** menu Constraints ****/
            menu!.translatesAutoresizingMaskIntoConstraints = false
            menu!.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
            menu!.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
            menu!.widthAnchor.constraint(equalTo: window.widthAnchor).isActive = true

            /*** menuTableFrame Constraints ****/
            menuTableFrame.backgroundColor = UIColor(red: 1, green: 245/255, blue: 238/255, alpha: 0.7)
            
            menuTableFrame.translatesAutoresizingMaskIntoConstraints = false
            menu!.addSubview(menuTableFrame)

            menuTableFrame.topAnchor.constraint(equalTo: (menu?.topAnchor)!, constant: 20).isActive = true
             menuTableFrame.bottomAnchor.constraint(equalTo: (menu?.bottomAnchor)!).isActive = true
            menuTableFrame.widthAnchor.constraint(equalTo: (menu?.widthAnchor)!, multiplier: 1/1.3).isActive = true
            menuTableFrame.leadingAnchor.constraint(equalTo: (menu?.leadingAnchor)!).isActive = true
            
            menuTableFrame.addSubview(menuTable!)
            
            /*** menuTable Constraints ****/
            menuTable?.translatesAutoresizingMaskIntoConstraints = false
            menuTable?.topAnchor.constraint(equalTo: (menuTableFrame.topAnchor)).isActive = true
         
            menuTable?.widthAnchor.constraint(equalTo: (menuTableFrame.widthAnchor)).isActive = true
            menuTable?.leadingAnchor.constraint(equalTo: (menuTableFrame.leadingAnchor)).isActive = true
        /**** CONSTRAINTS END *****/
            
      
           // menuTable.bottomAnchor.constraint(equalTo: (window.bottomAnchor)).isActive = true // this will throw an error
           // menuTable.backgroundColor = UIColor(red: 1, green: 245/255, blue: 238/255, alpha: 0.7)
        
            
            //let tableWidth = menu.frame / 4.0
          //  menuTable.frame = CGRect(x: screensize.minX, y: screensize.minY + 20 , width: menu!.frame.width / 1.3, height: menu!.frame.height)
            
            //print(screensize)
            
          

            // blank.backgroundColor = UIColor.white
            // menu?.addSubview(blank)
            //blank.topAnchor.constraint(equalTo: menuTable.bottomAnchor).isActive = true
            let swipe = UISwipeGestureRecognizer(
                target: self, action: #selector (retractMenu))
            swipe.direction = UISwipeGestureRecognizerDirection.left
            self.menu!.addGestureRecognizer(swipe)
            ///////testing button touch
            
            wherebutton1.backgroundColor = .red
            whybutton1.backgroundColor = .purple
            
            wherebutton1.setTitle("what", for: .normal)
            whybutton1.setTitle("Info", for: .normal)
            
            whatview1.translatesAutoresizingMaskIntoConstraints = false
            wherebutton1.translatesAutoresizingMaskIntoConstraints = false
            whybutton1.translatesAutoresizingMaskIntoConstraints = false
            
           // whatview1.isUserInteractionEnabled = false
            whatview1.addSubview(whybutton1)
            whatview1.addSubview(wherebutton1)
           // whybutton1.addTarget(self, action: #selector(self.printTitle(_:)), for: .touchUpInside)
           // wherebutton1.addTarget(wherebutton1, action: #selector(self.printTitle(_:)), for: .touchUpInside)
            whybutton1.widthAnchor.constraint(equalTo: whatview1.widthAnchor).isActive = true
            whybutton1.heightAnchor.constraint(equalTo: whatview1.heightAnchor, constant: 0.5).isActive = true
            whybutton1.topAnchor.constraint(equalTo: whatview1.topAnchor).isActive = true
            whybutton1.bottomAnchor.constraint(equalTo: whybutton1.topAnchor, constant: 100).isActive = true
            whybutton1.leadingAnchor.constraint(equalTo: whatview1.leadingAnchor).isActive = true
            wherebutton1.topAnchor.constraint(equalTo: whybutton1.bottomAnchor).isActive = true
            wherebutton1.bottomAnchor.constraint(equalTo: wherebutton1.topAnchor, constant: 100).isActive = true
            wherebutton1.widthAnchor.constraint(equalTo: whatview1.widthAnchor).isActive = true
            wherebutton1.heightAnchor.constraint(equalTo: whatview1.heightAnchor, constant: 0.5).isActive = true

            wherebutton1.leadingAnchor.constraint(equalTo: whatview1.leadingAnchor).isActive = true

            
//            wherebutton1.frame.size.width = 300
//            wherebutton1.frame.size.height = 300
//            whybutton1.frame.size.height = 300
//            whybutton1.frame.size.width = 300
            
          //  whatview1.frame = CGRect(x: 0, y: 0, width: screensize.width, height: screensize.height)
            
            
//            wherebutton1.isUserInteractionEnabled = true
//            whybutton1.isUserInteractionEnabled = true
//            //window.isUserInteractionEnabled = false
            whatview1.clipsToBounds = true

         //   window.addSubview(whatview1)
            
//            whatview1.leadingAnchor.constraint(equalTo: window.leadingAnchor).isActive = true
//            whatview1.widthAnchor.constraint(equalTo: window.widthAnchor).isActive = true
//            print(window.clipsToBounds)
//
            ///////testing ends
            donateButton.translatesAutoresizingMaskIntoConstraints = false
            donateButton.backgroundColor = .red
            donateButton.setTitle("DONATE YOUR MONEY", for: .normal)
            window.addSubview(donateButton)

            donateButton.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -20).isActive = true
            donateButton.rightAnchor.constraint(equalTo: window.rightAnchor).isActive = true
            

        }
        
        
    }
  
    
    
    func retractMenu(){
        print("sliped")
        UIView.animate(withDuration: 0.5, animations: {
            /// print("it reco")
            //            self.menu.frame.size.height -= 10
            //            self.menu.frame.size.height -= 10
            self.menu!.backgroundColor = UIColor(white: 1, alpha: 1)
            self.menu!.removeFromSuperview()
            //   self.menu.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            //   self.menuTable.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        })
        
    }

//    func addMenuSectionButton(){
//        whybutton.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 1, alpha: 0.7)
//        //**** THis is the correct way to set the button title *** or else shit don't appear and its annoying as fuck****/
//        wherebutton.setTitle("where", for: .normal)
//        whybutton.setTitle("why", for: .normal)
//        
//        whatview.translatesAutoresizingMaskIntoConstraints = false
//        wherebutton.translatesAutoresizingMaskIntoConstraints = false
//        whybutton.translatesAutoresizingMaskIntoConstraints = false
//        
//       // whybutton.addTarget(self, action: #selector(self.printTitle(_:)), for: .touchUpInside)
//        //wherebutton.addTarget(self, action: #selector(self.printTitle(_:)), for: .touchUpInside)
//        
//        whatview.addSubview(whybutton)
//        whatview.addSubview(wherebutton)
//        //////must be extensive with the constaints cause if the clipstobounds don't work then teh button can't be touched
//        
//        whybutton.leftAnchor.constraint(equalTo: whatview.leftAnchor, constant: 20).isActive = true
//        whybutton.topAnchor.constraint(equalTo: whatview.topAnchor).isActive = true
//        whybutton.bottomAnchor.constraint(equalTo: wherebutton.topAnchor).isActive = true
//        whybutton.rightAnchor.constraint(equalTo: whatview.rightAnchor).isActive = true
//        
//        wherebutton.leftAnchor.constraint(equalTo: whatview.leftAnchor, constant: 20).isActive = true
//        wherebutton.topAnchor.constraint(equalTo: whybutton.bottomAnchor).isActive = true
//        wherebutton.bottomAnchor.constraint(equalTo: whatview.bottomAnchor).isActive = true
//        wherebutton.rightAnchor.constraint(equalTo: whatview.rightAnchor).isActive = true
//        //wherebutton.heightAnchor.constraint(equalTo: whybutton.heightAnchor).isActive = true
//        
//        // whatview.bottomAnchor.constraint(equalTo: wherebutton.bottomAnchor).isActive = true
//        whatview.clipsToBounds = true ////this makes it so taht if the button isn't inside the right constraint it wont show up so it will indicate to you if you can touch the button
//        
//        /////must set hieght value or the shit will give you zero and the other thing wont know what to do
//        wherebutton.sizeToFit()
//        whybutton.sizeToFit()
//        
//        
//
//    }
    
    
    
    
    
}




class ButtonSection: UIView{
    var sectionButtons: [UIButton] = []
    var delegate: MainMenuViewController?
    
    func setUp(_ buttonTitles:[String]){
        for title in buttonTitles{
            let newbutton = UIButton()
            newbutton.setTitle(title, for: .normal)
            newbutton.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 1, alpha: 0.7)
            newbutton.translatesAutoresizingMaskIntoConstraints = false
            sectionButtons.append(newbutton)
            self.addSubview(newbutton)
        }
        for i in 0 ... sectionButtons.count - 1{
            let button = sectionButtons[i]
            button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
            button.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

            if i == 0{
                button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            }else{
                button.topAnchor.constraint(equalTo: sectionButtons[i - 1].bottomAnchor).isActive = true
            }
            if i == sectionButtons.count - 1{
                button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            }else{
                 button.bottomAnchor.constraint(equalTo: sectionButtons[i + 1].topAnchor).isActive = true
            }
            button.sizeToFit()
        }
       // self.frame.size =
        self.clipsToBounds = true
    }
    
    
    func addHandler( ){//_ handler: Selector
        for button in sectionButtons{
            button.addTarget(self, action: #selector(delegate?.printer), for: .touchUpInside)
        }
    }
 
    
    
    
}

class SimpleBackgoundView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(super.frame)
        self.backgroundColor = UIColor(white: 0, alpha: 0.2)
        
        self.translatesAutoresizingMaskIntoConstraints = false

    }
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        //super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        if rect.width != 0 {
            let boarder = CGRect(origin: CGPoint(x:0,y:0) , size: CGSize(width: rect.width, height: 20))
            
            // print(boarder)
            UIColor.white.set()
            //        context?.addRect(rect)
            //        context?.fill(rect)
            //UIColor.gray.set()
            context?.fill(boarder)
            context?.stroke(boarder)
        }
        //  print(self.gestureRecognizers)
        
    }
    
    
    
}





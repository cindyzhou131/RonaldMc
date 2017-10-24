//
//  BaseViewController.swift
//  RHM_App
//
//  Created by Cindy Zhou on 7/21/17.
//  Copyright © 2017 Cindy Zhou. All rights reserved.
//

////////things still left to do
//////clean up code and make it easier to mamke those stupid section views
/////see how to integrate a picture or just give up, u done enough


/// make menu dynamic & main menu customizable for user
///each cell can b entered and reuse view for menu
import UIKit

class MainMenuViewController: UIViewController, UINavigationBarDelegate {
    
    var inView: MainMenuView! = MainMenuView()
    var familyView = UIView()
    var otherview = UIView()
        var menuSection = ["somthing", "somethingelse"]
    //var currentview: UIView?
    
    var nextPage: String?{
        didSet{
            if nextPage! == "Home"{
                view = inView
            }else if nextPage! == "Fam"{
                view = familyView
            }else{
                view = otherview
            }
            
        }
    }
    
    
    func familyViewSetup(){
        familyView.frame = view.frame
        familyView.backgroundColor = .red
        let familyLabel = UILabel()
        familyLabel.translatesAutoresizingMaskIntoConstraints = false
        familyLabel.text = "FAMILY SECTION"
        familyLabel.numberOfLines = 0
        familyLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 30)
        familyView.addSubview(familyLabel)
    
        familyLabel.topAnchor.constraint(equalTo: familyView.topAnchor).isActive = true
        familyLabel.bottomAnchor.constraint(equalTo: familyView.bottomAnchor).isActive = true
        
    }
    
    func goDonate(){
        UIApplication.shared.openURL(NSURL(string: "https://rmhcannarbor.org/donate/")! as URL)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //print(theView)
        
        //if inView as? theRealMenuHopefully {
        inView.setUp()
        menu.create()
        menu.menuTable!.delegate = self
        menu.buttonSectionPlace.delegate = self

        view = (inView)
      //  menu.whybutton.addTarget(self, action: #selector(printer), for: .touchUpInside)
      //  menu.wherebutton.addTarget(self, action: #selector(printer), for: .touchUpInside)
        menu.donateButton.addTarget(self, action: #selector(goDonate), for: .touchUpInside)
        
        
        menu.buttonSectionPlace.addHandler()

    }
    //////MINI SECTION NEW PAGE OPENER
    func printer(_ sender: UIButton)-> String{
        print("something is touched")
        
        if(sender.titleLabel?.text! == "why"){
            familyViewSetup()
            view = familyView
        }else{
            otherview.backgroundColor = .purple
            view = otherview
        }
        
        
        
        
        
        return (sender.titleLabel?.text)!
    }

    @IBAction func onk(_ sender: UIButton) {
        menu.showMenu()
        print("Menu12")
    }
    
    @IBOutlet weak var navaas: UINavigationItem!
    
    
    var currentView:MainMenuViewController?
    var menuStuff: [(String, [String])] = [("Home",[]),
                                           ("Family Stories", ["blan", "balsd"]),
                                           ("Nearby", ["blan", "balsd"]),
                                           ("Policies", ["sdf"]),
                                           ("Hospital Resources", [])]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var menu: MenuBar = MenuBar()
    
 
    var label: UILabel! = UILabel()
    
    


    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
       //TRY TO MAKE THIS SOME WHAT INCLUDED IN THE MENU ITSELF FOR THE SEGUE INSTEAD OF ALL THIS BECAUSE IT SEEMS LIKE A LOT OF COPYING
    
}


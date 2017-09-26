//
//  BaseView.swift
//  RHM_App
//
//  Created by Cindy Zhou on 8/15/17.
//  Copyright © 2017 Cindy Zhou. All rights reserved.
//

import UIKit

class BaseView: UIView {

    var buttonTitle: [String] = []
    var categories:[SectionInformation] = []
    var delegate: MainMenuViewController? 
    
 

    func setUp(_ buttonTitle: [String], _ extensionInformation: [UIView?], _ screenSize: CGRect){
        if buttonTitle.count != extensionInformation.count{
            print("Buttons don't match with information")
            return
        }
       // self.isUserInteractionEnabled = true

        
        for i in 0...buttonTitle.count - 1{
            /***** INITIALIZING BUTTON INFORMATION ******/
            let title: String = buttonTitle[i]
            let sectionExtension: UIView? = extensionInformation[i]
            
            categories.append(SectionInformation(title, sectionExtension))
            
            let groupInfo = categories[i]
            
            self.addSubview(groupInfo.view)
            
            
            groupInfo.button.tag = i
            
            groupInfo.view.frame.size.height = screenSize.height/6
            
            groupInfo.view.centerXAnchor.constraint(equalTo:self.centerXAnchor).isActive = true
            
            
            groupInfo.view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
            
            
            categories[i].sectionHeight = groupInfo.view.frame.height
            
            
            /******* BUTTON POSITIONING SET UP *******/
            if i == 0{
                

                let topAnc = groupInfo.view.topAnchor.constraint(equalTo: self.topAnchor)
                let bottomAnc = groupInfo.view.bottomAnchor.constraint(equalTo: self.topAnchor, constant: groupInfo.view.frame.size.height)
                
                groupInfo.bottomAnc = bottomAnc
                
                groupInfo.addConstraint(topAnc, bottomAnc)
                
                
            }else{
                let topAnc = groupInfo.view.topAnchor.constraint(equalTo: categories[i-1].view.bottomAnchor)
                let bottomAnc = groupInfo.view.bottomAnchor.constraint(equalTo: groupInfo.view.topAnchor, constant: groupInfo.view.frame.size.height)
                
                groupInfo.bottomAnc = bottomAnc
                groupInfo.addConstraint(topAnc, bottomAnc)
                
            }
            
            groupInfo.positionButton()
            groupInfo.button.addTarget(self, action:#selector(handleRegister(_:)), for: .touchUpInside)
            
            
        }
        
        if buttonTitle.count == 0{
            self.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }else{
            self.bottomAnchor.constraint(equalTo: categories[buttonTitle.count - 1].view.bottomAnchor).isActive = true
        }
        
        
        
        /****** END OF SETUP FUNCTION********/
    }
    
    
    
    /***** HANDLING BUTTON PUSHING with reoganizting the view ******/
    func handleRegister(_ sender: UIButton) -> String?{
        
        
        let selectedCategory = categories[sender.tag]
        // NSLayoutConstraint.deactivate([scrollBottom!])
        if(selectedCategory.canExtend){
            selectedCategory.showExtension = !selectedCategory.showExtension
            
            if sender.tag != categories.count - 1{
                for i in sender.tag+1...categories.count - 1{
                    categories[i].removeConstraint()
                    
                    let topAnc = categories[i].view.topAnchor.constraint(equalTo: categories[i-1].view.bottomAnchor)
                    let bottomAnc = categories[i].view.bottomAnchor.constraint(equalTo: categories[i].view.topAnchor, constant: categories[i].view.frame.height)
                    
                    categories[i].addConstraint(topAnc, bottomAnc)
                }
                
            }
            return nil
        }
        else{
            print(sender.titleLabel?.text ?? "defal")
            delegate?.nextPage = sender.titleLabel?.text
            return sender.titleLabel?.text
        }
    }
    
    
    
    

        /****** END OF PUSHING BUTTON ******/
        
        
        
}

class SectionInformation: NSObject{
    
    var sectionHeight: CGFloat = CGFloat()
    var canExtend: Bool = false;
    var button: UIButton = UIButton()
    var view: UIView = UIView()
    var bottomAnc: NSLayoutConstraint?
    var topAnc: NSLayoutConstraint?
    
    
    
    private var extensionView: UIView = UIView()
    
    
    private var frameConstraints: [NSLayoutConstraint] = []
    
    private var labelConstraints: [NSLayoutConstraint] = []
    private var buttonConstraints: [NSLayoutConstraint] = []
    
    
    var bsuttonName:String?
    var showExtension: Bool = false{
        didSet{
            //extensionView.isUserInteractionEnabled = false

            if(canExtend){

                NSLayoutConstraint.deactivate([bottomAnc!])
                
                if showExtension{
                  //  view.addSubview(extensionView)
                    sectionHeight += exensionframe!.height
                   // var extensionhiehgt = extensionView.frame.height
                    view.frame.size.height = sectionHeight
                    
                    extensionView.isHidden = false
                    
                    bottomAnc = view.bottomAnchor.constraint(equalTo: view.topAnchor, constant: sectionHeight)
                    
                    let viewTop = extensionView.topAnchor.constraint(equalTo: button.bottomAnchor)
                    let viewBottom = extensionView.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: extensionView.frame.height)
                    
                    
                    labelConstraints += [viewTop, viewBottom]
                    
                    NSLayoutConstraint.activate(labelConstraints)
                    
                }else{
                    extensionView.isHidden = true
                    
                    sectionHeight -= exensionframe!.height
                    view.frame.size.height = sectionHeight
                    
                    NSLayoutConstraint.deactivate(labelConstraints)
                    labelConstraints = []
                    
                    bottomAnc = view.bottomAnchor.constraint(equalTo: view.topAnchor, constant: sectionHeight)
                    
                    
                }
                NSLayoutConstraint.activate([bottomAnc!])
                
            }
            
        }
    }
    
    
    
    /**** INTIALIZATIONS *****/
    override init(){
        button.titleLabel?.text = "no title"
        extensionView = UIView()
    }
    var exensionframe: CGRect?
    ///how do we get information of the view to transition into
    ///shoudl we just have it return the title and then let the other part deal with it
    init(_ buttonName: String, _ inExtensionView: UIView?){
        button.setTitle(buttonName, for: UIControlState.normal)
        bsuttonName = buttonName
        button.backgroundColor = UIColor(red:1, green:192/255, blue:203/255, alpha: 1)
        if((inExtensionView) != nil){
            extensionView = inExtensionView!
            canExtend = true
            extensionView.frame = inExtensionView!.frame
            exensionframe = inExtensionView!.frame
            extensionView.translatesAutoresizingMaskIntoConstraints = false
            extensionView.isHidden = true
            view.addSubview(extensionView)
            
            
        }
        
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints  = false
        
        view.addSubview(button)
        
        
        //  print(labelHeight)
        
    }
    
    /**** END OF INITALIZATIONS *****/
    
    
    
    
    
    
    
    /****** CONSTRAINT FUNCTIONS *****/
    func removeConstraint(){
        //  print(button.constraints)
        //  NSLayoutConstraint.deactivate(button.constraints)
       // if(NSLayoutConstraint.self != nil){
            NSLayoutConstraint.deactivate([topAnc!, bottomAnc!])

      //  }
        
        //frameConstraints = []
    }
    
    
    func positionButton(){
        button.frame = view.frame
        sectionHeight = button.frame.height
        
        button.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if(canExtend){
            extensionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            extensionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            
            
        }
        
        let buttonTop = button.topAnchor.constraint(equalTo: view.topAnchor)
        let buttonBottom = button.bottomAnchor.constraint(equalTo: view.topAnchor, constant: button.frame.height)
        
        NSLayoutConstraint.activate([buttonTop, buttonBottom])
        
    }
    
    
    func addConstraint(_ topConstraint: NSLayoutConstraint,_ bottomConstraint: NSLayoutConstraint ){
        topAnc = topConstraint
        bottomAnc = bottomConstraint
        NSLayoutConstraint.activate([topAnc!, bottomAnc!])
        // positionButton()
    }
    /***** END OF CONSTRAINT FUNCTIONS *****/
    
}



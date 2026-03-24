//
//  IntroductionViewController.swift
//  Donation
//
//  Created by Kanhu Dash on 06/10/21.
//

import UIKit

struct Page {
    var backGroundImage: UIImage
    var title : String
    var description: String
    var logo: UIImage
}

class IntroductionViewController: UIViewController {
    
    @IBOutlet weak var collectionView_Introductionpage:UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let pages:[Page] = [Page(backGroundImage: UIImage(named: "asset-146")!,title:IntroductionTitle.first_Page.rawValue, description: IntroductionDescription.first_Page.rawValue, logo: UIImage(named: "IRRLogo")!),Page(backGroundImage: UIImage(named: "asset-149")!,title:IntroductionTitle.scond_Page.rawValue, description: IntroductionDescription.scond_Page.rawValue, logo: UIImage(named: "IRRLogo")!),Page(backGroundImage: UIImage(named: "Introduction")!,title:IntroductionTitle.third_Page.rawValue, description: IntroductionDescription.third_Page.rawValue, logo: UIImage(named: "IRRLogo")!),]
    var timer: Timer?
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageControl.numberOfPages = self.pages.count
        self.collectionView_Introductionpage.register(UINib(nibName: "IntroductionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "IntroductionCollectionViewCell")
        self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
    }
    @objc func changeImage() {
        if currentIndex <= pages.count - 1 {
            currentIndex = currentIndex + 1
        } else {
            currentIndex = 0
        }
        pageControl.currentPage = currentIndex
        collectionView_Introductionpage.scrollToItem(at: IndexPath(item: pageControl.currentPage, section: 0),
                                           at: .right, animated: true)
        
    }
    @IBAction func pageController_Clicked(_ sender: UIPageControl) {
        let pc = sender
        collectionView_Introductionpage.scrollToItem(at: IndexPath(item: pc.currentPage, section: 0),
                                           at: .centeredHorizontally, animated: true)
    }
    @IBAction func btn_GetStarted(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension IntroductionViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return pages.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntroductionCollectionViewCell",
                                                          for: indexPath) as! IntroductionCollectionViewCell
            cell.img_Logo.image = pages[indexPath.row].logo
            cell.img_BackGround_Image.image = pages[indexPath.row].backGroundImage
            cell.lbl_Title.text = pages[indexPath.row].title
            cell.txt_Description.text = pages[indexPath.row].description
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: self.collectionView_Introductionpage.frame.size.width, height: self.collectionView_Introductionpage.frame.size.height)
        }
        
        // to update the UIPageControl
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        }
    }

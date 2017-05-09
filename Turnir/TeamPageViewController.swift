//
//  TeamPageViewController.swift
//  Turnir
//
//  Created by Adam Gorkoz on 07/05/2017.
//  Copyright © 2017 Adam Gorkoz. All rights reserved.
//

import UIKit

class TeamPageViewController: UIPageViewController {
    
    var currentTeam: LeagueTeamModel!
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        let teamStatsViewController = self.storyboard!.instantiateViewController(withIdentifier:"TeamStatsViewController")
            as! TeamStatsViewController
        teamStatsViewController.currentTeam = self.currentTeam
        
        let teamPlayersTableViewController = self.storyboard!.instantiateViewController(withIdentifier: "TeamPlayersViewController") as! TeamPlayersTableViewController
        teamPlayersTableViewController.currentTeamId = self.currentTeam.id
        
        return [teamStatsViewController,teamPlayersTableViewController]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
            self.navigationItem.title = firstViewController.title
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



extension TeamPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}
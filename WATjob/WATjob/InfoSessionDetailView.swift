//
//  InfoSessionDetaiViewswift
//  WATjob
//
//  Created by Daniel Kim on 2015-06-07.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import Foundation
import UIKit

class InfoSessionDetailView: UIView {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//
//  CalendarTableVC.swift
//  JudoCanadaMobileAppiOS
//
//  Created by Louis-Simon Poulin on 2018-06-06.
//  Copyright © 2018 Louis-Simon Poulin. All rights reserved.
//

import UIKit

class CalendarTableVC: UITableViewController {

    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var datePicker: MonthYearPickerView!
    var events = [Event]()
    var diplayEvent = [Event]()
    var time:Float = 0.0
    var timer:Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        getEventList()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo.png")
        imageView.image = image
        navigationItem.titleView = imageView
        
        let expiryDatePicker = datePicker as MonthYearPickerView
        expiryDatePicker.onDateSelected = onDateSelected
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func onDateSelected(month:Int, year:Int){
        diplayEvent = getEvents(month, year)
        self.tableView.reloadData()
    }
    
    func getEvents(_ month:Int, _ year:Int) ->[Event]{
        var displayEvent = [Event]()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let startDate = formatter.date(from: "\(year)/\(month>=10 ? "" : "0")\(month)/01")
        let endDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate!)
        
        for event in events{
            if (event.dateStart?.compare(startDate!)==ComparisonResult.orderedDescending && event.dateStart?.compare(endDate!)==ComparisonResult.orderedAscending){
                displayEvent.append(event)
            }
        }
        
        //sort events here
        displayEvent = displayEvent.sorted(by:{
            $0.dateStart?.compare($1.dateStart!)==ComparisonResult.orderedAscending
        })
        return displayEvent
    }
    
    func getEventList() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.setProgress), userInfo: nil, repeats: true)
        let apiHelper:ApiHelper = ApiHelper()
        apiHelper.getEvents(completion: display)
    }
    
    @objc func setProgress() {
        time += 0.01
        self.progressBar.progress = time.truncatingRemainder(dividingBy: 1.0)
    }
    
    func display(myList:Any?)->(){
        guard let events:[Event] = myList as? [Event] else{
            print("No Event array")
            return
        }
        self.events = events
        onDateSelected(month: Date().getMonthNumber(), year: Date().getYearNumber())
        self.timer?.invalidate()
        self.progressBar.isHidden = true
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return diplayEvent.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CalendarTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EventIdentifier", for: indexPath) as! CalendarTableViewCell
        
        cell.title.text = diplayEvent[indexPath.row].summary
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM"
        
        cell.date.text = dateFormatterPrint.string(from: diplayEvent[indexPath.row].dateStart!) + " - " + dateFormatterPrint.string(from: diplayEvent[indexPath.row].dateEnd!)
    

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let url = diplayEvent[indexPath.row].url
        UIApplication.shared.openURL(NSURL(string: url!)! as URL)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
extension Date {
    
    func getMonthNumber() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let strMonth = dateFormatter.string(from: self)
        return Int(strMonth)!
    }
    
    func getYearNumber() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let strYear = dateFormatter.string(from: self)
        return Int(strYear)!
    }
    
    
}

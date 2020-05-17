
import UIKit

class ScheduleViewCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifier       = "ScheduleViewCell"
    private var model           : ScheduleModel?
    private let days            = [1:6,2:0,3:1,4:2,5:3,6:4,7:5]
    
    private lazy var weekLbl: PaddingLabel = {
        let label = PaddingLabel(withInsets: 8.width, 8.width, 5.width, 5.width)
        label.text = "ПН"
        label.font = Global.boldFont(size: 14.width)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.3670537243)
        return label
    }()
    
    private lazy var timeLbl: UILabel = {
        let label = UILabel()
        label.text = "08:00 - 21: 00"
        label.font = Global.regularFont(size: 14.width)
        label.textColor = .black
        return label
    }()
    
    private lazy var scheduleLbl: UILabel = {
        let label = UILabel()
        label.text = "Расписание"
        label.font = Global.regularFont(size: 12.width)
        label.textColor = .black
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ScheduleViewCell {
    
    //MARK: - Configure
    func configure(model: FirmDetailModel?,index: Int) {
        guard let model = model else { return }
        let dayIndex = (Date().dayNumberOfWeek() ?? 1)
        var schedule:(String,String) = ("","")
        if model.schedule.showAll == true {
            schedule = self.shedule(model: model, index: index)
            self.colorOfweek(isCurrentDay: index == self.days[dayIndex])
        } else {
            schedule = self.shedule(model: model, index: self.days[dayIndex] ?? 0)
            self.colorOfweek(isCurrentDay: true)
        }
        self.weekLbl.text = schedule.0
        self.timeLbl.text = schedule.1
        self.hideAcceessoryViews(hide: index != 0,showAll: model.schedule.showAll)
    }
    
    //MARK: - Helpers
    private func shedule(model: FirmDetailModel,index: Int) -> (String,String) {
        let startTime = model.firm.workStartTime.stringToDate(from: "dd-MM-yyyy HH:mm", to: "HH:mm")
        let endTime = model.firm.workEndTime.stringToDate(from: "dd-MM-yyyy HH:mm", to: " - HH:mm")
        let time = startTime + endTime
        return (model.schedule.days[index],time)
    }
    
    private func colorOfweek(isCurrentDay: Bool) {
        if isCurrentDay == true {
            self.weekLbl.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            self.weekLbl.textColor = .white
        } else {
            self.weekLbl.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.3670537243)
            self.weekLbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
    }
    
    private func hideAcceessoryViews(hide: Bool,showAll: Bool) {
        self.accessoryView = !hide ? UIImageView(image: UIImage(named: showAll ? "up" : "down")) : nil
        self.scheduleLbl.isHidden = hide
    }
    
    //MARK: - Set up
    private func setUpViews() {
        self.backgroundColor = .white
        self.selectionStyle = .none
        self.accessoryView = UIImageView(image: UIImage(named: "down"))
        self.addSubviews([weekLbl,timeLbl,scheduleLbl])
        weekLbl.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16.width)
            make.top.equalToSuperview().offset(8.width)
            make.bottom.equalToSuperview().offset(-8.width)
        }
        timeLbl.snp.makeConstraints { (make) in
            make.left.equalTo(weekLbl.snp.right).offset(16.width)
            make.centerY.equalTo(weekLbl)
        }
        scheduleLbl.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-36.width)
            make.centerY.equalTo(weekLbl)
        }
    }

}

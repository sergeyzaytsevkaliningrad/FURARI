import UIKit

final class WelcomeViewController: BaseViewController {
    
    var presenter = WelcomePresenter()
    
    let mainImageView = UIImageView(image: UIImage(named: "za_label"))
    let chooseCountry = ChooseCountryButton()
    let letsGoButton = LetsGoButton()
    let taxFreeInfo = UnderlineButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Главная"
        
        self.presenter.viewController = self
        
        let subviews = [self.mainImageView, self.letsGoButton, self.chooseCountry, self.taxFreeInfo]
        
        // setup elements
        self.letsGoButton.text = "За работу!"
        self.letsGoButton.addTarget(self.presenter, action: #selector(self.presenter.openTabBarController), for: .touchUpInside)
        
        self.chooseCountry.countryFlag.text = "?"
        self.chooseCountry.countryTitle.text = "Выберите робота"
        self.chooseCountry.addTarget(self.presenter, action: #selector(self.presenter.openCountryPickleView), for: .touchUpInside)
        
        self.taxFreeInfo.setTitle("Что такое UR роботы?", for: .normal)
        self.taxFreeInfo.addTarget(self.presenter, action: #selector(self.presenter.openTaxFreeInformation), for: .touchUpInside)
        
        // enable constraints
        subviews.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        
        // add subview
        subviews.forEach({ self.view.addSubview($0) })
        
        self.setupConstraints()
        let _ = CourseLoader.shared.courses
        let _ = LocationManageR.shared.country
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupConstraints() {
        self.mainImageView.centerX()
        self.mainImageView.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
                
        self.chooseCountry.centerX()
        self.chooseCountry.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 100).isActive = true
        
        self.letsGoButton.centerX()
        self.letsGoButton.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 180).isActive = true
        
        self.taxFreeInfo.centerX()
        self.taxFreeInfo.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 260).isActive = true
    }
    
    func showChooseCountryAlert() {
        let alert = UIAlertController(title: "Выберите робота", message: nil, preferredStyle: .alert)
        alert.isModalInPopover = true
        
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(self.presenter.currentCountryIndex ?? -1, inComponent: 0, animated: false)
        
        alert.view.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.widthAnchor.constraint(equalToConstant: 270).isActive = true
        pickerView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 60).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -44).isActive = true
        
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Выбрать", style: .default, handler: { (action: UIAlertAction) in
            self.presenter.currentCountryIndex = pickerView.selectedRow(inComponent: 0)
        }))
        
        self.present(alert, animated: true)
    }
    
}


extension WelcomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.presenter.counties.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let country = self.presenter.counties[row].entity!
        return "\(country.flag!) \(country.name!)"
    }
    
}

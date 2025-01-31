import UIKit

class ViewController: UIViewController, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let pickerData = [
        "Helvetica Neue",    // Regular: "HelveticaNeue", Bold: "HelveticaNeue-Bold"
        "Avenir Next",       // Regular: "AvenirNext-Regular", Bold: "AvenirNext-Bold"
        "Georgia",           // Regular: "Georgia", Bold: "Georgia-Bold"
        "Courier New",       // Regular: "CourierNewPSMT", Bold: "CourierNewPS-BoldMT"
        "Palatino"           // Regular: "Palatino-Roman", Bold: "Palatino-Bold"
    ]
    
    private let menuView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    private let fontSizeSlider : UISlider = {
        let slider = UISlider()
        slider.minimumValue = 10
        slider.maximumValue = 50
        return slider
    }()
    
    private var fontWeightSegment : UISegmentedControl = {
        let segment = UISegmentedControl(items: ["a", "A"])
        return segment
    }()
    
    private let redColorButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.backgroundColor = .red
        return button
    }()
    
    private let blackColorButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.backgroundColor = .black
        return button
    }()
    
    private let chooseFontPicker : UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private let darkThemeLabel : UILabel = {
        let label = UILabel()
        label.text = "Dark mode"
        return label
    }()
    
    private let darkThemeSwitch : UISwitch = {
        let themeSwitch = UISwitch()
        themeSwitch.isOn = false
        return themeSwitch
    }()
    
    private let textView : UITextView = {
        let tv = UITextView()
        tv.text = "Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt, explicabo. Nemo enim ipsam voluptatem, quia voluptas sit, aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos, qui ratione voluptatem sequi nesciunt, neque porro quisquam est, qui dolorem ipsum, quia dolor sit, amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit, qui in ea voluptate velit esse, quam nihil molestiae consequatur, vel illum, qui dolorem eum fugiat, quo voluptas nulla pariatur? At vero eos et accusamus et iusto odio dignissimos ducimus, qui blanditiis praesentium voluptatum deleniti atque corrupti, quos dolores et quas molestias excepturi sint, obcaecati cupiditate non provident, similique sunt in culpa, qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio, cumque nihil impedit, quo minus id, quod maxime placeat, facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat."
        return tv
    }()
    
    override func viewDidLoad() {
        textView.delegate = self
        chooseFontPicker.dataSource = self
        chooseFontPicker.delegate = self
        super.viewDidLoad()
        setupLayouts()
        setupActions()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        
        
    }
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: view)
        if !textView.frame.contains(tapLocation) && !menuView.frame.contains(tapLocation) {
            menuView.alpha = 0
            menuView.isHidden = true
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let fontName = pickerData[row]
        textView.font = UIFont(name: fontName, size: textView.font?.pointSize ?? 17)
    }
    
    private func setupActions() {
        fontSizeSlider.addTarget(self, action: #selector(changeSize), for: .valueChanged)
        fontWeightSegment.addTarget(self, action: #selector(changeWeight), for: .valueChanged)
        redColorButton.addTarget(self, action: #selector(changeRed), for: .touchUpInside)
        blackColorButton.addTarget(self, action: #selector(changeBlack), for: .touchUpInside)
    }
    
    @objc private func changeRed() {
        textView.textColor = .red
    }
    
    @objc private func changeBlack() {
        textView.textColor = .black
    }
    
    @objc private func changeWeight() {
        guard let currentFont = textView.font else { return }
        let isBold = fontWeightSegment.selectedSegmentIndex == 1

        // Получаем базовое имя шрифта (без модификаторов)
        let baseFontName = currentFont.fontName.components(separatedBy: "-").first ?? ""

        // Сопоставляем с нашими шрифтами
        let newFontName: String
        switch baseFontName {
        case "HelveticaNeue":
            newFontName = isBold ? "HelveticaNeue-Bold" : "HelveticaNeue"
        case "AvenirNext":
            newFontName = isBold ? "AvenirNext-Bold" : "AvenirNext-Regular"
        case "Georgia":
            newFontName = isBold ? "Georgia-Bold" : "Georgia"
        case "CourierNewPSMT":
            newFontName = isBold ? "CourierNewPS-BoldMT" : "CourierNewPSMT"
        case "Palatino":
            newFontName = isBold ? "Palatino-Bold" : "Palatino-Roman"
        default:
            newFontName = currentFont.fontName
        }

        textView.font = UIFont(name: newFontName, size: currentFont.pointSize)
    }
    
    @objc private func changeSize(target: UISlider) {
        let newSize = CGFloat(target.value)
        textView.font = textView.font?.withSize(newSize)
    }
    
    private func setupLayouts() {
        [textView, menuView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            textView.heightAnchor.constraint(equalToConstant: 400),
            
            menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            menuView.heightAnchor.constraint(equalToConstant: 300),
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        [fontSizeSlider, fontWeightSegment, redColorButton, blackColorButton, chooseFontPicker, darkThemeLabel, darkThemeSwitch].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            menuView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            fontSizeSlider.topAnchor.constraint(equalTo: menuView.topAnchor, constant: 10),
            fontSizeSlider.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: 10),
            fontSizeSlider.trailingAnchor.constraint(equalTo: menuView.trailingAnchor, constant: -10),
            //fontSizeSlider.heightAnchor.constraint(equalToConstant: 20),
            
            fontWeightSegment.topAnchor.constraint(equalTo: fontSizeSlider.bottomAnchor, constant: 20),
            fontWeightSegment.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: 10),
            fontWeightSegment.trailingAnchor.constraint(equalTo: menuView.trailingAnchor, constant: -10),
            fontWeightSegment.heightAnchor.constraint(equalToConstant: 50),
            
            redColorButton.topAnchor.constraint(equalTo: fontWeightSegment.bottomAnchor, constant: 20),
            redColorButton.trailingAnchor.constraint(equalTo: menuView.centerXAnchor, constant: -50),
            redColorButton.heightAnchor.constraint(equalToConstant: 50),
            redColorButton.widthAnchor.constraint(equalToConstant: 50),
            
            blackColorButton.topAnchor.constraint(equalTo: fontWeightSegment.bottomAnchor, constant: 20),
            blackColorButton.leadingAnchor.constraint(equalTo: menuView.centerXAnchor, constant: 50),
            blackColorButton.heightAnchor.constraint(equalToConstant: 50),
            blackColorButton.widthAnchor.constraint(equalToConstant: 50),
            
            chooseFontPicker.topAnchor.constraint(equalTo: blackColorButton.bottomAnchor, constant: 0),
            chooseFontPicker.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: 10),
            chooseFontPicker.trailingAnchor.constraint(equalTo: menuView.centerXAnchor),
            chooseFontPicker.bottomAnchor.constraint(equalTo: menuView.bottomAnchor, constant: 10),
            
            darkThemeLabel.centerYAnchor.constraint(equalTo: chooseFontPicker.centerYAnchor),
            darkThemeLabel.leadingAnchor.constraint(equalTo: chooseFontPicker.trailingAnchor, constant: 10),
            
            darkThemeSwitch.centerYAnchor.constraint(equalTo: darkThemeLabel.centerYAnchor),
            darkThemeSwitch.trailingAnchor.constraint(equalTo: menuView.trailingAnchor, constant: -10)
            
        ])
        
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        menuView.isHidden = false
        UIView.animate(withDuration: 0.1) {
            self.menuView.alpha = 1
        }
        return false
    }
    
}

extension UIFont {
    func withWeight(_ weight: UIFont.Weight) -> UIFont {
        let descriptor = fontDescriptor.addingAttributes([.traits: [UIFontDescriptor.TraitKey.weight: weight]])
        return UIFont(descriptor: descriptor, size: pointSize)
    }
}


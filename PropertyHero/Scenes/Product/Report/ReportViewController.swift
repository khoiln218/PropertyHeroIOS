//
//  ReportViewController.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/24/23.
//

import UIKit
import MGArchitecture
import RxSwift
import RxCocoa
import Reusable
import Then
import DLRadioButton

final class ReportViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var warningCompleted: DLRadioButton!
    @IBOutlet weak var inputReport: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    
    // MARK: - Properties
    
    var viewModel: ReportViewModel!
    var disposeBag = DisposeBag()
    let warningType = PublishSubject<Int>()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    
    private func configView() {
        title = "Báo thông tin ảo"
        
        inputReport.layer.borderColor = UIColor(hex: "#CFD8DC")?.cgColor
        inputReport.layer.borderWidth = 1
        inputReport.layer.cornerRadius = 3
        inputReport.layer.masksToBounds = true
        inputReport.delegate = self
    }
    
    @IBAction func warningCompletedChecked(_ sender: DLRadioButton) {
        warningType.onNext(0)
    }
    
    @IBAction func warningInfoChecked(_ sender: DLRadioButton) {
        warningType.onNext(1)
    }
    func bindViewModel() {
        let input = ReportViewModel.Input(
            warningType: warningType.asDriverOnErrorJustComplete(),
            content: inputReport.rx.text.orEmpty.asDriver(),
            report: sendBtn.rx.tap.asDriver()
        )
        let output = viewModel.transform(input, disposeBag: disposeBag)
    }
}

// MARK: - Binders
extension ReportViewController: UITextViewDelegate {
    func textViewDidBeginEditing (_ textView: UITextView) {
        if textView.isFirstResponder {
            textView.text = nil
            textView.textColor = UIColor(hex: "#424242")
        }
    }
    
    func textViewDidEndEditing (_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == "" {
            textView.textColor = UIColor(hex: "#808080")
            textView.text = "Nhập mô tả thêm"
        }
    }
}

// MARK: - StoryboardSceneBased
extension ReportViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.product
}

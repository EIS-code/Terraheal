//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation

class FaqQuestionCell: TableCell {

      @IBOutlet weak var vwBg: UIView!
      @IBOutlet weak var txtQuestion: ACFloatingTextfield!
      @IBOutlet weak var lblTitle: ThemeLabel!
      

      override func awakeFromNib() {
          super.awakeFromNib()
          selectionStyle = .none
          self.txtQuestion.disableFloatingLabel = true
          self.lblTitle.setFont(name: FontName.SemiBold, size: FontSize.regular)
          self.txtQuestion.setFont(name: FontName.Regular, size: FontSize.detail)
      }

      func setData(data: FAQItem ) {
          self.lblTitle.text = data.question
          self.txtQuestion.placeholder = data.question
          self.txtQuestion.text = data.answer
      }

      override func layoutSubviews() {
          super.layoutSubviews()

      }

      override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)
          // Configure the view for the selected state
      }
}





//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation

class FaqQuestionCell: TableCell {

      @IBOutlet weak var vwBg: UIView!
      @IBOutlet weak var lblTitle: ThemeLabel!
      @IBOutlet weak var lblAnswer: ThemeLabel!


      override func awakeFromNib() {
          super.awakeFromNib()
      
          self.lblTitle.setFont(name: FontName.SemiBold, size: FontSize.regular)
          self.lblAnswer.setFont(name: FontName.Regular, size: FontSize.detail)
      }

      func setData(data: FAQItem ) {
          self.lblTitle.text = data.question
          self.lblAnswer.text = data.answer

      }

      override func layoutSubviews() {
          super.layoutSubviews()

      }

      override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)
          // Configure the view for the selected state
      }
}





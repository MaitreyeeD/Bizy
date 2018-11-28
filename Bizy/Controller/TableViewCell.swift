import UIKit
import Photos

class TableViewCell: UITableViewCell {
  
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var company: UILabel!
  @IBOutlet weak var position: UILabel!
  @IBOutlet var photo: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
}

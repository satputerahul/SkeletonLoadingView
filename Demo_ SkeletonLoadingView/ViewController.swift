
import UIKit

class ItemsTableViewCell: UITableViewCell
{
    @IBOutlet var vw_item: UIView!
    @IBOutlet var img_item: UIImageView!
    @IBOutlet var lbl_item: UILabel!
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tv_items: UITableView!
    var img = ["watch1", "watch2", "watch3", "watch4", "watch5", "watch6", "watch7", "watch8", "watch9"]
    var imgarr: [UIImage] {
        return img.compactMap { UIImage(named: $0) }
    }
    var imgName = ["Rolex", "OMEGA", "Cartier", "Breguet", "Timex", "Fossil", "Casio", "Fastrack", "Armani"]
    var isLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tv_items.delegate = self
        tv_items.dataSource = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            
            self.isLoading = false
            self.tv_items.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgarr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tv_items.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemsTableViewCell
            cell.vw_item.layer.cornerRadius = 12
            cell.vw_item.setupShadow()
            
            if isLoading {
        
                cell.lbl_item.addGlowAnimation()
                cell.img_item.addGlowAnimation()
                
            } else {
            
                cell.vw_item.backgroundColor = UIColor(named: "vw_bgColor")
                cell.img_item.image = imgarr[indexPath.row]
                cell.lbl_item.text = imgName[indexPath.row]
                cell.img_item.removeAllLayers()
                cell.lbl_item.removeAllLayers()
               
            }
            
            return cell
        }
    
    private var gradientLayer: CAGradientLayer?
    func addGlowAnimation(_ iv_image: UIImageView) -> CAGradientLayer {
        
        // Create and configure the gradient layer
        gradientLayer = nil
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = iv_image.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        iv_image.layer.addSublayer(gradientLayer)
        
        // Create and add the animation
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-0.5, 0.0, 0.5]
        animation.toValue = [0.5, 1.0, 1.5]
        animation.duration = 3.0
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: "glowAnimation")
        
        // Store the gradient layer for later use
        self.gradientLayer = gradientLayer
        return gradientLayer
    }
    func stopGlowAnimation(_ iv_image: UIImageView) -> CAGradientLayer {
        gradientLayer?.removeAnimation(forKey: "glowAnimation")

        gradientLayer?.removeFromSuperlayer()
     
        return gradientLayer!
    }
    
}


extension UIView
{
    
    func setupShadow() {
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.layer.cornerRadius = 10
       
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
    }
    
}

extension UIView {

    func addGlowAnimation() {
        let backgroundColor = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0).cgColor
        self.backgroundColor = UIColor(cgColor: backgroundColor)
        let highlightColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0).cgColor
        // Create and configure the gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [backgroundColor, highlightColor, backgroundColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.layer.addSublayer(gradientLayer)
        // Create and add the animation
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-0.5, 0.0, 0.5]
        animation.toValue = [0.5, 1.0, 1.5]
        animation.duration = 3.0
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: "glowAnimation")
    }
   
    func removeAllLayers() {
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        self.backgroundColor = .none
    }
}

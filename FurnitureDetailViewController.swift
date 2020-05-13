
import UIKit

class FurnitureDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var furniture: Furniture?
    var UIImagePNGRepresentaion: UIImagePNGRepresentaion?
    
    @IBOutlet var choosePhotoButton: UIButton!
    @IBOutlet var furnitureTitleLabel: UILabel!
    @IBOutlet var furnitureDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    func updateView() {
        guard let furniture = furniture else {return}
        if let imageData = furniture.imageData,
            let image = UIImage(data: imageData) {
            choosePhotoButton.setTitle("", for: .normal)
            choosePhotoButton.setBackgroundImage(image, for: .normal)
        } else {
            choosePhotoButton.setTitle("Choose Image", for: .normal)
            choosePhotoButton.setBackgroundImage(nil, for: .normal)
        }
        
        furnitureTitleLabel.text = furniture.name
        furnitureDescriptionLabel.text = furniture.description
    }
    
    @IBAction func choosePhotoButtonTapped(_ sender: Any) {
      let imagePicker = UIImagePickerController()
        print("PHOTO SELECT")
        let alertController = UIAlertController(title: nil, message: "Image Collecgion", preferredStyle: .actionSheet)
        _ = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let albumAction = UIAlertAction(title: "Image from Album", style: .default, handler: {(_) in
            imagePicker.sourceType = .photoLibrary
            
            self.present(imagePicker, animated: true, completion: nil)
        })
        alertController.addAction(albumAction)
        
        
        
        imagePicker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Image from camera", style: .default, handler: { (_) in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
       
        
        }
        
        
        
        alertController.addAction(albumAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
            
        }
      
        furniture?.imageData = UIImagePNGRepresentaion(image)
        dismiss(animated: true) {
            self.updateView()
        }
    }
   
    
    @IBAction func actionButtonTapped(_ sender: Any) {
    
       
        guard let furniture = furniture else {return}
        var items: [Any] = ["\(furniture.name): \(furniture.description)"]
        if let image = choosePhotoButton.backgroundImage(for: .normal) {
            items.append(image)
        }
        let activityController =  UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityController, animated: true,completion: nil)

        
    }
    
}



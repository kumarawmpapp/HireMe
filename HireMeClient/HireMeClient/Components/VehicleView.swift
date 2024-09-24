//
//  VehicleView.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 10/14/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit

class VehicleCollectionViewCell: BaseCollectionViewCell {
    fileprivate static let vehicleCollectionViewCellIdentifier = "VehicleViewCell"
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var vehicleImage: UIImageView!
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                vehicleImage.tintColor = ApplicationColor.HEX_343434
            }
        }
    }
    
    var vehicleModel: VehicleViewCellModel! {
        didSet {
            textLabel.text = vehicleModel.vehicleName
            vehicleImage.image = vehicleModel.vehicleImage
        }
    }
    
    override func initView() {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textLabel.font = ApplicationFonts.generalFont(withSize: 10.0)
        textLabel.textColor = ApplicationColor.color12
        vehicleImage.contentMode = .scaleAspectFit
    }
}

class VehicleViewCellModel {
    var vehicleName: String!
    var approximateTime: String = ""
    var vehicleImage: UIImage!
    
    init(VName:String, VImage:UIImage) {
        vehicleName = VName
        vehicleImage = VImage
    }
    
}

class VehicleCollectionViewLayout: UICollectionViewLayout {
    var cache = [UICollectionViewLayoutAttributes]()
    
    var collectionViewContentWidth: CGFloat {
        return CGFloat(collectionViewCellWidth * Double(collectionViewItems))
    }
    
    var collectionViewItems: Int {
        guard let collectionView = collectionView else {
            return 0
        }
        
        return collectionView.numberOfItems(inSection: 0)
    }
    
    var collectionViewCellWidth: Double = 100.0
    var collectionViewCellHeight: Double = 50.0
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionViewContentWidth, height: CGFloat(collectionViewCellHeight))
    }
    
    override func prepare() {        
        for item in 0 ..< collectionViewItems {
            
            let indexPath = IndexPath(item: item, section: 0)
            let xOffset: CGFloat = CGFloat(Double(indexPath.row) * collectionViewCellWidth)
            let frame = CGRect(x: xOffset, y: 0.0, width: CGFloat(collectionViewCellWidth), height: CGFloat(collectionViewCellHeight))
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cache.append(attributes)
            
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}

class VehicleView: CustomView {
    @IBOutlet weak var vehicleCollectionView: UICollectionView!
   
    var vehiclesArray:[VehicleViewCellModel] = []
    
    override func initView() {
        super.initView()
        
        vehicleCollectionView.dataSource = self
        vehicleCollectionView.showsVerticalScrollIndicator = false
        vehicleCollectionView.register(UINib(nibName: "VehicleViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: VehicleCollectionViewCell.vehicleCollectionViewCellIdentifier)

        vehiclesArray.append(contentsOf: [VehicleViewCellModel(VName: activeLanguage.threewheel, VImage: #imageLiteral(resourceName: "threewheel")),
                                          VehicleViewCellModel(VName: activeLanguage.nanocar, VImage: #imageLiteral(resourceName: "nano")),
                             VehicleViewCellModel(VName: activeLanguage.minicar, VImage: #imageLiteral(resourceName: "minicar")),
                             VehicleViewCellModel(VName: activeLanguage.luxurycar, VImage: #imageLiteral(resourceName: "luxurycar")),
                             VehicleViewCellModel(VName: activeLanguage.van, VImage: #imageLiteral(resourceName: "van"))])
        
        vehicleCollectionView.reloadData()
        vehicleCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
    }    
}

extension VehicleView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vehiclesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = vehicleCollectionView.dequeueReusableCell(withReuseIdentifier: VehicleCollectionViewCell.vehicleCollectionViewCellIdentifier, for: indexPath) as! VehicleCollectionViewCell
        cell.vehicleModel = vehiclesArray[indexPath.row]
        return cell
    }
}

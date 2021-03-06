//
// LoginANMTDView.swift


import UIKit

@IBDesignable
class LoginANMTDView : UIView {


	var animationCompletions = Dictionary<CAAnimation, (Bool) -> Void>()
	var viewsByName: [String : UIView]!

	// - MARK: Life Cycle

	convenience init() {
		self.init(frame: CGRect(x: 0, y: 0, width: 768, height: 1136))
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setupHierarchy()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setupHierarchy()
	}

	// - MARK: Scaling

	override func layoutSubviews() {
		super.layoutSubviews()

		if let scalingView = self.viewsByName["__scaling__"] {
			var xScale = self.bounds.size.width / scalingView.bounds.size.width
			var yScale = self.bounds.size.height / scalingView.bounds.size.height
			switch contentMode {
			case .ScaleToFill:
				break
			case .ScaleAspectFill:
				let scale = max(xScale, yScale)
				xScale = scale
				yScale = scale
			default:
				let scale = min(xScale, yScale)
				xScale = scale
				yScale = scale
			}
			scalingView.transform = CGAffineTransformMakeScale(xScale, yScale)
			scalingView.center = CGPoint(x:CGRectGetMidX(self.bounds), y:CGRectGetMidY(self.bounds))
		}
	}

	// - MARK: Setup

	func setupHierarchy() {
		var viewsByName: [String : UIView] = [:]
		let bundle = NSBundle(forClass:self.dynamicType)
		let __scaling__ = UIView()
		__scaling__.bounds = CGRect(x:0, y:0, width:768, height:1136)
		__scaling__.center = CGPoint(x:384.0, y:568.0)
		self.addSubview(__scaling__)
		viewsByName["__scaling__"] = __scaling__

		let windmill = UIImageView()
		windmill.bounds = CGRect(x:0, y:0, width:2812.0, height:1554.0)
		var imgWindmill: UIImage!
		if let imagePath = bundle.pathForResource("windmill.png", ofType:nil) {
			imgWindmill = UIImage(contentsOfFile:imagePath)
		}else {
			print("** Warning: Could not create image from 'windmill.png'. Please make sure that it is added to the project directly (not in a folder reference).")
		}
		windmill.image = imgWindmill
		windmill.contentMode = .Center
		windmill.layer.position = CGPoint(x:384.000, y:902.900)
		windmill.transform = CGAffineTransformMakeScale(0.30, 0.30)
		__scaling__.addSubview(windmill)
		viewsByName["windmill"] = windmill

		let blades = UIImageView()
		blades.bounds = CGRect(x:0, y:0, width:762.0, height:760.0)
		var imgBlades: UIImage!
		if let imagePath = bundle.pathForResource("blades.png", ofType:nil) {
			imgBlades = UIImage(contentsOfFile:imagePath)
		}else {
			print("** Warning: Could not create image from 'blades.png'. Please make sure that it is added to the project directly (not in a folder reference).")
		}
		blades.image = imgBlades
		blades.contentMode = .Center
		blades.layer.position = CGPoint(x:242.114, y:839.137)
		blades.transform = CGAffineTransformMakeScale(0.30, 0.30)
		__scaling__.addSubview(blades)
		viewsByName["blades"] = blades

		let cloud2 = UIImageView()
		cloud2.bounds = CGRect(x:0, y:0, width:208.0, height:135.0)
		var imgCloud2: UIImage!
		if let imagePath = bundle.pathForResource("cloud_2.png", ofType:nil) {
			imgCloud2 = UIImage(contentsOfFile:imagePath)
		}else {
			print("** Warning: Could not create image from 'cloud_2.png'. Please make sure that it is added to the project directly (not in a folder reference).")
		}
		cloud2.image = imgCloud2
		cloud2.contentMode = .Center
		cloud2.layer.position = CGPoint(x:832.515, y:635.500)
		__scaling__.addSubview(cloud2)
		viewsByName["cloud_2"] = cloud2

		let cloud1 = UIImageView()
		cloud1.bounds = CGRect(x:0, y:0, width:208.0, height:135.0)
		var imgCloud1: UIImage!
		if let imagePath = bundle.pathForResource("cloud_1.png", ofType:nil) {
			imgCloud1 = UIImage(contentsOfFile:imagePath)
		}else {
			print("** Warning: Could not create image from 'cloud_1.png'. Please make sure that it is added to the project directly (not in a folder reference).")
		}
		cloud1.image = imgCloud1
		cloud1.contentMode = .Center
		cloud1.layer.position = CGPoint(x:0.000, y:568.000)
		__scaling__.addSubview(cloud1)
		viewsByName["cloud_1"] = cloud1

		let cloud = UIImageView()
		cloud.bounds = CGRect(x:0, y:0, width:208.0, height:135.0)
		var imgCloud: UIImage!
		if let imagePath = bundle.pathForResource("cloud.png", ofType:nil) {
			imgCloud = UIImage(contentsOfFile:imagePath)
		}else {
			print("** Warning: Could not create image from 'cloud.png'. Please make sure that it is added to the project directly (not in a folder reference).")
		}
		cloud.image = imgCloud
		cloud.contentMode = .Center
		cloud.layer.position = CGPoint(x:280.000, y:466.864)
		__scaling__.addSubview(cloud)
		viewsByName["cloud"] = cloud

		self.viewsByName = viewsByName
	}

	// - MARK: loginAnimate

	func addLoginAnimateAnimation() {
		addLoginAnimateAnimationWithBeginTime(0, fillMode: kCAFillModeBoth, removedOnCompletion: false, completion: nil)
	}

	func addLoginAnimateAnimation(completion: ((Bool) -> Void)?) {
		addLoginAnimateAnimationWithBeginTime(0, fillMode: kCAFillModeBoth, removedOnCompletion: false, completion: completion)
	}

	func addLoginAnimateAnimation(removedOnCompletion removedOnCompletion: Bool) {
		addLoginAnimateAnimationWithBeginTime(0, fillMode: removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth, removedOnCompletion: removedOnCompletion, completion: nil)
	}

	func addLoginAnimateAnimation(removedOnCompletion removedOnCompletion: Bool, completion: ((Bool) -> Void)?) {
		addLoginAnimateAnimationWithBeginTime(0, fillMode: removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth, removedOnCompletion: removedOnCompletion, completion: completion)
	}

	func addLoginAnimateAnimationWithBeginTime(beginTime: CFTimeInterval, fillMode: String, removedOnCompletion: Bool, completion: ((Bool) -> Void)?) {
		let linearTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
		let anticOverTiming = CAMediaTimingFunction(controlPoints: 0.42, -0.30, 0.58, 1.30)
		if let complete = completion {
			let representativeAnimation = CABasicAnimation(keyPath: "not.a.real.key")
			representativeAnimation.duration = 8.500
			representativeAnimation.delegate = self
			self.layer.addAnimation(representativeAnimation, forKey: "LoginAnimate")
			self.animationCompletions[layer.animationForKey("LoginAnimate")!] = complete
		}

		let bladesRotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
		bladesRotationAnimation.duration = 2.000
		bladesRotationAnimation.values = [0.000 as Float, 6.283 as Float]
		bladesRotationAnimation.keyTimes = [0.000 as Float, 1.000 as Float]
		bladesRotationAnimation.timingFunctions = [linearTiming]
		bladesRotationAnimation.repeatCount = HUGE
		bladesRotationAnimation.beginTime = beginTime
		bladesRotationAnimation.fillMode = fillMode
		bladesRotationAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["blades"]?.layer.addAnimation(bladesRotationAnimation, forKey:"loginAnimate_Rotation")

		let cloud1TranslationXAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
		cloud1TranslationXAnimation.duration = 8.500
		cloud1TranslationXAnimation.values = [0.000 as Float, 870.000 as Float]
		cloud1TranslationXAnimation.keyTimes = [0.000 as Float, 1.000 as Float]
		cloud1TranslationXAnimation.timingFunctions = [linearTiming]
		cloud1TranslationXAnimation.repeatCount = HUGE
		cloud1TranslationXAnimation.beginTime = beginTime
		cloud1TranslationXAnimation.fillMode = fillMode
		cloud1TranslationXAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["cloud_1"]?.layer.addAnimation(cloud1TranslationXAnimation, forKey:"loginAnimate_TranslationX")

		let cloud2TranslationXAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
		cloud2TranslationXAnimation.duration = 8.500
		cloud2TranslationXAnimation.values = [0.000 as Float, -940.000 as Float]
		cloud2TranslationXAnimation.keyTimes = [0.000 as Float, 1.000 as Float]
		cloud2TranslationXAnimation.timingFunctions = [linearTiming]
		cloud2TranslationXAnimation.repeatCount = HUGE
		cloud2TranslationXAnimation.beginTime = beginTime
		cloud2TranslationXAnimation.fillMode = fillMode
		cloud2TranslationXAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["cloud_2"]?.layer.addAnimation(cloud2TranslationXAnimation, forKey:"loginAnimate_TranslationX")

		let cloudTranslationXAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
		cloudTranslationXAnimation.duration = 7.500
		cloudTranslationXAnimation.values = [0.000 as Float, 140.882 as Float, 267.891 as Float, 98.317 as Float, 0.000 as Float]
		cloudTranslationXAnimation.keyTimes = [0.000 as Float, 0.133 as Float, 0.233 as Float, 0.317 as Float, 1.000 as Float]
		cloudTranslationXAnimation.timingFunctions = [anticOverTiming, anticOverTiming, anticOverTiming, linearTiming]
		cloudTranslationXAnimation.repeatCount = HUGE
		cloudTranslationXAnimation.beginTime = beginTime
		cloudTranslationXAnimation.fillMode = fillMode
		cloudTranslationXAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["cloud"]?.layer.addAnimation(cloudTranslationXAnimation, forKey:"loginAnimate_TranslationX")

		let cloudTranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
		cloudTranslationYAnimation.duration = 7.500
		cloudTranslationYAnimation.values = [0.000 as Float, -58.473 as Float, -26.891 as Float, -46.401 as Float, 0.000 as Float]
		cloudTranslationYAnimation.keyTimes = [0.000 as Float, 0.133 as Float, 0.233 as Float, 0.317 as Float, 1.000 as Float]
		cloudTranslationYAnimation.timingFunctions = [anticOverTiming, anticOverTiming, anticOverTiming, linearTiming]
		cloudTranslationYAnimation.repeatCount = HUGE
		cloudTranslationYAnimation.beginTime = beginTime
		cloudTranslationYAnimation.fillMode = fillMode
		cloudTranslationYAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["cloud"]?.layer.addAnimation(cloudTranslationYAnimation, forKey:"loginAnimate_TranslationY")
	}

	func removeLoginAnimateAnimation() {
		self.layer.removeAnimationForKey("LoginAnimate")
		self.viewsByName["blades"]?.layer.removeAnimationForKey("loginAnimate_Rotation")
		self.viewsByName["cloud_1"]?.layer.removeAnimationForKey("loginAnimate_TranslationX")
		self.viewsByName["cloud_2"]?.layer.removeAnimationForKey("loginAnimate_TranslationX")
		self.viewsByName["cloud"]?.layer.removeAnimationForKey("loginAnimate_TranslationX")
		self.viewsByName["cloud"]?.layer.removeAnimationForKey("loginAnimate_TranslationY")
	}

	override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
		if let completion = self.animationCompletions[anim] {
			self.animationCompletions.removeValueForKey(anim)
			completion(flag)
		}
	}

	func removeAllAnimations() {
		for subview in viewsByName.values {
			subview.layer.removeAllAnimations()
		}
		self.layer.removeAnimationForKey("LoginAnimate")
	}
}
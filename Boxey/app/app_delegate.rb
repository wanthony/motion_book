class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
    @window.makeKeyAndVisible

    @blue_view = UIView.alloc.initWithFrame(CGRect.new([10,10], [100, 100]))
    @blue_view.backgroundColor = UIColor.blueColor
    @window.addSubview @blue_view

    @button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @button.setTitle('Add', forState: UIControlStateNormal)
    @button.sizeToFit
    @button.frame = CGRect.new [10, @window.frame.size.height - 10 - @button.frame.size.height], @button.frame.size
    @window.addSubview @button

    @button.addTarget(self, action: 'add_tapped', forControlEvents: UIControlEventTouchUpInside)

    true
  end

  def add_tapped
    new_view = UIView.alloc.initWithFrame(CGRect.new([0,0], [100,100]))
    new_view.backgroundColor = UIColor.blueColor
    last_view = @window.subviews.first

    new_view.frame = CGRect.new([last_view.frame.origin.x, last_view.frame.origin.y + last_view.frame.size.height + 10], last_view.frame.size)

    @window.insertSubview(new_view, atIndex: 0)
  end
end

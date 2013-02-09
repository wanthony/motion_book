class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
    @window.makeKeyAndVisible

    @box_color = UIColor.blueColor

    @blue_view = UIView.alloc.initWithFrame(CGRect.new([10,10], [100, 100]))
    @blue_view.backgroundColor = @box_color
    @window.addSubview @blue_view

    add_labels_to_boxes

    @button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @button.setTitle('Add', forState: UIControlStateNormal)
    @button.sizeToFit
    @button.frame = CGRect.new [10, @window.frame.size.height - 10 - @button.frame.size.height], @button.frame.size
    @window.addSubview @button

    @button.addTarget(self, action: 'add_tapped', forControlEvents: UIControlEventTouchUpInside)

    @remove_button = UIButton.buttonWithType UIButtonTypeRoundedRect
    @remove_button.setTitle('Remove', forState: UIControlStateNormal)
    @remove_button.sizeToFit
    @remove_button.frame = CGRect.new [@button.frame.origin.x + @button.frame.size.width + 10, @button.frame.origin.y], @button.frame.size
    @window.addSubview @remove_button

    @remove_button.addTarget(self, action: 'remove_tapped', forControlEvents: UIControlEventTouchUpInside)

    @color_field = UITextField.alloc.initWithFrame(CGRectZero)
    @color_field.borderStyle = UITextBorderStyleRoundedRect
    @color_field.text = "Blue"
    @color_field.enablesReturnKeyAutomatically = true
    @color_field.returnKeyType = UIReturnKeyDone
    @color_field.autocapitalizationType = UITextAutocapitalizationTypeNone
    @color_field.sizeToFit
    @color_field.frame = CGRect.new([@blue_view.frame.origin.x + @blue_view.frame.size.width + 10, @blue_view.frame.origin.y + @color_field.frame.size.height], @color_field.frame.size)
    @window.addSubview @color_field

    @color_field.delegate = self

    true
  end

  def textFieldShouldReturn textField
    color_tapped
    textField.resignFirstResponder
    false
  end

  def color_tapped
    color_prefix = @color_field.text
    color_method = "#{color_prefix.downcase}Color"
    if UIColor.respond_to?(color_method)
      @box_color = UIColor.send(color_method)
      boxes.each {|box| box.backgroundColor = @box_color }
    else
      UIAlertView.alloc.initWithTitle("Invalid Color", message: "#{color_prefix} is not a valid color", delegate: nil, cancelButtonTitle: "OK", otherButtonTitles: nil).show
    end
  end

  def add_tapped
    new_view = UIView.alloc.initWithFrame(CGRect.new([0,0], [100,100]))
    new_view.backgroundColor = @box_color
    last_view = @window.subviews.first

    new_view.frame = CGRect.new([last_view.frame.origin.x, last_view.frame.origin.y + last_view.frame.size.height + 10], last_view.frame.size)

    @window.insertSubview(new_view, atIndex: 0)
    add_labels_to_boxes
  end

  def remove_tapped
    other_views = boxes
    @last_view = other_views.last

    if @last_view && other_views.count > 1
      UIView.animateWithDuration(0.5,
                                 animations: lambda {
                                   @last_view.alpha = 0
                                   @last_view.backgroundColor = UIColor.redColor
                                   other_views.each do |view|
                                     next if @view == @last_view
                                     view.frame = CGRect.new [view.frame.origin.x, view.frame.origin.y - (@last_view.frame.size.height + 10)], view.frame.size
                                   end
                                 },

                                 completion: lambda {|finished|
                                   @last_view.removeFromSuperview
                                   add_labels_to_boxes
                                 }
                                 )
    end
  end

  def boxes
    @window.subviews.reject {|view| view.is_a?(UIButton) || view.is_a?(UILabel) || view.is_a?(UITextField) }
  end

  def add_labels_to_boxes
    boxes.each {|box| add_label_to_box(box) }
  end

  def add_label_to_box box
    box.subviews.each(&:removeFromSuperview)

    index_of_box = @window.subviews.index(box)
    label = UILabel.alloc.initWithFrame(CGRectZero)
    label.text = index_of_box.to_s
    label.textColor = UIColor.whiteColor
    label.backgroundColor = UIColor.clearColor
    label.sizeToFit
    label.center = [box.frame.size.width / 2, box.frame.size.height / 2]

    box.addSubview(label)
  end
end

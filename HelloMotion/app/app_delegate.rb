class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @alert = UIAlertView.alloc.initWithTitle('Hello', message: "Hello, rubymotion!", delegate: nil, cancelButtonTitle: "OK", otherButtonTitles: nil)
    @alert.show

    puts "Hello from the console"

    true
  end
end

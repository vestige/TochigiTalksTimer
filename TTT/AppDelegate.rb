class AppDelegate
  attr_accessor :window
  attr_accessor :remain
  attr_accessor :select_time
  attr_accessor :time_label
  attr_accessor :message_label
  
  def applicationDidFinishLaunching(a_notification)
    # Insert code here to initialize your application
    setup_time_label()

    message_label.StringValue = ""
    @started = false

    @test_ = 1
  end

  def setup_time_label()
    @count_sec = setup_time_listbox() * 60
    disp_time(@count_sec)
  end
  
  def disp_time(time)
    min, sec = time.divmod 60
    text = sprintf("%d:%02d", min, sec)    
    
    @time_label.StringValue = text
  end
  
  def setup_time_listbox()
    select_time.removeAllItems()
    select_time.insertItemWithTitle("1",
                                    atIndex:0)
    select_time.insertItemWithTitle("5",
                                    atIndex:1)
    select_time.insertItemWithTitle("15",
                                    atIndex:2)
    select_time.insertItemWithTitle("30",
                                    atIndex:3)
    select_time.synchronizeTitleAndSelectedItem()
    select_time.selectItemAtIndex(0)
    
    return select_time.selectedItem.title.to_i
  end
  
  def update_select(sender)
    @count_sec = select_time.selectedItem.title.to_i * 60
    disp_time(@count_sec)
  end

  def clicked_start(sender)
    select_time.setEnabled(false)

    @started = true
    @start_time = Time.now
    @end_time = @start_time + @count_sec + 1
    @timer = NSTimer.scheduledTimerWithTimeInterval(0.2,
                                                    target:self,
                                                    selector:"step:",
                                                    userInfo:nil,
                                                    repeats:true)
  end

  def step(sender)
    p "time break."
    @test_ += 1
    p @test_
  end

  def clicked_stop(sender)
    select_time.setEnabled(true)

    @started = false
    @timer.invalidate
  end
  
  def clicked_clear(sender)
    return if (@started)
 
    
  end
end


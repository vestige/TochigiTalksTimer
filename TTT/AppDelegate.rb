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

  end

  def init_disp_time(sec)
    @init_sec = sec
    disp_time(sec)    
  end

  def setup_time_label()
    @count_sec = setup_time_listbox() * 60
    init_disp_time(@count_sec)
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
    select_time.insertItemWithTitle("20",
                                    atIndex:2)
    select_time.insertItemWithTitle("30",
                                    atIndex:3)
    select_time.synchronizeTitleAndSelectedItem()
    select_time.selectItemAtIndex(1)
    
    return select_time.selectedItem.title.to_i
  end
  
  def update_select(sender)
    @count_sec = select_time.selectedItem.title.to_i * 60
    init_disp_time(@count_sec)
  end

  def clicked_start(sender)
    return if (@started)
    
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

  def remain()
    (@end_time - Time.now)
  end

  def step(sender)
    # fixme 
    p remain()
    
    tmp = remain().floor
    p tmp
    disp_time(tmp)
  end

  def clicked_stop(sender)
    return if (! @started)
    
    select_time.setEnabled(true)

    @timer.invalidate

    @started = false
    @count_sec = remain().floor
  end
  
  def clicked_clear(sender)
    return if (@started)
 
    @started = false
    disp_time(@init_sec)
  end
end


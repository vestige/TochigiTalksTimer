class AppDelegate
  attr_accessor :window
  attr_accessor :select_time
  attr_accessor :time_label
  attr_accessor :message_label
  attr_accessor :bkimage
  
  def applicationDidFinishLaunching(a_notification)
    setup_time_label()

    @message_label.StringValue = ""
    @started = false
  end

  def init_disp_time(sec)
    @init_sec = sec
    disp_time(sec)    
  end

  def setup_time_label()
    @count_sec = setup_time_listbox()
    init_disp_time(@count_sec)
  end
  
  def disp_time(time)
    if isFinishReady(time) || isFinish(time)
      color = NSColor.greenColor()
      @time_label.setTextColor(color) 
    else
      color = NSColor.blackColor()
      @time_label.setTextColor(color) 
    end
    
    min, sec = time.divmod 60    
    text = sprintf("%d:%02d", min, sec)    

    @time_label.StringValue = text
    
    if isFinish(time)
      @time_label.StringValue = "88888"
    end
  end
  
  def setup_time_listbox()
    @select_time.removeAllItems()
    @select_time.insertItemWithTitle("1",
                                    atIndex:0)
    @select_time.insertItemWithTitle("5",
                                    atIndex:1)
    @select_time.insertItemWithTitle("20",
                                    atIndex:2)
    @select_time.insertItemWithTitle("30",
                                    atIndex:3)
    @select_time.synchronizeTitleAndSelectedItem()
    @select_time.selectItemAtIndex(1)

    return @select_time.selectedItem.title.to_i * 60
  end
  
  def update_select(sender)
    @count_sec = @select_time.selectedItem.title.to_i * 60
    init_disp_time(@count_sec)
  end

  def clicked_start(sender)
    return if (@started)
    
    @select_time.setEnabled(false)

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


  def isFinishReady(time)
    (1..10).member?(time)
  end

  def isFinish(time)
    return (time == 0)
  end
  
  def disp_label(time)
    if isFinishReady(time)
      @message_label.StringValue = "拍手の準備を"
    elsif isFinish(time)
      @message_label.StringValue = "拍手〜♪"
    else
      @message_label.StringValue = ""
    end
  end
  
  def disp_back(time)
    if isFinish(time)
      @bkimage.setAlphaValue(0.1)
    else
      @bkimage.setAlphaValue(0.9)
    end
  end
                
  def step(sender)    
    tmp = remain().floor
    clicked_stop(sender) if isFinish(tmp)

    disp_label(tmp)
    disp_time(tmp)
    disp_back(tmp)
  end

  def clicked_stop(sender)
    return if (! @started)
    
    @select_time.setEnabled(true)

    @timer.invalidate

    @started = false
    @count_sec = remain().floor
  end
  
  def clicked_clear(sender)
    return if (@started)
 
    @started = false
    setup_time_label()
    disp_label(@init_sec)
    disp_back(@init_sec)
  end
  
  def demo(sender)
    @count_sec = 30
    clicked_start(sender)
  end
  
end


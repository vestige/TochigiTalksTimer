class AppDelegate
  attr_accessor :window
  attr_accessor :remain
  attr_accessor :select_time
  
  def applicationDidFinishLaunching(a_notification)
    # Insert code here to initialize your application
    setup_time_listbox()
  end

  def setup_time_listbox()
    select_time.removeAllItems()
    select_time.insertItemWithTitle("5",
                                    atIndex:0)
    select_time.synchronizeTitleAndSelectedItem()
    select_time.insertItemWithTitle("15",
                                    atIndex:1)
    select_time.synchronizeTitleAndSelectedItem()
    select_time.insertItemWithTitle("30",
                                    atIndex:2)
    select_time.synchronizeTitleAndSelectedItem()
    select_time.selectItemAtIndex(2)
  end
  
  def update_select(sender)
    p select_time.selectedItem.title
  end
end


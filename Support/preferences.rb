require ENV['TM_SUPPORT_PATH'] + '/lib/escape.rb'
require ENV['TM_SUPPORT_PATH'] + '/lib/osx/plist'

module Preferences
  
  @prefspath = "#{ENV['HOME']}/Library/Preferences/com.macromates.textmate.wordpress.plist"
  
  def self.display
    settings = self.get_settings
    res = %x{ "$DIALOG" -p #{e_sh settings.to_plist} -m Preferences }
    if ! res.empty?
      File.open(@prefspath,File::RDWR|File::CREAT|File::TRUNC).puts(res)
    end
  end
  
  def self.get_settings
    
    if File.exist?(@prefspath)
      plist = OSX::PropertyList::load(File.open(@prefspath))
    else
      plist = { 
        "wp_path" => "/path/to/wordpress" 
        }
    end
    
    res = plist
  end
  
end
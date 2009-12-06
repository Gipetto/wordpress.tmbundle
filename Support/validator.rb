require ENV['TM_SUPPORT_PATH'] + '/lib/io.rb'
require ENV['TM_SUPPORT_PATH'] + '/lib/web_preview.rb'
require 'open3'
require 'cgi'

module WPValidator
  
  def self.validate_readme
    doc = $stdin.read()
		validated = ''
	  
		Open3.popen3("curl -s -d readme_contents=#{CGI.escape doc} -d text=1 http://wordpress.org/extend/plugins/about/validator/") do |stdin, stdout, stderr|				
      TextMate::IO.exhaust(:out => stdout, :err => stderr) do |data|
        data.each_line do |line|
          if line.match(/<form method="post" action="">/) != nil
            line = line.gsub(/action=""/,'action="http://wordpress.org/extend/plugins/about/validator/"')
          end
          validated << line
        end
      end
		end
			
		puts validated
  end
  
end
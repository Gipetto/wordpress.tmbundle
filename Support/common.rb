require ENV['TM_SUPPORT_PATH'] + '/lib/ui'
require ENV['TM_SUPPORT_PATH'] + '/lib/osx/plist'
require ENV['TM_SUPPORT_PATH'] + '/lib/exit_codes'

module WordPress
  
  # bloginfo/get_bloginfo handler
  def self.bloginfo(get_bloginfo = false)
    bloginfo_command = get_bloginfo == true ? 'get_bloginfo' : 'bloginfo' 
    
    choices = [
      { 'display' => 'admin_email' },
      { 'display' => 'atom_url' },
      { 'display' => 'charset' },
      { 'display' => 'comments_atom_url' },
      { 'display' => 'comments_rss2_url' },
      { 'display' => 'description' },
      { 'display' => 'home' },
      { 'display' => 'html_type' },
      { 'display' => 'language' },
      { 'display' => 'name' },
      { 'display' => 'pingback_url' },
      { 'display' => 'rdf_url' },
      { 'display' => 'rss2_url' },
      { 'display' => 'rss_url' },
      { 'display' => 'siteurl' },
      { 'display' => 'stylesheet_directory' },
      { 'display' => 'stylesheet_url' },
      { 'display' => 'template_directory' },
      { 'display' => 'template_url' },
      { 'display' => 'text_direction' },
      { 'display' => 'url' },
      { 'display' => 'version' },
      { 'display' => 'wpurl' }
    ]
    TextMate::UI.complete(choices)
    
    bloginfo = bloginfo_command + "('${0}');"
    scope = ENV['TM_SCOPE']
    if scope.include? 'source.php.embedded.html'
      puts bloginfo
    else
      puts '<?php ' + bloginfo + ' ?>'
    end
  end
  
  # add_action handler
  #def self.add_action()
  #  choices = OSX::PropertyList.load(File.read(ENV['TM_BUNDLE_SUPPORT'] + '/actions.plist'))
  #  TextMate::UI.complete(choices)
  #  TextMate::exit_insert_snippet("add_action('${0}');");
  #end

end
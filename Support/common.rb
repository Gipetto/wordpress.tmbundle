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
    
    bloginfo = bloginfo_command + "('${1}');\$0"
    scope = ENV['TM_SCOPE']
    if scope.include? 'source.php.embedded.html'
      TextMate.exit_insert_snippet(bloginfo)
    else
      TextMate.exit_insert_snippet('<?php ' + bloginfo + ' ?>')
    end
  end
  
  # Wrapper for enqueue functions
  def self.enqueue()
    choices = [
      { 'title' => 'script', 'func_to_call' => 'enqueue_script' },
      { 'title' => 'script, from theme', 'func_to_call' => 'enqueue_from_theme' },
      { 'title' => 'script, from plugin', 'func_to_call' => 'enqueue_from_plugin' },
      { 'title' => 'style', 'func_to_call' => 'enqueue_style' }
    ]
    
    t = TextMate::UI.menu(choices)
    ret = eval t['func_to_call']
    
    scope = ENV['TM_SCOPE']
    if scope.include? 'source.php.embedded.html'
      TextMate.exit_insert_snippet(ret)
    else
      TextMate.exit_insert_snippet('<?php ' + ret + ' ?>')
    end
  end
  
  # enqueue a style
  def self.enqueue_style()
    style = "wp_enqueue_style('\${1:style_id}',get_bloginfo('template_directory').'\${2:/css/mystyle.css}',${3:array('\${4:string dependency}')},\${5:float version},'\${6:string media}');\$0"    
    return style
  end
 
 # enqueue a script from the theme
 def self.enqueue_from_theme()
   script = "wp_enqueue_script('\${1:script_name}',get_bloginfo('template_directory').'\${2:/js/myscript.js}',${3:array('\${4:string dependency}')},\${5:float version});\$0"
   return script
 end
  
 # enqueue a script from a plugin
 def self.enqueue_from_plugin()
   script = "wp_enqueue_script('\${1:string script_id}','/index.php&\${2:my_action}=\${3:action_handler}',${4:array('\${5:string dependency}')},\${6:float version});\$0"
   return script
 end
  
 # enqueue a predefined script from WordPress
 def self.enqueue_script()
    choices = [
      { 'display' => 'scriptaculous-root' },
      { 'display' => 'scriptaculous-builder' },
      { 'display' => 'scriptaculous-dragdrop' },
      { 'display' => 'scriptaculous-effects' },
      { 'display' => 'scriptaculous-slider' },
      { 'display' => 'scriptaculous-sound' },
      { 'display' => 'scriptaculous-controls' },
      { 'display' => 'scriptaculous' },
      { 'display' => 'cropper' },
      { 'display' => 'swfupload' },
      { 'display' => 'swfupload-degrade' },
      { 'display' => 'swfupload-queue' },
      { 'display' => 'swfupload-handlers' },
      { 'display' => 'jquery' },
      { 'display' => 'jquery-form' },
      { 'display' => 'jquery-color' },
      { 'display' => 'jquery-ui-core' },
      { 'display' => 'jquery-ui-tabs' },
      { 'display' => 'jquery-ui-sortable' },
      { 'display' => 'interface' },
      { 'display' => 'schedule' },
      { 'display' => 'suggest' },
      { 'display' => 'thickbox' },
      { 'display' => 'sack' },
      { 'display' => 'quicktags' },
      { 'display' => 'colorpicker' },
      { 'display' => 'tiny_mce' },
      { 'display' => 'prototype' },
      { 'display' => 'autosave' },
      { 'display' => 'wp-ajax-response' },
      { 'display' => 'wp-lists' },
      { 'display' => 'common' },
      { 'display' => 'editor' },
      { 'display' => 'editor-functions' },
      { 'display' => 'ajaxcat' },
      { 'display' => 'admin-categories' },
      { 'display' => 'admin-tags' },
      { 'display' => 'admin-custom-fields' },
      { 'display' => 'password-strength-meter' },
      { 'display' => 'admin-comments' },
      { 'display' => 'admin-users' },
      { 'display' => 'admin-forms' },
      { 'display' => 'xfn' },
      { 'display' => 'upload' },
      { 'display' => 'postbox' },
      { 'display' => 'slug' },
      { 'display' => 'post' },
      { 'display' => 'page' },
      { 'display' => 'link' },
      { 'display' => 'comment' },
      { 'display' => 'admin-gallery' },
      { 'display' => 'media-upload' },
      { 'display' => 'admin-widgets' },
      { 'display' => 'word-count' },
      { 'display' => 'wp-gears' },
      { 'display' => 'theme-preview' }
    ]
    TextMate::UI.complete(choices)
    
    script = "wp_enqueue_script('\${1}');\$0" 
    return script
  end
end
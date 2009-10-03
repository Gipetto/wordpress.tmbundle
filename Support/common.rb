require ENV['TM_SUPPORT_PATH'] + '/lib/ui'
require ENV['TM_SUPPORT_PATH'] + '/lib/osx/plist'
require ENV['TM_SUPPORT_PATH'] + '/lib/exit_codes'
require ENV['TM_SUPPORT_PATH'] + '/lib/current_word'

module WordPress
  def self.wpdb
    # manually built array until I can get proper function/class scraping
    choices = [
      { 'title' => 'categories' },
      { 'title' => 'comments' },
      { 'title' => 'escape', 'insert' => '(${1:var})' },
      { 'title' => 'get_col', 'insert' => '(${1:query},${2:x})' },
      { 'title' => 'get_results', 'insert' => '(${1:query},${2:output})' },
      { 'title' => 'get_row', 'insert' => '(${1:query},${2:output},${3:y})' },
      { 'title' => 'get_var', 'insert' => '(${1:query},${2:x},${3:y})' },
      { 'title' => 'hide_errors', 'insert' => '()' },
      { 'title' => 'insert', 'insert' => '(${1:table},${2:data})' },
      { 'title' => 'links' },
      { 'title' => 'options' },
      { 'title' => 'postmeta' },
      { 'title' => 'posts' },
      { 'title' => 'prefix' },
      { 'title' => 'prepare', 'insert' => '(${1:args})' },
      { 'title' => 'query', 'insert' => '(${1:query})' },
      { 'title' => 'show_errors', 'insert' => '(${1:bool})' },
      { 'title' => 'suppress_errors', 'insert' => '(${1:bool})' },
      { 'title' => 'terms' },
      { 'title' => 'term_relationships' },
      { 'title' => 'term_taxonomy' },
      { 'title' => 'update', 'insert' => '(${1:table},${2:data},${3:where})' },
      { 'title' => 'usermeta' },
      { 'title' => 'users' }
    ]
    t = TextMate::UI.menu(choices)
    
    if t == nil
      TextMate.exit_discard()
    end
    
    ret = "\\\$wpdb->" + t['title']
    if t['insert']
       ret += t['insert'] + ';'
     end
     ret += "$0"
    TextMate.exit_insert_snippet(ret)
  end
  
  def self.post_var
    choices = [
      { 'title' => 'ancestors' },
      { 'title' => 'comment_count' }, 
      { 'title' => 'comment_status' }, 
      { 'title' => 'guid' }, 
      { 'title' => 'ID' }, 
      { 'title' => 'menu_order' }, 
      { 'title' => 'pinged' }, 
      { 'title' => 'ping_status' }, 
      { 'title' => 'post_author' }, 
      { 'title' => 'post_category' }, 
      { 'title' => 'post_content' }, 
      { 'title' => 'post_content_filtered' }, 
      { 'title' => 'post_date' }, 
      { 'title' => 'post_date_gmt' }, 
      { 'title' => 'post_excerpt' }, 
      { 'title' => 'post_mime_type' }, 
      { 'title' => 'post_modified' }, 
      { 'title' => 'post_modified_gmt' }, 
      { 'title' => 'post_name' }, 
      { 'title' => 'post_parent' }, 
      { 'title' => 'post_password' }, 
      { 'title' => 'post_status' }, 
      { 'title' => 'post_title' }, 
      { 'title' => 'post_type' }, 
      { 'title' => 'to_ping' }, 
      { 'title' => 'view_count' }
    ]
    t = TextMate::UI.menu(choices)
    
    if t == nil
      TextMate.exit_discard()
    end
    
    post_var = "\\\$post->" + t['title'] + "$1"
    
    if ENV['TM_SCOPE'].include? 'source.php'
      TextMate.exit_insert_snippet(post_var)
    else
      TextMate.exit_insert_snippet('<?php echo ' + post_var + "; ?>$0")
    end
  end
  
  def self.wp_query
    choices = [
      { 'title' => 'comments' },
      { 'title' => 'comment_count' },
      { 'title' => 'current_post' },
      { 'title' => 'fill_query_vars', 'insert' => '(${1:array})' },
      { 'title' => 'found_posts' },
      { 'title' => 'get', 'insert' => '(${1:string query_var})' },
      { 'title' => 'get_posts', 'insert' => '()' },
      { 'title' => 'get_queried_object', 'insert' => '()' },
      { 'title' => 'get_queried_object_id', 'insert' => '()' },
      { 'title' => 'have_comments', 'insert' => '()' },
      { 'title' => 'have_posts', 'insert' => '()' },
      { 'title' => 'init', 'insert' => '()' },
      { 'title' => 'init_query_flags', 'insert' => '()' },
      { 'title' => 'in_the_loop' },
      { 'title' => 'max_num_comment_pages' },
      { 'title' => 'max_num_pages' },
      { 'title' => 'next_comment', 'insert' => '()' },
      { 'title' => 'next_post', 'insert' => '()' },
      { 'title' => 'parse_query', 'insert' => '(${1:string/array})' },
      { 'title' => 'parse_query_vars', 'insert' => '()' },
      { 'title' => 'posts' },
      { 'title' => 'post_count' },
      { 'title' => 'query', 'insert' => '(${1:string})' },
      { 'title' => 'query_vars', 'lookup' => 'qv' },
      { 'title' => 'request' },
      { 'title' => 'rewind_comments', 'insert' => '()' },
      { 'title' => 'rewind_posts', 'insert' => '()' },
      { 'title' => 'set', 'insert' => '(${1:string query_var},${2:mixed value})' },
      { 'title' => 'set_404', 'insert' => '()' },
      { 'title' => 'the_comment', 'insert' => '()' },
      { 'title' => 'the_post', 'insert' => '()' }

    ]
    
    t = TextMate::UI.menu(choices)
    
    if t == nil
      TextMate.exit_discard()
    end
    
    # functions
    ret = "\\\$wp_query->" + t['title']
    if t['insert']
      ret += t['insert'] + ';'
    end
    
    # query vars
    if t['lookup'] == 'qv'
      ret += self.query_var(true) + ';'
    end
      
    # is_* left out on purpose to encourage the use of the accessor functions
    
    ret += "$0"
    TextMate.exit_insert_snippet(ret)    
  end
  
  def self.wp_query_is
    
  end
  
  def self.query_var(format_array = false)
    choices = [
      { 'title' => 'attachment' },
      { 'title' => 'attachment_id' },
      { 'title' => 'author' },
      { 'title' => 'author_name' },
      { 'title' => 'cat' },
      { 'title' => 'category_name' },
      { 'title' => 'category__in' },
      { 'title' => 'category__not_in' },
      { 'title' => 'comments_popup' },
      { 'title' => 'day' },
      { 'title' => 'error' },
      { 'title' => 'feed' },
      { 'title' => 'hour' },
      { 'title' => 'm' },
      { 'title' => 'minute' },
      { 'title' => 'monthnum' },
      { 'title' => 'name' },
      { 'title' => 'p' },
      { 'title' => 'paged' },
      { 'title' => 'pagename' },
      { 'title' => 'page_id' },
      { 'title' => 'post_status' },
      { 'title' => 'post_type' },
      { 'title' => 'preview' },
      { 'title' => 'second' },
      { 'title' => 'tag' },
      { 'title' => 'tag_id' },
      { 'title' => 'tag__and' },
      { 'title' => 'tag__in' },
      { 'title' => 'tag__not_in' },
      { 'title' => 'tag__slug_and' },
      { 'title' => 'tag__slug_in' },
      { 'title' => 'taxonomy' },
      { 'title' => 'tb' },
      { 'title' => 'term' },
      { 'title' => 'w' },
      { 'title' => 'withcomments' },
      { 'title' => 'year' },  
    ]
    t = TextMate::UI.menu(choices)
    
    if t == nil
      TextMate.exit_discard()
    end
    
    if format_array == true
      # return a different format for self.wp_query
      return "['" + t['title'] + "']${1: = '${2:val}'}"
    else
      TextMate.exit_insert_snippet("'" + t['title'] + "' => ${1:'${2:val}'},$0")
    end
  end
  
  def self.admin_menu
    choices = [
      { 'title' => 'menu' },
      { 'title' => 'submenu' },
      { 'title' => 'utility' },
      { 'title' => 'object' }
    ]
    t = TextMate::UI.menu(choices)
    
    if t == nil
      TextMate.exit_discard()
    end
    
    if t['title'] == 'submenu'
      self.add_submenu
    else
      add_menu = "add_" + t['title'] + "_page('${1:page_title}','${2:menu_title}',${3:access_level},${4:basename(__FILE__)},'${5:icon_path}');$0"
      TextMate.exit_insert_snippet(add_menu)
    end
    
  end
  
  def self.add_submenu
    choices = [
      { 'title' => 'comments', 'insert' => 'edit-comments.php' },
      { 'title' => 'dashboard', 'insert' => 'index.php' },
      { 'title' => 'links', 'insert' => 'link-manager.php' },
      { 'title' => 'media', 'insert' => 'upload.php' },
      { 'title' => 'options', 'insert' => 'options-general.php' },
      { 'title' => 'pages', 'insert' => 'edit-pages.php' },
      { 'title' => 'posts', 'insert' => 'edit.php' },
      { 'title' => 'profile', 'insert' => 'profile.php' },
      { 'title' => 'tools', 'insert' => 'tools.php' },
      { 'title' => 'theme', 'insert' => 'themes.php' },
      { 'title' => 'users', 'insert' => 'users.php' },
      { 'title' => 'custom...', 'insert' => '${1:file}' }   
    ]
    t = TextMate::UI.menu(choices)
    
    if t == nil
      TextMate.exit_discard()
    end
    
    add_menu = "add_submenu_page('" + t['insert'] + "',__('${2:page_title}'),__('${3:menu_title}'),${4:access_level},${5:basename(__FILE__)},'${6:function}');$0"
    TextMate.exit_insert_snippet(add_menu)
  end
  
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
    if ENV['TM_SCOPE'].include? 'source.php'
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
    
    if t == nil
      TextMate.exit_discard()
    end
    
    ret = eval t['func_to_call']
    
    if ENV['TM_SCOPE'].include? 'source.php'
      TextMate.exit_insert_snippet(ret)
    else
      TextMate.exit_insert_snippet('<?php ' + ret + ' ?>')
    end
  end
  
  # enqueue a style
  def self.enqueue_style()
    style = "wp_enqueue_style('\${1:style_id}',get_bloginfo('template_directory').'\${2:/css/mystyle.css}',\${3:array('\${4:string dependency}')},\${5:float version},'\${6:string media}');\$0"    
    return style
  end
 
 # enqueue a script from the theme
 def self.enqueue_from_theme()
   script = "wp_enqueue_script('\${1:script_name}',get_bloginfo('template_directory').'\${2:/js/myscript.js}',\${3:array('\${4:string dependency}')},\${5:float version});\$0"
   return script
 end
  
 # enqueue a script from a plugin
 def self.enqueue_from_plugin()
   script = "wp_enqueue_script('\${1:string script_id}','/index.php?\${2:my_action}=\${3:action_handler}',\${4:array('\${5:string dependency}')},\${6:float version});\$0"
   return script
 end
  
  def self.function_define()
    choices = OSX::PropertyList.load(File.read(ENV['TM_BUNDLE_SUPPORT'] + '/function_defs.plist'))
    search = Word.current_word('a-zA-Z0-9_')
    found = choices.find { |i| i['name'] == search }
    
    if found.is_a?(Hash)
      ret = '<code style="font-size: 1.2em;">' + found['definition'] + '</code><br />' + found['file']
    else
      ret = 'Sorry, no definition found. Boo!';
    end
    
    style = "font-family: 'Lucida Grande', sans-serif;"
    
    TextMate::UI.tool_tip('<p style="' + style + '">' + ret + '</p>', :format => :html)
    exit
  end
  
  # set a user role
  def self.user_can()
    choices = [
      { 'display' => 'activate_plugins' },
      { 'display' => 'create_users' },
      { 'display' => 'delete_others_pages' },
      { 'display' => 'delete_others_posts' },
      { 'display' => 'delete_pages' },
      { 'display' => 'delete_plugins' },
      { 'display' => 'delete_posts' },
      { 'display' => 'delete_private_pages' },
      { 'display' => 'delete_private_posts' },
      { 'display' => 'delete_published_pages' },
      { 'display' => 'delete_published_posts' },
      { 'display' => 'delete_users' },
      { 'display' => 'edit_dashboard' },
      { 'display' => 'edit_files' },
      { 'display' => 'edit_others_pages' },
      { 'display' => 'edit_others_posts' },
      { 'display' => 'edit_pages' },
      { 'display' => 'edit_plugins' },
      { 'display' => 'edit_posts' },
      { 'display' => 'edit_private_pages' },
      { 'display' => 'edit_private_posts' },
      { 'display' => 'edit_published_pages' },
      { 'display' => 'edit_published_posts' },
      { 'display' => 'edit_themes' },
      { 'display' => 'edit_users' },
      { 'display' => 'import' },
      { 'display' => 'install_plugins' },
      { 'display' => 'install_themes' },
      { 'display' => 'manage_categories' },
      { 'display' => 'manage_links' },
      { 'display' => 'manage_options' },
      { 'display' => 'moderate_comments' },
      { 'display' => 'publish_pages' },
      { 'display' => 'publish_posts' },
      { 'display' => 'read' },
      { 'display' => 'read_private_pages' },
      { 'display' => 'read_private_posts' },
      { 'display' => 'switch_themes' },
      { 'display' => 'unfiltered_html' },
      { 'display' => 'unfiltered_upload' },
      { 'display' => 'update_plugins' },
      { 'display' => 'update_themes' },
      { 'display' => 'upload_files' }
    ]
    TextMate::UI.complete(choices)
    ret = "current_user_can('\${1}')\$0"
    TextMate.exit_insert_snippet(ret)    
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
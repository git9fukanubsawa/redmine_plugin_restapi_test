Redmine::Plugin.register :redmine_restapi do
  name 'Redmine Restapi plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  project_module :restapi do
    menu :top_menu, :restapi, { :controller => 'restapis', :action =>  'index'}
  end
end

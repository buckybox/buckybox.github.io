# XML sitemap
ENV["TZ"] = "UTC"
require "builder"
page "/sitemap.xml", layout: false

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
activate :livereload

# Methods defined in the helpers block are available in templates
helpers do
  def pages
    sitemap.resources.
      select { |page| page.path.end_with?(".html") }. \
      reject { |page| page.path =~ /\Agoogle[\da-f]+\.html\Z/ }. # google site verification
      reject { |page| %w(404.html).include?(page.path) }
  end
end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
  # activate :minify_html # FIXME

  # Enable cache buster
  activate :asset_hash, ignore: [
    /\Aimages\/(email|uservoice)\/.*\Z/, # hot-linked from the help pages
    /\Aimages\/logo-bucky-grey\.png\Z/, # hot-linked from the emails
    /\Afavicon\.gif\Z/, # hot-linked from the blog
    /\Afonts\/.*\Z/, # hard-coded in Bootstrap CSS files
    /\Aimages\/logo-buckybox\.png\Z/, # hot-linked from the blog
    /\Astylesheets\/all\.css\Z/, # hot-linked from the blog
  ]

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"

  set :relative_links, true
end

module Padrino::Helpers::AssetTagHelpers
  alias_method :old_image_tag, :image_tag

  def image_tag(url, options={})
    options[:alt] ||= url.gsub(/(.*)\.\w+\z/, "\\1").gsub(/\W/, " ").titleize
    old_image_tag(url, options)
  end
end

# class MyFeature < Middleman::Extension
#   def initialize(app, options_hash={}, &block)
#     super
#   end

#   helpers do
#     def make_a_link(url, text)
#       "<a href='#{url}'>#{text}</a>"
#     end
#   end
# end

# ::Middleman::Extensions.register(:my_feature, MyFeature)

# activate :my_feature


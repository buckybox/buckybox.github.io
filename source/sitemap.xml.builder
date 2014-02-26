xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
    pages.each do |page|
    xml.url do
      xml.loc "#{data.settings.site_url}#{page.url}"
      xml.lastmod File.new(page.source_file).mtime.iso8601 # NOTE: won't take into account changes in header/footer
    end
  end
end

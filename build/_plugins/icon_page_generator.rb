##
# Create individual pages for each icon in the FontAwesome set

require 'yaml'

module Jekyll

  class IconPage < Page

    ##
    # Take a single icon and render a page for it.

    def initialize(site, base, dir, icon)
      @site = site
      @base = base
      @dir = dir
      @name = "#{icon['id']}/index.html"
      @icon = icon

      self.process(@name)

      self.read_yaml(File.join(base, site.config['layouts']), site.config['icon_layout'])

      self.data['icon'] = icon
      self.data['title'] = "icon-#{icon['id']}: " + self.data['title_suffix']
    end

  end

  class IconGenerator < Generator

    ##
    # Iterate over every described icon in a YAML file and create a page for it

    safe true

    def generate(site)
      icon_meta_filename = site.config['icon_meta']
      icon_meta = YAML.load_file(icon_meta_filename)

      icon_meta['icons'].each do |icon|
        site.pages << IconPage.new(site, site.source, site.config['icon_destination'], icon)
      end
    end

  end

end

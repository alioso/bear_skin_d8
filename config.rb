#
# This file is only needed for Compass/Sass integration. If you are not using
# Compass, you may safely ignore or delete this file.
#
# If you'd like to learn more about Sass and Compass, see the sass/README.txt
# file for more information.
#

# Require any additional compass plugins installed on your system.
# Required for post processing in post-compile hook below:
require 'autoprefixer-rails'

# Required for sass compile
require 'sassy-buttons'
require 'breakpoint'
require 'rgbapng'
require 'compass-normalize'
require 'modernizr-mixin'


# Change this to :production when ready to deploy the CSS to the live server.
environment = :development
#environment = :production

# In development, we can turn on the FireSass-compatible debug_info.
#firesass = false
firesass = false
Sass::Plugin.options[:debug_info] = true

# Location of the theme's resources.
css_dir         = "assets/css"
sass_dir        = "assets/sass"
fonts_dir       = "assets/fonts"
extensions_dir  = "assets/sass/sass-extensions"
images_dir      = "assets/images"
javascripts_dir = "assets/js"

# Assuming this theme is in sites/*/themes/THEMENAME, you can add the partials
# included with a module by uncommenting and modifying one of the lines below:
#add_import_path "../../../default/modules/FOO"
#add_import_path "../../../all/modules/FOO"
#add_import_path "../../../../modules/FOO"


##
## You probably don't need to edit anything below this.
##

# You can select your preferred output style here (can be overridden via the command line):
# output_style = :expanded or :nested or :compact or :compressed
output_style = (environment == :development) ? :expanded : :compressed

# To enable relative paths to assets via compass helper functions. Since Drupal
# themes can be installed in multiple locations, we don't need to worry about
# the absolute path to the theme from the server root.
relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
# line_comments = false

# Pass options to sass. For development, we turn on the FireSass-compatible
# debug_info if the firesass config variable above is true.
# sass_options = (environment == :production) ? {} : {:debug_info => true}

# Enable sourcemaps for development
sourcemap = (environment == :production) ? false : true

# Run autoprefixer after compass compiles
# Using on_stylesheet_saved post-compile hook
on_stylesheet_saved do |file|
  css = File.read(file)
  map = file + '.map'

  if File.exists? map
    result = AutoprefixerRails.process(css,
      from: file,
      to:   file,
      map:  { prev: File.read(map), inline: false })
    File.open(file, 'w') { |io| io << result.css }
    File.open(map,  'w') { |io| io << result.map }
  else
    File.open(file, 'w') { |io| io << AutoprefixerRails.process(css) }
  end

  cssfile = File.basename file
  system( "echo 'Autoprefixer has processed " + cssfile + "'" )
end
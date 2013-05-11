# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register_alias "text/html", :iphone

#Mime::Type.register 'applicaton/x-gtar', :tarball, ['application/tar', 'application/x-tar'], ['.tar.gz', '.tgz']
Rack::Mime::MIME_TYPES.merge!('.tgz' => 'application/x-compressed-tar')

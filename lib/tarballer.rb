module Sprockets
  module Tarball
    
  end
  
  class TarballTemplate < Tilt::Template
    def self.engine_initialized?
      puts "ENGINE: is_init?"
      true
    end
    
    def initialize_engine
      puts "ENGINE: init"
    end

    def prepare
      puts "ENGINE: prepare"
    end
    
    def asset(path)
      asset = Rails.application.assets.find_asset(path)
      unless asset
        raise "Failed to find asset '#{path}' when constructing tarball '#{@context.logical_path}'"
      end

      File.write("#{@tmpdir}/#{path}", asset.body)
    end

    def evaluate(context, locals, &block)
      # We parse the file for include statements
      @context = context

      @tmpdir = Dir.mktmpdir("tarball")
      stuff = data.gsub(/^#.*/, '')
      eval stuff
      `cd #{@tmpdir}; tar -czf output.tgz *`
      return File.read "#{@tmpdir}/output.tgz"
    end
  end

  Rails.application.assets.register_engine '.hack', TarballTemplate
  #Rails.application.assets.register_preprocessor 'application/x-compressed-tar', DirectiveProcessor
  puts "ENGINE: register"
end


require 'optparse'

class White

  def self.run args
    extensions = %w/rb java xml md markdown coffee js eco html haml css less styl yml php info install module h m c txt/
    names = %w/Rakefile Cakefile/
    default_tab_size = nil
    tab_sizes = {
    }
    exclusions = ['**/.git/**', '**/node_modules/**/*']
    verbose = false
    dry_run = false

    opts = OptionParser.new do |opts|
      opts.banner = "Usage: white [options]"

      opts.separator ""
      opts.separator "Tab expansion:"

      opts.on("-t", "--tabsize=SIZE", "Expand tabs using the given tab size") do |size|
        default_tab_size = size.to_i
      end

      opts.separator ""
      opts.separator "Picking files to process:"

      opts.on("-e", "--ext=EXT", "Include files with the given extension (e.g. -e inc)") do |v|
        extensions << v
      end

      opts.on("-i", "--name=NAME", "Include files with the given name (e.g. -n Cakefile)") do |v|
        names << v
      end

      opts.separator ""
      opts.separator "Common options:"

      opts.on("-n", "--dry-run", "Don't actually change anything on disk") do
        dry_run = true
      end

      opts.on("-v", "--verbose", "Show a full list of processed files") do
        verbose = true
      end

      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end
    end

    opts.parse!(args)

    mask = "{" + (names + extensions.collect { |ext| "*.#{ext}" }).join(",") + "}"
    files = Dir["**/#{mask}"].to_a

    exclusions.each do |exclusion|
      files -= Dir[exclusion]
    end

    files_with_tabs = []

    files.each do |file|
      tab_size = tab_sizes[File.extname(file)] || default_tab_size
      tab = ' ' * tab_size if default_tab_size

      errors = []

      text = File.read(file)
      original = text.dup

      prev = text.dup
      text.gsub! /\r/, ''
      errors << "Windows line breaks" if text != prev

      prev = text.dup
      text.gsub! /[ \t]+$/, ''
      errors << "trailing whitespace" if text != prev

      if text =~ /^ *?\t[\t ]*/
        if default_tab_size == nil
          files_with_tabs << file unless files_with_tabs.include?(file)
        elsif default_tab_size > 0
          text.gsub!(/^ *?\t[\t ]*/) { |indent| indent.gsub "\t", tab }
          errors << "tabs"
        end
      end

      if text =~ /\t/
        if default_tab_size == nil
          files_with_tabs << file unless files_with_tabs.include?(file)
        elsif default_tab_size > 0
          text.gsub!("\t", tab)
          errors << "tabs inside source"
        end
      end

      if text != original
        puts "#{file} (#{errors.join(', ')})"
        File.open(file, 'w') { |f| f.write text } unless dry_run
      else
        puts "#{file} OK" if verbose
      end
    end

    unless files_with_tabs.empty?
      $stderr.puts "\nThe following file(s) contain tabs. To expand them, please use -t4 option."
      files_with_tabs.each { |f| $stderr.puts "  - #{f}" }
    end
  end

end

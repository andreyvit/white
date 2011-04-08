
class Whitespace

  def self.run args
    extensions = %w/rb java xml md coffee js html css less yml php info install module h m txt/
    names = %w/Rakefile Cakefile/
    default_tab_size = 2
    tab_sizes = {
      '.h' => 4,
      '.m' => 4,
      '.coffee' => 2,
    }
    exclusions = ['**/.git/**']

    mask = "{" + (names + extensions.collect { |ext| "*.#{ext}" }).join(",") + "}"
    files = Dir["**/#{mask}"].to_a

    exclusions.each do |exclusion|
      files -= Dir[exclusion]
    end

    files.each do |file|
      tab_size = tab_sizes[File.extname(file)] || default_tab_size
      tab = ' ' * tab_size

      errors = []

      text = File.read(file)
      original = text.dup

      prev = text.dup
      text.gsub! /[ \t]+$/, ''
      errors << "trailing whitespace" if text != prev

      prev = text.dup
      text.gsub!(/^ *?\t[\t ]*/) { |indent| indent.gsub "\t", tab }
      errors << "tabs" if text != prev

      prev = text.dup
      text.gsub!("\t", tab)
      errors << "tabs inside source" if text != prev

      if text != original
        puts "#{file} (#{errors.join(', ')})"
        File.open(file, 'w') { |f| f.write text }
      end
    end
  end

end

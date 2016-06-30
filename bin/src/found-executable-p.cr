require "file"

def main
  case
  when ARGV.size == 0
    show_help
    exit(2)
  when ARGV.size == 1 && ARGV[0] == "--help"
    show_help
  when ARGV.size == 1
    exit(find_executable(ARGV[0]) ? 0 : 1)
  else
    show_help(when_error = true)
    exit 3
  end
end

def show_help(when_error = false)
  help_text = <<-EOF
Usage: found-executable-p <file>

Exits with code 0 if the file is an executable and found in the PATH
environment variable and exits code 1 otherwise.
EOF
  if when_error
    STDERR.puts help_text
  else
    puts help_text
  end
end

def find_executable(name)
  paths = if ENV["PATH"].size != 0
	ENV["PATH"].split(":")
  else
	["/usr/local/bin", "/usr/bin", "/bin"]
  end

  paths.each do |path|
    full_path = File.join(path, name)
    return full_path if File.exists?(full_path) && File.executable?(full_path)
  end

  false
end


main

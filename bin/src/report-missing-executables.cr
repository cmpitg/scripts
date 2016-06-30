def main
  case
  when ARGV.size == 0
    show_help(when_error = true)
    exit 2
  when ARGV.size == 1 && ARGV[0] == "--help"
    show_help
  when ARGV.size % 2 != 0
    STDERR.puts "Invalid arguments.  Number of arguments must be even."
    exit 3
  else
    if report_missing_execs get_missing_execs(ARGV).to_a
      exit 0
    else
      exit 1
    end
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


def found_executable(name)
  find_executable(name) != false
end

def show_help(when_error = false)
  help_text = <<-EOF
Usage: report-missing-executables <file>

Reports missing software by checking if their corresponding executables exist.
If all executables are found, exit with status 0; otherwise, exit with status
1.

E.g.

  report-missing-executables aria2c Aria2 wget Wget
    # aria2c and wget not found
    # Make sure you have Aria2 and Wget installed

  report-missing-executables aria2c Aria2 wget Wget curl cURL
    # aria2c, curl, and wget not found
    # Make sure you have Aria2, Wget, and cURL installed

  report-missing-executables aria2c Aria2 wget
    # Invalid arguments.  Number of arguments must be even.
EOF
  if when_error
    STDERR.puts help_text
  else
    puts help_text
  end
end

#
# Gets missing executables from command line arguments.  The argument `args`
# is an array of strings of the following format: `<executable> <program>
# ...`.  This function returns the list of `{:executable, :program}` tuples
# where the corresponding executables are not found.
#
def get_missing_execs(args)
  (0..args.size - 1)
    .step(2)
    .map { |i| { executable: args[i], program: args[i + 1] } }
    .reject { |exec_prog| found_executable exec_prog[:executable] }
end

def print_missing_list(pre_msg, purpose_msg, missing, extractor)
  if missing.size == 1
    output = "#{extractor.call(missing[0])}"
  else
    before_last = butlast(missing).map(&extractor).join(", ")
    last        = extractor.call(last(missing))
    comma       = if missing.size > 2
                    ","
                  else
                    ""
                  end
    output      = "#{before_last}#{comma} and #{last}"
  end

  puts "#{pre_msg}#{output} #{purpose_msg}"
end

#
# Reports missing executables, returning `true` if there is at least one
# missing and `false` otherwise.
#
def report_missing_execs(missing_list)
  case missing_list.size
  when 0
    return false
  else
    print_missing_list(pre_msg = "",
                       purpose_msg = "not found",
                       missing = missing_list,
                       extractor = ->(exec_prog: NamedTuple(executable: String, program: String)) { exec_prog[:executable] })
    print_missing_list(pre_msg = "Make sure you have ",
                       purpose_msg = "installed",
                       missing = missing_list,
                       extractor = ->(exec_prog: NamedTuple(executable: String, program: String)) { exec_prog[:program] })
  end
  true
end

def last(array)
  array[-1]
end

def butlast(array)
  array[0..-2]
end

main

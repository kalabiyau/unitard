class Unitard < Thor

  RULE_NUM = 4242
  PIPE_NUM = 7777

  option :iface, :required => true, :type => :string
  option :bw,    :required => true, :type => :numeric

  desc 'zip', 'limit bandwidth on IFACE interface for bw Kbits/sec'
  def zip

    unzip(true)

    if system("sudo ipfw pipe #{PIPE_NUM} config bw #{options[:bw]}Kbit/s delay 30 plr 0 2>&1 > /dev/null") &&
        system("sudo ipfw add #{RULE_NUM} pipe #{PIPE_NUM} ip from any to any via #{options[:iface]} 2>&1 > /dev/null")
      say "speed throttled. Your skintight Unitard is ready. Really tight :) only #{options[:bw]} Kbit/sec", :green
    else
      say "error - exit status #{$?.exitstatus}", :red
    end

  end

  desc 'status', 'get status of the current limits'
  def status

    pipe_line = `sudo ipfw pipe show #{PIPE_NUM} 2>/dev/null`.split(/\n/).first
    iface_line = `sudo ipfw show #{RULE_NUM} 2>/dev/null`.split(/\n/).first

    if pipe_line && iface_line
      speed_limit = pipe_line.scan(/\d+\.\d+/).join
      iface = iface_line.scan(/^.*\s+([a-z]{2,3}\d+)$/).join
      say "Current limit is set to #{speed_limit} Kbits/sec via interface #{iface}", :green
    else
      say 'No matching rule found. Probably no limit was set by Unitard', :red
    end

  end

  desc 'unzip', 'remove bandwidth limits added by Unitard'
  def unzip(silent=false)
    `sudo ipfw pipe delete #{PIPE_NUM} 2>&1 > /dev/null` and `sudo ipfw delete #{RULE_NUM} 2>&1 > /dev/null`
    unless silent
      say 'Phew! That was very skintight Unitard.', :green
      say '...all created by Unitard rules are deleted.', :blue
    end
  end

end

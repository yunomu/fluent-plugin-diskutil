class Fluent::DiskUtilInput < Fluent::Input
  Fluent::Plugin.register_input("diskutil", self)

  config_param :tag, :string, :default => "diskutil"
  config_param :interval, :integer, :default => 5
  config_param :command, :string, :default => "/bin/df"

  def initialize
    super
  end

  def configure(conf)
    super
    @tick = @interval * 60
  end

  def start
    super
    @watcher = Thread.new(&method(:watch))
  end

  def shutdown
    super
    @watcher.terminate
    @watcher.join
  end

  private
  def df
    disks = `#{@command} -m`.split($/)
    disks.shift
    disks.map {|disk|
      d = disk.split(/ +/)
      ret = {}
      ret[:device] = d.shift
      ret[:total] = d.shift
      ret[:used] = d.shift
      ret[:available] = d.shift
      ret[:percent] = d.shift.delete('%')
      ret[:mount] = d.shift
      ret
    }
  end

  def watch
    while true
      Fluent::Engine.emit(@tag, Fluent::Engine.now, df)
      sleep @tick
    end
  end
end

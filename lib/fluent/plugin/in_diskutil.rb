class Fluent::DiskUtilInput < Fluent::Input
  Fluent::Plugin.register_input("diskutil", self)

  def initialize
    super
  end

  def configure(conf)
    super
  end

  def start
    super
  end

  def shutdown
    super
  end
end

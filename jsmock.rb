class JSMock
  def initialize(name, parent=nil)
    @name = name.to_s
    @parent = parent
  end

  def [](key)
    JSMock.new(key,self)
  end

  def method_missing(method_sym, *arguments, &block)
    JSMock.new(method_sym.to_s+"("+arguments.join(',')+")", self)
  end

  def to_s
    "<%= #{keyified_name} %>"
  end

  def keyified_name
    if(@parent.nil?)
      "#{@name}"
    else
      "#{@parent.keyified_name}.#{@name}"
    end
  end

  def inspect
    to_s
  end
end

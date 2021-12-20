# decorators.
class Component
    # @return [String]
    def operation
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
    
end

class CardDecorator < Component
    attr_accessor :component
  
    # @param [Component] component
    def initialize(component)
      @component = component
    end
  
    # The Decorator delegates all work to the wrapped component.
    def method_missing(m, *args, &block)
      puts "Method #{m.to_s} was missing, delegating to component"
      return @component.send(m.to_s, *args, &block) 
    end
    # How many methods do I need to explicitly reroute?
    def kind_of?(input)
      @component.kind_of?(input)
    end

    def ===(card)
      @component === card
    end

end


class AlterStatsDecorator < CardDecorator
    # Decorators may call parent implementation of the operation, instead of
    # calling the wrapped object directly. This approach simplifies extension of
    # decorator classes.
    def initialize(card, atkgain, defgain)

      super(card)
      @atkgain = atkgain
      @defgain = defgain
    end

    def atk
        @component.atk + @atkgain
    end

    def def
        @component.def + @defgain
    end
    
end

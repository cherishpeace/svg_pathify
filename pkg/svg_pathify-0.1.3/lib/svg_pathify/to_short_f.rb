unless Object.instance_methods.include? :to_short_f
  class ::Object

    def to_short_f( precision=4 )
      factor = 10 ** precision
      rnd = (to_f * factor).round.to_f / factor
      f, i = rnd, rnd.to_i
      f == i ? i : f
    end
    
  end
end

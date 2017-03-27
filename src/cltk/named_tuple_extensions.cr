struct NamedTuple
  def -(other : U) forall U
    minus_implmentation(other)
  end

  private def minus_implmentation(other : U) forall U
    {% begin %}
    NamedTuple.new(
      {% for key in (T.keys + U.keys).uniq %}
        {% if !U.keys.includes?(key) %}
          {{key}}: self[:{{key}}],
        {% end %}
      {% end %}
    )
    {% end %}
  end

  def merge(other : NamedTuple | Nil)
    if other.is_a? NamedTuple
      merge_implementation(other)
    else
      self
    end
  end

  private def merge_implementation(other : U) forall U
    {% begin %}
    NamedTuple.new(
      {% for key in (T.keys + U.keys).uniq %}
        {% if U.keys.includes?(key) %}
            {{key}}: other[:{{key}}],
        {% else %}
            {{key}}: self[:{{key}}],
        {% end %}
      {% end %}
    )
    {% end %}
  end
end

module Mautic
  class Field < Model
    def self.in(connection)
      Proxy.new(connection, endpoint, klass: name, data_name: "fields")
    end

    def to_mautic(data = @table)
      properties = data[:properties]

      if properties == []
        data.delete(:properties)
      elsif properties.is_a?(Hash)
        properties.each do |k, v|
          if v.is_a?(Array)
            data[:properties][k] = v.index_by.with_index { |_, i| i }
          end
        end
      end

      super(data)
    end
  end
end

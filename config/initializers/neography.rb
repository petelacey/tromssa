Neography.configure do |config|
  config.protocol       = "http://"
  config.server         = "localhost"
  config.port           = 7474
  config.directory      = ""  # prefix this path with '/' 
  config.cypher_path    = "/cypher"
  config.gremlin_path   = "/ext/GremlinPlugin/graphdb/execute_script"
  config.log_file       = "neography.log"
  config.log_enabled    = false
  config.max_threads    = 20
  config.authentication = nil  # 'basic' or 'digest'
  config.username       = nil
  config.password       = nil
  config.parser         = MultiJsonParser
end

class Neography::Rest
  
  def tromssa_query(query)
    resp = execute_query(query)
    return convert_response(resp)
  end

  def convert_response(resp)
    return [] if resp["data"].empty?

    rows = resp["data"]
    columns = resp["columns"]
    converted_rows = []

    template = Hash.new { |h, k| h[k] = [] }
    columns.each do |col|
      node, attr = col.split(".")
      template[node] << attr
    end

    rows.each do |row|
      converted_row = {}
      i = 0
      template.keys.each do |node|
        data = {}
        template[node].each do |label|
          data[label.to_sym] = row[i]
          i = i+1
        end
        converted_row[node.to_sym] = data
      end
      converted_rows << converted_row
    end
    converted_rows
  end
end

NEO = Neography::Rest.new


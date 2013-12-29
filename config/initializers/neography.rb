require 'httpclient/include_client'

module Tromssa
  class Neo
    extend HTTPClient::IncludeClient

    JSON_MIME = 'application/json'

    include_http_client(:method_name => :neo_client) do |client|
       client.set_cookie_store(nil)
       client.connect_timeout = 1
       client.send_timeout = 5
       client.receive_timeout = 30
       # client.debug_dev = STDOUT
    end

    def uri
      "http://localhost:7474/db/data/transaction/commit"
    end

    def cypher(query, params=nil)
      headers = { 'Content-Type' => JSON_MIME, 'Accept' => JSON_MIME }

      body = {
        statements: [ {
          statement: query
        } ]
      }
      body[:statements][0][:parameters] = params if params

      resp = neo_client.post(uri, body.to_json, headers)
      if resp.status_code == 200
        convert_response(JSON.parse(resp.body))
      else
        # Do appropriate thing
      end
    end

    private

    def convert_response(resp)
      resp = resp["results"].first
      return [] if resp["data"].empty?

      columns = resp["columns"]
      rows    = resp["data"]

      rows.map do |row|
        new_row = {}
        row["row"].each_with_index do |elem, i|
          new_row[columns[i]] = elem
        end
        new_row.with_indifferent_access
      end
    end

  end
end

NEO = Tromssa::Neo.new

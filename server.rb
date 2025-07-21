#!/usr/bin/env ruby
require 'webrick'
require 'jekyll'

# Parse the options from command-line
options = {}
options = Jekyll.configuration({})

# Create the server
server = WEBrick::HTTPServer.new(
  :Port => options['port'] || 4000,
  :DocumentRoot => options['destination'],
  :Logger => WEBrick::Log.new($stderr, WEBrick::Log::INFO)
)

# Add special handling for POST requests to /assets/csrf/
server.mount_proc '/assets/csrf' do |req, res|
  if req.request_method == 'POST'
    res.body = <<-HTML
    <!DOCTYPE html>
    <html>
    <head>
        <title>POST Request Information</title>
        <style>
            body { font-family: monospace; padding: 20px; background-color: #f5f5f5; }
            pre { background-color: #fff; padding: 15px; border-radius: 5px; border: 1px solid #ddd; overflow: auto; }
            h2 { color: #333; border-bottom: 1px solid #ddd; padding-bottom: 5px; }
        </style>
    </head>
    <body>
        <h2>POST Request Information</h2>
        
        <h3>URL Information</h3>
        <pre>#{req.request_uri}</pre>
        
        <h3>POST Data</h3>
        <pre>#{req.query.to_s}</pre>
        
        <h3>Headers</h3>
        <pre>#{req.header.map { |k, v| "#{k}: #{v}" }.join("\n")}</pre>
        
        <h3>Cookies</h3>
        <pre>#{req.cookies.map { |c| "#{c.name}=#{c.value}" }.join("\n")}</pre>
    </body>
    </html>
    HTML
    res.content_type = 'text/html'
  else
    # For GET requests, serve the normal Jekyll content
    file_path = File.join(options['destination'], 'assets/csrf/index.html')
    if File.exist?(file_path)
      res.body = File.read(file_path)
      res.content_type = 'text/html'
    else
      res.status = 404
      res.body = '404 - Not Found'
    end
  end
end

# Start the server
['INT', 'TERM'].each do |signal|
  trap(signal) { server.shutdown }
end

server.start

require_relative './middleware/time_format'

class App

  HEADERS = { 'Content-Type' => 'text/plain' }

  def call(env)
    @request = Rack::Request.new(env)

    if @request.path_info == '/time'
      process_time
    else
      http_response(404, 'Not Found')
    end
  end

  private

  def process_time
    response = TimeFormat.new(@request.params['format'].split(','))
    time = response.format_time

    if response.incorrect_format.empty?
      http_response(200, time)
    else
      http_response(400, "Unknown time format #{response.incorrect_format}")
    end
  end

  def http_response(status, body)
    Rack::Response.new(body, status, HEADERS).finish
  end
end

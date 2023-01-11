class TimeFormat

  attr_reader :incorrect_format

  FORMATS = { 'year' => '%Y', 'month' => '%m', 'day' => '%d',
              'hour' => '%H', 'minute' => '%M', 'second' => '%S' }

  def initialize(params)
    @params = params
    @correct_format = []
    @incorrect_format = []
  end

  def format_time
    check_format
    Time.now.strftime(@correct_format.join('-'))
  end

  private

  def check_format
    @params.each do |f|
      if FORMATS[f]
        @correct_format << FORMATS[f]
      else
        @incorrect_format << f
      end
    end
  end
end
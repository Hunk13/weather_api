require "opentelemetry/sdk"

class PerformanceMonitor
  def initialize
    @tracer = OpenTelemetry.tracer_provider.tracer("weather-api", "0.1.0")
  end

  def track_request
    @tracer.in_span("request-tracking") do |span|
      start_time = Time.now
      yield
      end_time = Time.now

      span.set_attribute("start_time", start_time.to_s)
      span.set_attribute("end_time", end_time.to_s)
      span.set_attribute("duration", (end_time - start_time).to_s)
    end
  end
end

require_relative 'helper'

class TestHistogramLine < Minitest::Test
  # NOTE: Testing strategy here is to sample each of the line types output by
  # command, and test methods for each of those lines.

  def instance(raw)
    CPULatencyForwarder::HistogramLine.new(raw)
  end

  def test_attaching_line
    # We want to ignore this line.
    raw = "Attaching 6 probes...\n"
    line = instance(raw)

    refute line.has_data?
    assert_nil line.lower_bound
    assert_nil line.value
  end

  def test_tracing_line
    # We want to ignore this line.
    raw = "Tracing CPU scheduler... Hit Ctrl-C to end.\n"
    line = instance(raw)

    refute line.has_data?
    assert_nil line.lower_bound
    assert_nil line.value
  end

  def test_usecs_line
    # We want to ignore this line.
    raw = "@usecs: \n"
    line = instance(raw)

    refute line.has_data?
    assert_nil line.lower_bound
    assert_nil line.value
  end

  # "[2, 4)                 1 |@@@@@@                                              |\n"
  # "[4, 8)                 2 |@@@@@@@@@@@@@                                       |\n"
  # "[8, 16)                8 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|\n"
  # "[16, 32)               4 |@@@@@@@@@@@@@@@@@@@@@@@@@@                          |\n"
  
  def test_data_lines
    raw = "[1]                    2 |@@@@@@@@@@@@@                                       |\n"
    line = instance(raw)
    assert_equal 1, line.lower_bound
    assert_equal 2, line.value
    assert line.has_data?

    raw = "[2, 4)                 1 |@@@@@@                                              |\n"
    line = instance(raw)
    assert_equal 2, line.lower_bound
    assert_equal 1, line.value
    assert line.has_data?

    raw = "[4, 8)                 2 |@@@@@@@@@@@@@                                       |\n"
    line = instance(raw)
    assert_equal 4, line.lower_bound
    assert_equal 2, line.value
    assert line.has_data?

    raw = "[8, 16)                8 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|\n"
    line = instance(raw)
    assert_equal 8, line.lower_bound
    assert_equal 8, line.value
    assert line.has_data?

    raw = "[16, 32)               4 |@@@@@@@@@@@@@@@@@@@@@@@@@@                          |\n"
    line = instance(raw)
    assert_equal 16, line.lower_bound
    assert_equal 4, line.value
    assert line.has_data?
  end

end


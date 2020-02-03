require_relative 'helper'

class TestSampleStore < Minitest::Test

  def new_store
    CPULatencyForwarder::SampleStore.new('somehost.wherever', 1234)
  end

  def test_inital_state_is_empty
    store = new_store

    assert store.empty?
    assert_equal({}, store.samples)
  end

  def test_adding_new_sample
    store = new_store

    store.record_sample(:a, 123)
    assert_equal({ a: 123 }, store.samples)

    store.record_sample(:b, 456)
    assert_equal({ a: 123, b: 456 }, store.samples)

    store.record_sample(:b, 789)
    assert_equal({ a: 123, b: 789 }, store.samples)
  end


  def test_clearing_the_store
    store = new_store

    store.record_sample(:a, 123)
    assert_equal({ a: 123 }, store.samples)

    store.clear!
    assert store.empty?
  end

  def test_flushing_samples_to_graphite
    store = new_store
    store.record_sample(8, 123)
    store.record_sample(16, 456)

    expected_hostname = Socket.gethostname
    expected_time     = Time.now

    Time.expects(:now).twice.returns(expected_time)

    mock_socket = mock
    TCPSocket.expects(:open).with('somehost.wherever', 1234).returns(mock_socket)
    mock_socket.expects(:write).with("#{expected_hostname}.cpu-lat.8 123 #{expected_time.to_i}\n") 
    mock_socket.expects(:write).with("#{expected_hostname}.cpu-lat.16 456 #{expected_time.to_i}\n") 
    mock_socket.expects(:close)

    store.flush!

    assert store.empty?
  end

end

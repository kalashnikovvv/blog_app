module StubAuthorization
  def stub_authorize
    allow(controller).to receive(:authorize).and_return(true)
  end
end

get "/" do
  """
  Visit http://kmonitor.herokuapp.com/progress/USERNAME to track your record.
  It updates once every 24 hours.
  """
end

get "/progress/:username" do |username|
  redirect to "/" if username.nil?

  @u = User.find_by(name: username)
  if @u.nil?
    begin
      doc = User.fetch_page(username)
      @u = User.create(name: username)
      User.store_kattis_data(@u, doc)
    rescue StandardError => e
      return "Invalid username!"
    end
  end
  erb :index
end

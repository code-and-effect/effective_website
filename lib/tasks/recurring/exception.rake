task :test_exception => :environment do
  begin
    raise 'this is an intentional exception'
  rescue => e
    ExceptionNotifier.notify_exception(e)
  end
end

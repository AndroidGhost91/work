
desc "Delete all junk notification "
task "remove_all_junk_notification" => :environment do
  Notification.where(description: nil).destroy_all
end

atom_feed :language => 'en-US' do |feed|
  feed.title 'Banjaxed incidents'
  feed.updated @updated

  @incidents.each do |item|
    next if item.updated_at.blank?

    feed.entry( item ) do |entry|

      entry.title item.title + ' | ' + item.severity + ' | ' + item.status
      entry.content item.description, :type => 'html'

      entry.author do |author|
        author.name incident_user_name(item)
      end
    end
  end
end

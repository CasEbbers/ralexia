$bartenders = $('#bartenders_event_<%= @event.id %> span')
$bartenders.text '<%= @event.enrollments.available.map{ |e| e.user.first_name }.join(', ') %>'
$bartenders.fadeIn()

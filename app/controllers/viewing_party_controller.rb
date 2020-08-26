class ViewingPartyController < BaseController
  def new
    movie = SearchResults.movie_details(params[:movie_id])
    viewing_party = ViewingParty.new
    @form_params = {viewing_party: viewing_party, movie: movie}
  end

  def create
    new_party = Party.create({
      title: params[:title],
      party_date: params[:party_date],
      party_time: params[:party_time],
      attendees: params[:friend_id].values,
      user_id: current_user.id
      }
    )
    if new_party.save
      flash[:success] = "Your party for #{params[:title]} on #{params[:party_date]} at #{params[:party_time]} was created"
      redirect_to dashboard_path
      # post_to_calendar
      CalendarService.create_viewing_party(new_party)
    end
  end
end

class CalendarService
  def self.create_viewing_party(event)
    calendar = Google::Apis::CalendarV3
    client = calendar::CalendarService.new
    client.authorization = access_token

    viewing_party = Google::Apis::CalendarV3::Event.new(
      summary: 'Viewing Party With Friends',
      location: 'Internet',
      description: event.title,
      start: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: event.start_time,
        time_zone: 'America/Denver'
      ),
      end: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: event.end_time,
        time_zone: 'America/Denver'
      )
    )
    client.insert_event('primary', viewing_party)
  end
end

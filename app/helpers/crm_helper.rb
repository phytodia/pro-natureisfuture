module CrmHelper

  def get_places_results(url, params)
    results = []

    loop do
      response = HTTParty.get(url, query: params)
      data = response.parsed_response

      # Vérifiez si la requête a réussi
      if response.code == 200
        results.concat(data.fetch('results', []))

        # Vérifiez s'il y a une page suivante
        if data.key?('next_page_token')
          # Attendez quelques secondes pour que la page suivante soit disponible
          sleep(2)

          # Utilisez le token de page pour obtenir les résultats de la page suivante
          params[:pagetoken] = data['next_page_token']
        else
          # Pas de page suivante, sortie de la boucle
          break
        end
      else
        puts "Erreur de requête: #{response.code}"
        puts response.body
        break
      end
    end

    results
  end

  base_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"

  # Définissez vos paramètres communs

  params = {
    location: @prospect_coord.compact.join(', '),
    radius: 20000,
    type: 'beauty_salon',
    key: ENV["GOOGLE_MAP_API"]
  }

  # Obtenez les résultats pour toutes les pages
  @all_results = get_places_results(base_url, params)

  # Traitez les résultats
  @all_results.each do |place|
    puts "#{place['name']} - #{place['vicinity']} - status : #{place["business_status"]} - lat: #{place['geometry']['location']['lat']} - lng: #{place['geometry']['location']['lng']}, cat: #{place['types']}, rating_number: #{place['user_ratings_total']}, note: #{place['rating']}"
  end


  @markers_conc = @all_results

  @markers = @markers_conc.map do |flat|
    {
      lat: flat["geometry"]["location"]["lat"],
      lng: flat["geometry"]["location"]["lng"],
      info_window_html: render_to_string(partial: "info_window", locals: {flat: flat}),
      marker_html: render_to_string(partial: "marker")
    }
  end
end

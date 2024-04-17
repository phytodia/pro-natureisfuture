module CrmHelper

  def get_places_results(url, params)
    results = []

    loop do
      response = HTTParty.get(url, query: params)
      data = response.parsed_response
      puts data

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
        puts "Erreur de requête !!!: #{response.code}"
        puts response.body
        break
      end
    end

    results
  end

  def get_prospects(coordinates,radius,cat)

    base_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
    # Définissez vos paramètres communs
    params = {
      location: coordinates,
      radius: radius,
      type: cat,
      key: ENV["GOOGLE_MAP_API"]
    }
    # Obtenez les résultats pour toutes les pages
    @all_results = get_places_results(base_url, params)
    #results = []
    datas_prospects = []
    @all_results.each do |place|
      datas_prospects << [
        "name" => place['name'],
        "address" => place['vicinity'],
        "status"=>place["business_status"],
        "lat" =>place['geometry']['location']['lat'],
        "lng"=>place['geometry']['location']['lng'],
        "categories"=>place['types'],
        "rating_number"=>place['user_ratings_total'],
        "note"=>place['rating']
      ]
      #puts "#{place['name']} - #{place['vicinity']} - status : #{place["business_status"]} - lat: #{place['geometry']['location']['lat']} - lng: #{place['geometry']['location']['lng']}, cat: #{place['types']}, rating_number: #{place['user_ratings_total']}, note: #{place['rating']}"
    end
    return datas_prospects
    #return results

    # Traitez les résultats
    #@all_results.each do |place|
    #  puts "#{place['name']} - #{place['vicinity']} - status : #{place["business_status"]} - lat: #{place['geometry']['location']['lat']} - lng: #{place['geometry']['location']['lng']}, cat: #{place['types']}, rating_number: #{place['user_ratings_total']}, note: #{place['rating']}"
    #end

  end

  #base_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"

  # Définissez vos paramètres communs


  # Obtenez les résultats pour toutes les pages

  #@all_results = get_places_results(params)

  # Traitez les résultats

  #@all_results.each do |place|
  #  puts "#{place['name']} - #{place['vicinity']} - status : #{place["business_status"]} - lat: #{place['geometry']['location']['lat']} - lng: #{place['geometry']['location']['lng']}, cat: #{place['types']}, rating_number: #{place['user_ratings_total']}, note: #{place['rating']}"
  #end

  def test
    puts "Bonjour"
  end
end

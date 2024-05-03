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
        "note"=>place['rating'],
        "place_id"=>place["place_id"]
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

  def get_more_details(place_id)
    key_api =  ENV["GOOGLE_MAP_API"]
    if place_id.present?
      place_id = place_id

      response = HTTParty.get("https://maps.googleapis.com/maps/api/place/details/json?placeid=#{place_id}&key=#{key_api}")

      details = {
        "ville" =>"",
        "cp"=>"",
        "country"=>"",
        "horaires"=>"",
        "tel"=>"",
        "website"=>""
      }
      data = response.parsed_response

      details["ville"] = data["result"]["address_components"].select { |element| element["types"].include?("locality")}[0]["long_name"]
      details["cp"] = data["result"]["address_components"].select { |element| element["types"].include?("postal_code")}[0]["long_name"]
      details["country"] = data["result"]["address_components"].select { |element| element["types"].include?("country")}[0]["long_name"]

      details["horaires"] = data["result"]["opening_hours"]["weekday_text"] if !data["result"]["opening_hours"].nil?
      details["tel"] = data["result"]["international_phone_number"] if !data["result"]["international_phone_number"].nil?
      details["website"] = data["result"]["website"] if !data["result"]["website"].nil?

      return details
      #@rating = data["result"]["rating"]
      #@reviews = data["result"]["reviews"]
    end
  end

  def get_horaires(place_id)
    key_api =  ENV["GOOGLE_MAP_API"]
    if place_id.present?
      place_id = place_id
      response = HTTParty.get("https://maps.googleapis.com/maps/api/place/details/json?placeid=#{place_id}&key=#{key_api}")
      details = {
        "horaires"=>"",
        "tel"=>"",
        "website"=>""
      }
      data = response.parsed_response

      details["horaires"] = data["result"]["opening_hours"]["weekday_text"] if !data["result"]["opening_hours"].nil?
      details["tel"] = data["result"]["international_phone_number"] if !data["result"]["international_phone_number"].nil?
      details["website"] = data["result"]["website"] if !data["result"]["website"].nil?
      return details
    end
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

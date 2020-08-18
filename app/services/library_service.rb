class LibraryService

    def get_results(query)
        append = ""
        query.each do |k,v|
            if v != nil && v != ""
                append << "#{k}=#{URI.encode(v)}&" 
            end
        end
        search_parameters = append.chop
        response = HTTP.get("https://api.lib.harvard.edu/v2/items.json?#{search_parameters}")
        parsed_response = JSON.parse(response)
        if parsed_response["items"] != nil
            parsed_response["items"]["mods"]
        else
            nil
        end
    end
    
    def get_text_by_title(title)
        response = HTTP.get("https://api.lib.harvard.edu/v2/items.json?title=#{title}")
        parsed_response = JSON.parse(response)
        search_results = parsed_response["items"]["mods"]
        text_hash = search_results.first
        get_title(text_hash)
     end

    def get_text_by_subtitle(title)
        response = HTTP.get("https://api.lib.harvard.edu/v2/items.json?title=#{title}")
        parsed_response = JSON.parse(response)
        search_results = parsed_response["items"]["mods"]
        text_hash = search_results.first
        get_title(text_hash)
        get_subtitle(text_hash)
    end

    def get_title(text_hash)
        if text_hash["titleInfo"].class == Hash
            if text_hash["titleInfo"]["nonSort"]
                "#{text_hash["titleInfo"]["nonSort"].strip} #{text_hash["titleInfo"]["title"]}"
            else
                text_hash["titleInfo"]["title"]
            end
        else
            if text_hash["titleInfo"].first["nonSort"]
                "#{text_hash["titleInfo"].first["nonSort"].strip} #{text_hash["titleInfo"].first["title"]}"
            else
                text_hash["titleInfo"].first["title"]
            end
        end 
    end

    def get_subtitle(text_hash)
        if text_hash["titleInfo"].class == Hash
            if text_hash["titleInfo"]["subTitle"]
                text_hash["titleInfo"]["subTitle"]
            else
                nil
            end
        else
            if text_hash["titleInfo"].first["subTitle"]
                text_hash["titleInfo"].first["subTitle"]
            else
                nil
            end
        end 
    end

    def get_author(text_hash)

    end

    # def get_

end
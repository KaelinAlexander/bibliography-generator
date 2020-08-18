module ApplicationHelper

    def current_user
        if session.include? :username
            session[:username]
        else
            nil
        end
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

    def logged_in
        !!session[:user_id]
    end

    def not_logged_in
        !!!session[:user_id]
    end

end

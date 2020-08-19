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

    def get_authors(text_hash)
        authors = []
        if text_hash["name"]
            if text_hash["name"].class == Hash
                if text_hash["name"]["namePart"].class == String
                    authors << text_hash["name"]["namePart"]
                else
                    authors << text_hash["name"]["namePart"][0]
                end
            else
                text_hash["name"].each do |author|
                    if author["namePart"].class == String
                        authors << author["namePart"] unless author["@type"] != "personal"
                    else
                        authors << author["namePart"][0] unless author["@type"] != "personal"
                    end
                end
            end
        else
            authors << "No author."
        end
        if authors == []
            authors << "No author."
        end
        authors
    end

    def edited?(text_hash)
        check_hash = {}
        if text_hash["note"] && text_hash["note"].class != String
            text_hash["note"].each do |h|
                if h.class == Hash
                    h.each do |k, v|
                        check_hash[k] = v if v.include?("edited")
                    end
                else
                    false
                end
            end
            if check_hash.empty?
                false
            else
                true
            end
        else
            false
        end
    end

    def get_editors(text_hash)
        # edited?(text_hash)
        #     check_hash
        #     byebug
        # else 
        #     nil
        # end

        # if text_hash["note"]
          check_hash = ""
            text_hash["note"].each do |h|
                if h.class == Hash
                    h.each do |k, v|
                        if v.include?("edited")
                            check_hash = v
                        else
                            nil
                        end
                    end
                end
            end
        check_hash.gsub("edited by", "").chop
    end

    def author_cleanup(author_array)
        if author_array != ["No author."]
            string_authors = ""
            no_period = []
            author_array.each do |author|
                if author[-1] == "."
                    author = author.chop
                    a = author.split(", ")
                else
                    a = author.split(", ")
                end
                a[0], a[1] = a[1], a[0]
                full_name = a.join(" ")
                string_authors << "#{full_name}, "
            end
            chopped = string_authors.chop.chop
        else
            chopped = "No author."
        end
    end


    def logged_in
        !!session[:user_id]
    end

    def not_logged_in
        !!!session[:user_id]
    end

end

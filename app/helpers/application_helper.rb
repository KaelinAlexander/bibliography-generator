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

    # def get_editors(text_hash)
    #       check_hash = ""
    #         text_hash["note"].each do |h|
    #             if h.class == Hash
    #                 h.each do |k, v|
    #                     if v.include?("edited")
    #                         check_hash = v
    #                     else
    #                         nil
    #                     end
    #                 end
    #             end
    #         end
    #     check_hash.gsub("edited by", "").chop
    # end

    def get_editors(text_hash)
        editors = []
        if text_hash["name"].class == Array
                text_hash["name"].each do |name|
                    if name["role"] && name["role"].class == Hash && name["role"]["roleTerm"] && name["role"]["roleTerm"]["#text"] && name["role"]["roleTerm"]["#text"] == "ed."
                        editors << name["namePart"]
                    elsif name["role"] && name["role"].class == Hash && name["role"]["roleTerm"] && name["role"]["roleTerm"]["#text"] && name["role"]["roleTerm"]["#text"] == "editor."
                        editors << name["namePart"]
                    elsif name["role"] && name["role"].class == Array
                        name["role"].each do |role|
                            if role["roleTerm"]["#text"] && role["roleTerm"]["#text"] == "ed."
                                editors << name["namePart"]
                            elsif role["roleTerm"]["#text"] && role["roleTerm"]["#text"] == "editor."
                                editors << name["namePart"]
                            else
                                nil
                            end
                        end
                    end
                end
        else
            editors << "No editor(s)."
        end
        editors
    end
    
    def get_publisher(text_hash)
        if text_hash["originInfo"]
            if text_hash["originInfo"].class == Hash
                text_hash["originInfo"]["publisher"]
            else
                text_hash["originInfo"][0]["publisher"]
            end
        else
            "No publisher listed."
        end
    end

    def get_pub_year(text_hash)
        if text_hash["originInfo"]
            if text_hash["originInfo"].class == Hash
                if text_hash["originInfo"]["dateIssued"]
                    if text_hash["originInfo"]["dateIssued"].class == String
                        pd = text_hash["originInfo"]["dateIssued"]
                    elsif text_hash["originInfo"]["dateIssued"].class == Array
                        pd = text_hash["originInfo"]["dateIssued"][0]
                    else
                        pd = text_hash["originInfo"]["dateIssued"]["#text"]
                    end
                else
                    pd = "No date listed"
                end
            else
                if text_hash["originInfo"][0]["dateIssued"]
                    if text_hash["originInfo"][0]["dateIssued"].class == String
                        pd = text_hash["originInfo"][0]["dateIssued"]
                    elsif text_hash["originInfo"][0]["dateIssued"].class == Array
                        pd = text_hash["originInfo"][0]["dateIssued"][0]
                    else
                        pd = text_hash["originInfo"][0]["dateIssued"]["#text"]
                    end
                else
                    pd = "No date listed."
                end
            end
        else
            pd = "No date listed"
        end
        if pd.class == Hash
            pd = pd["#text"]
        end
        pd
    end

    # def get_pub_city(text_hash)
    #     if text_hash["originInfo"]
    #         if text_hash["originInfo"].class == Hash
    #             if text_hash["originInfo"]["place"].class == Hash
    #                 text_hash["originInfo"]["place"]["placeTerm"]["#text"]
    #             elsif text_hash["originInfo"]["place"].class == Array

    #         elsif text_hash["originInfo"].class == Array
        
    #         end
    #     else
    #         "No city listed."
    #     end
    # end

    def author_cleanup(authors_array)
        if authors_array != ["No author."]
            string_authors = ""
            no_period = []
            authors_array.each do |author|
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

    def get_authors_full_names(authors_array)
        authors_full_names = []
            authors_array.each do |author|
            name = {}
                if author[-1] == "."
                    author = author.chop
                    a = author.split(", ")
                else
                    a = author.split(", ")
                end
                    name[:first_name] = a[1]
                    name[:last_name] = a[0]
                    name[:author_type] = "author"
            authors_full_names << name
            end
        authors_full_names
    end

    def logged_in
        !!session[:user_id]
    end

    def not_logged_in
        !!!session[:user_id]
    end

end

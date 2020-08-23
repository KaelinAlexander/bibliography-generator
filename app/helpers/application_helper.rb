module ApplicationHelper

    def current_user
        if session.include? :username
            session[:username]
        else
            nil
        end
    end

    def current_bibliographies
        @user = User.find(session[:user_id])
        @user.bibliographies
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
        editors = []
        if text_hash["name"].class == Array
                text_hash["name"].each do |name|
                    if name["role"] && name["role"].class == Hash && name["role"]["roleTerm"] && name["role"]["roleTerm"]["#text"] && name["role"]["roleTerm"]["#text"] == "ed."
                        if name["namePart"].class == Array
                            editors << name["namePart"][0]
                        else
                            editors << name["namePart"]
                        end
                    elsif name["role"] && name["role"].class == Hash && name["role"]["roleTerm"] && name["role"]["roleTerm"]["#text"] && name["role"]["roleTerm"]["#text"] == "editor."
                        if name["namePart"].class == Array
                            editors << name["namePart"][0]
                        else
                            editors << name["namePart"]
                        end
                    elsif name["role"] && name["role"].class == Array
                        name["role"].each do |role|
                            if role["roleTerm"]["#text"] && role["roleTerm"]["#text"] == "ed."
                                if name["namePart"].class == Array
                                    editors << name["namePart"][0]
                                else
                                    editors << name["namePart"]
                                end
                            elsif role["roleTerm"]["#text"] && role["roleTerm"]["#text"] == "editor."
                                if name["namePart"].class == Array
                                    editors << name["namePart"][0]
                                else
                                    editors << name["namePart"]
                                end
                            else
                                nil
                            end
                        end
                    end
                end
        else
            editors << "No editor(s)."
        end
        editors.uniq
    end
    
    def get_publisher(text_hash)
        if text_hash["originInfo"]
            if text_hash["originInfo"].class == Hash
                publisher = text_hash["originInfo"]["publisher"]
            else
                publisher = text_hash["originInfo"][0]["publisher"]
            end
        else
            publisher = "No publisher listed."
        end
        if publisher.class == Array
            publisher = publisher[0]
        end
        publisher
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

    def new_authors(authors_array, editors_array)
        just_authors = authors_array.sort - editors_array.sort
        if just_authors == []
            just_authors = ["No author."]
        end
        just_authors
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

    def creator_cleanup(authors_array)
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

    def get_creators_full_names(creators_array)
        authors_full_names = []
            creators_array.each do |author|
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

    def mla_cmos_authors(creators)
        authors = creators.select {|author| author.author_type == "author"}
        new_authors = ""
        if authors.count == 1
            new_authors << "#{authors[0].last_name}, #{authors[0].first_name}."
        elsif authors.count == 2
            new_authors << "#{authors[0].last_name}, #{authors[0].first_name} and #{authors[1].first_name} #{authors[1].last_name}."
        else
            authors.each do |author|
                if authors.index(author) == 0
                    new_authors << "#{author.last_name}, #{author.first_name},"
                elsif author == authors.last
                    new_authors << " and #{author.first_name} #{author.last_name}."
                else
                    new_authors << " #{author.first_name} #{author.last_name},"
                end
            end
        end
    new_authors
    end

    def authors?(creators)
        authors = creators.select {|author| author.author_type == "author"}
        if authors.count > 0
            true
        else
            false
        end
    end

    def editors?(creators)
        editors = creators.select {|author| author.author_type == "editor"}
        if editors.count > 0
            true
        else
            false
        end
    end
    
    def mla_cmos_title(title)
        "#{title.titlecase}"
    end

    def mla_editors(creators)
        editors = creators.select {|author| author.author_type == "editor"}
        new_editors = ". Edited by "
        if editors.count == 1
            new_editors << "#{editors[0].first_name} #{editors[0].last_name},"
        elsif editors.count == 2
            new_editors << "#{editors[0].first_name} #{editors[0].last_name} and #{editors[1].first_name} #{editors[1].last_name},"
        else
            editors.each do |editor|
                if editors.index(editor) == 0
                    new_editors << "#{editor.last_name}, #{editor.first_name},"
                elsif author == authors.last
                    new_editors << " and #{editor.first_name} #{editor.last_name},"
                else
                    new_editors << " #{editor.first_name} #{editor.last_name},"
                end
            end
        end
    end

    def cmos_editors(creators)
        editors = creators.select {|author| author.author_type == "editor"}
        new_editors = ", edited by "
        if editors.count == 1
            new_editors << "#{editors[0].first_name} #{editors[0].last_name}."
        elsif editors.count == 2
            new_editors << "#{editors[0].first_name} #{editors[0].last_name} and #{editors[1].first_name} #{editors[1].last_name}."
        else
            editors.each do |editor|
                if editors.index(editor) == 0
                    new_editors << "#{editor.last_name}, #{editor.first_name},"
                elsif author == authors.last
                    new_editors << " and #{editor.first_name} #{editor.last_name}."
                else
                    new_editors << " #{editor.first_name} #{editor.last_name},"
                end
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

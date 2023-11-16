require "google_drive"

# Creates a session. This will prompt the credential via command line for the
# first time and save it to config.json file for later usages.
# See this document to learn how to create config.json:
# https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md
session = GoogleDrive::Session.from_config("config.json")

ws = session.spreadsheet_by_key("1enAdFM-etdTaXBbNF_TkgeUBDJrSRzNTxShOLRt2mqg").worksheets[0]

# Gets content of A2 cell.
# p ws[3, 2]  #==> "hoge"
# p ws.rows

# def ispisiVrednosti(ws)
#     p ws.rows
# end
def add_method(c,m, &b)
	c.class_eval{
		define_method(m, &b)
	}
end


class GoogleDrive::Worksheet
    include Enumerable




    def row(x)
        a = []
        return null  if (self[x,1].downcase == "total") || (self[x,1].downcase == "subtotal" || self[x,1] == "")
        (1..num_cols).each do |p|
            a << self[x, p]
        end
        a
    end

    def ispisiVrednosti
        p self.rows
    end

    def each
        x = 1
        while x <= self.num_rows
            yield x
            x += 1
        end
    end

    def method_missing(key, *args)
        kolona = key.to_s

        (1..num_cols).each do |x|
            a = self[1,x].to_s.upcase.gsub(" ", "")
            if (a == kolona.upcase!)
                 (1..num_rows).each do |zzz|
                    p self[zzz, x]

                 end
                 return
            end

        end

    end


end


# ws.ispisiVrednosti
# p ws.num_cols
ws.each do |x|
    p ws.row(x)
end

# GoogleDrive::Worksheet.class_eval{
#     def[](imeKolone)
#         p imeKolone
#         return nil unless imeKolone.is_a? String
#         self.row(1)

#     end
# }

# ws["prva kolona"]
# ws.prvakolona

# 선관위에서 후보 정보 가져오기
# JSON 버전만 만들었어요.
# gem install nokogiri

require 'rubygems'
require 'nokogiri'
require 'json'
require 'net/http'


# 이 코드로 전체 후보를 다 가져올수 있다. 
# 브라우저에서 보면, 시도코드를 선택하게 되어있지만, 
# 시도코드를 0으로 전송하면 전체 시도의 후보를 가져온다.

NEC_SERVER= 'info.nec.go.kr'

CANDI_LIST= '/electioninfo/electionInfo_report.xhtml?electionId=0020160413&requestURI=%2Felectioninfo%2F0020160413%2Fpc%2Fpcri03_ex.jsp&topMenuId=PC&secondMenuId=PCRI03&menuId=&statementId=PCRI03_%232&electionCode=2&cityCode=0&sggCityCode=0&townCode=-1&sggTownCode=0&x=19&y=14'

CANDI_SUM = '/electioninfo/electionInfo_report.xhtml?electionId=0020160413&requestURI=%2Felectioninfo%2F0020160413%2Fpc%2Fpcri01.jsp&topMenuId=PC&secondMenuId=PCRI01&menuId=&statementId=PCRI01_%232&electionCode=2&cityCode=0&x=37&y=12'


list_html   = Net::HTTP.get(NEC_SERVER, CANDI_LIST)
list_doc    = Nokogiri::HTML(list_html)
candi_list  = []

list_doc.css("table#table01").css("tr").each_with_index do |tr, idx|

  candi_array =  tr.css("td").children.to_a
  h = {}
  if candi_array.size>0
    h[:district]    = candi_array[0].content
    h[:party]       = candi_array[1].content
    h[:picture]     = "http://info.nec.go.kr"+candi_array[3].attribute_nodes[1].value
    h[:name]        = candi_array[6].content.strip 
    h[:gender]      = candi_array[8].content.strip
    h[:age]         = candi_array[9].content      
    h[:age_num]     = candi_array[11].content    
    h[:address]     = candi_array[12].content      
    h[:occupation]  = candi_array[13].content   
    h[:education]   = candi_array[14].content  
    #h[:raw]        = candi_array
  end
  candi_list << h unless h.empty?

end


# 통계페이지에서 전체 후보 숫자 가져와서 확인하기
sum_html = Net::HTTP.get(NEC_SERVER, CANDI_SUM)

Nokogiri::HTML(sum_html).css("table#table01").css("tr").each_with_index do |tr, idx|
  if idx==2
    sum_array =  tr.css("td").children.to_a
    if sum_array[3].content.to_i != candi_list.size
      STDERR.puts "ERROR: candidates : #{sum_array[3].content}, crawled: #{candi_list.size}"

      # 오류 발생!!
      exit
    end
  end
end


puts candi_list.to_json

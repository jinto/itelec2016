# 이전 공지

개인 프로젝트에 있는 것이 이상해보여서, everywish라는 org를 만들었습니다.

https://github.com/everywish/itelec2016

에서 진행하겠습니다.



# 2016 선거 관련 IT 도우미 프로젝트

2016년 04월13일 실시, 제20대 국회의원선거 관련 정보 IT 도우미 프로젝트

# candi json 

원자료:

http://info.nec.go.kr/main/showDocument.xhtml?electionId=0020160413&topMenuId=PC&secondMenuId=PCRI03

원자료에는 예비후보 목록을 HTML table 로만 제공하시네요.
JSON이나 XML로도 제공하시면 가공이 편리합니다.


사용법:

    ruby crawler/candi_list.rb > output/candi_list.json


# 저작권

선관위의 저작권 페이지는 두개가 있습니다.

- http://info.nec.go.kr/help/helpMenu.xhtml?selectedName=copyrightpolicy&electionId=0020160413
- http://nec.go.kr/portal/contents.do?menuNo=200520

유선상으로 선관위에 문의를 드리기는 했지만, 유권해석을 해주지는 않으시고, 자료 긁어가는거는 괜찮지 않겠냐.. 는 모호한 답변을 들었습니다.

선관위의 저작권 페이지 중 "비영리 목적일 경우에는 허락 없이 이용이 가능합니다." 라는 항목에 따라, 비영리 목적이므로, 허락을 득하지 않고 스크립트를 만들었습니다.

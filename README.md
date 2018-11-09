로그인
GET request for [/api/web/checkMemberEmail] are [/api/web/{order}]
POST request for [/api/web/checkMemberPass] are [/api/web/{order}]
POST request for [/cms/loginProcess]

공통
GET request for [/cms/system/current]

CONTENTS
페이지 구성: leftMenu, WEB_Media (advenceTree, WEB_Contents_vodPage )
vod 추가 모달 : vodMediaEdit
GET request for [/sedn/web/media] are {section=media}
GET request for [/api/advenceTree/vod/247] are [/api/advenceTree/{order}/{idx}] are {order=vod, idx=247}
request [/cms/list/vod] are [/cms/list/{order}] are {order=vod}

PAGE
페이지 구성: leftMenu, WEB_MakePage (advenceTree, WEB_MakePageList )
GET request for [/sedn/web/makepage] are [/sedn/web/{section}] are {section=makepage}
GET request for [/api/seqKeyList]
GET request for [/cms/makepage/preview/1] are [/cms/makepage/{order}/{idx}] are {order=preview, idx=1}
GET request for [/api/advenceTree/board/1] are [/api/advenceTree/{order}/{idx}] are {order=board, idx=1}

추가 모달 : boardMediaEdit
영상가져오기 모달 : repositoryList (repoListPage)
GET request for [/api/vodSchedule/vod] are [/api/vodSchedule/{order}] are {order=vod}
GET request for [/api/seqKeyList]
request [/cms/list/vod] are [/cms/list/{order}] are {order=vod}

LIVE
페이지 구성: leftMenu, WEB_LiveManages
GET request for [/sedn/web/liveManages] are [/sedn/web/{section}] are {section=liveManages}
GET request for [/api/seqKeyList]
GET request for [/api/advenceTree/json/live] are {order=live}
URI Template variables for request are [/api/advenceTree/json/{order}, /api/advenceTree/{order}/{idx}]
GET request for [/api/web/scheduleJson]

OTT
페이지 구성: leftMenu, STB_Controle ( STB_Controle_List )
GET request for [/sedn/stb/controle] are [/sedn/stb/{section}]
GET request for [/inc/incPermission] are [/inc/{section}]
GET request for [/api/jstree/stb-controle] are [/api/jstree/{order}] are {order=stb-controle}
GET request for [/cms/list/stb-controle] are [/cms/list/{order}] are {order=stb-controle}


VOD 재생 함수
메인
페이지= userLayout, 함수: 모달= common.vodViewModal, 재생= common.vodPlayer

CONTENT
페이지= WEB_Contents_vodPage, 함수: 모달= $('#vodViewModal').modal(), target= vodViewArea
페이지= leftMenu, 함수: 재생= modalLayer.vodPlayer

PAGE
페이지= WEB_Contents_vodPage, 함수: 모달= $('#boardViewModal').modal(), target= boardViewArea
페이지= leftMenu, 함수: 재생= modalLayer.vodPlayer


	
path: /  VOD 재생 param


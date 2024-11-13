var reservedDate = "";
var currentDate = "";
var resultPostDate = "";

//unix timestamp 변환
function convertDateToUnixTimestamp(data){
	currentDate = new Date();
	var modifiedData = "";
	modifiedData = data.substring(0,4)+"-"+data.substring(4,6)+"-"+data.substring(6,8)+","+data.substring(8,10)+":"+data.substring(10,12);
	$.ifvSyncPostJSON(CONTENTS.FB.convertDateToUnixTimestamp, {
		parameter : modifiedData
	}, function(result) {
		if(result && !result.error){
			resultPostDate = result.result;
			reservedDate = new Date(result.reservedDate);
		}else{
			alert(CONTENTS.FB.error_MSG_M02195);
			$.ifvProgressControl(false);
		}
	});
}

//1. 다중 이미지를 포스팅하기 전에, 서버에 각 이미지에 대한 정보를 보내고 id값을 받아온다.
function getIdByFBMultipleImages(snsPageId, appId, appSecurCode, acesToken, acesExpDt, contents, openRange, reservePost, numOfImages, imageInfo, imageInfoId, postId, conid, camStatusCd, attType, fileUrl){
    var _idx = 1;
    var _idx2 = 1;
    var _idx3 = 0;
    //local에서 다중 이미지 업로드 테스트를 하기 위한 것
    /*
    imageInfo = [
                 "http://devmkt2.icignal.com/resources/UploadImages/USERCONTS/2017/5/19/35761563-0402-4153-96fe-3dbeb48b3ae2.jpg"
			    , "http://devmkt2.icignal.com/resources/UploadImages/USERCONTS/2017/5/19/faf4edac-7a04-49ba-92cd-146a73d05e71.jpg"
			    , "http://devmkt2.icignal.com/resources/UploadImages/USERCONTS/2017/5/19/ba9d065c-e174-4cc7-8992-314ae995cf39.png"
			    , "http://devmkt2.icignal.com/resources/UploadImages/USERCONTS/2017/5/19/79a7b296-78be-4a33-9d41-831708cab628.jpg"
                 ];
     */
    if(numOfImages == 0){
    	//이미지가 없을 때, 포스팅
    	postFBMultipleImagesById(snsPageId, appId, appSecurCode, acesToken, acesExpDt, contents, openRange, reservePost, numOfImages, imageInfo, imageInfoId, postId, conid, camStatusCd, attType, fileUrl);
    }else if(numOfImages == 1){
    	//이미지가 1개 있을 때, 포스팅
    	postFBSingleImage(snsPageId, appId, appSecurCode, acesToken, acesExpDt, contents, openRange, reservePost, numOfImages, imageInfo, imageInfoId, postId, conid, camStatusCd, attType, fileUrl);
    }else{
    	//이미지가 있을 때, 포스팅
    	for(var i=0;i<numOfImages;i++){
	    	$.ajax({
	    	    type: 'POST',
	    	    url: 'https://graph.facebook.com/'+snsPageId+'/photos',
	    	    async: false,
	    	    data: {
	    	        access_token: acesToken,
	    	        url: imageInfo[i],
	    	        published: false
	    	    },
	    	    success: function(page_result) {
	    	        if(page_result && !page_result.error){
   						imageInfoId.push(page_result.id);
       					//싱크 맞추기 위해서 활용
       					if (numOfImages == _idx++) {
       						postFBMultipleImagesById(snsPageId, appId, appSecurCode, acesToken, acesExpDt, contents, openRange, reservePost, numOfImages, imageInfo, imageInfoId, postId, conid, camStatusCd, attType, fileUrl);
       					}
   					}else{
   						alert('(#'+(_idx2++)+')'+CONTENTS.FB.error_MSG_M02192);
   						$.ifvProgressControl(false);
   					}
	    	    }
	    	});
    	}
    }
}

//2. getIdByFBMultipleImages에서 받은 id로 다중 이미지를 포함한 포스팅을 한다.
function postFBMultipleImagesById(snsPageId, appId, appSecurCode, acesToken, acesExpDt, contents, openRange, reservePost, numOfImages, imageInfo, imageInfoId, postId, conid, camStatusCd, attType, fileUrl){
	reservedDate = "";
	currentDate = "";
	resultPostDate = "";
	
	//date to unix timestamp 변환
	convertDateToUnixTimestamp(reservePost);
	
	if( (reservedDate.getTime() - currentDate.getTime() > 1000*60*10) && (reservedDate.getTime() - currentDate.getTime() < 1000*60*60*24*180) ){
		//게시물 예약(10분(1000*60*10) ~ 6개월(1000*60*60*24*180))
		var paramObj = {
			"access_token" : acesToken,
			"message" : contents,
			"scheduled_publish_time" : resultPostDate,
			"published" : false,
			"value" : openRange
		};
		for(var i=0; i < imageInfoId.length; i++){
			var fbid = {"media_fbid" : imageInfoId[i]};
			var attached_media = {};
			attached_media["attached_media[" + i + "]"] = fbid;
			jQuery.extend(paramObj, paramObj, attached_media);
		} 
		FB.api("/"+snsPageId+"/feed","POST"
			, paramObj
			, function (post_result) {
				if(post_result && !post_result.error){
					alert(CONTENTS.FB.error_MSG_M02142);
					//포스팅 이후, postId(post_result.id)를 데이터베이스에 저장
					$.ifvSyncPostJSON(CONTENTS.FB.setPostId, {
						id : conid
						, postId : post_result.id
					}, function(result) {
					});	
					setCampaignCompleted();
				}else{
					alert(CONTENTS.FB.error_MSG_M02193);
					$.ifvProgressControl(false);
				}
			}
		);
		imageInfoId = [];
	}else{
		alert(CONTENTS.FB.error_MSG_M02151);
		$.ifvProgressControl(false);
	}
}

//첨부파일 없이, 메세지만 포스팅
function postFBAMessage(snsPageId, appId, appSecurCode, acesToken, acesExpDt, contents, openRange, reservePost, numOfImages, imageInfo, imageInfoId, postId, conid, camStatusCd, attType, fileUrl){
	reservedDate = "";
	currentDate = "";
	resultPostDate = "";
	
	//date to unix timestamp 변환
	convertDateToUnixTimestamp(reservePost);
	
	if( (reservedDate.getTime() - currentDate.getTime() > 1000*60*10) && (reservedDate.getTime() - currentDate.getTime() < 1000*60*60*24*180) ){
		//게시물 예약(10분(1000*60*10) ~ 6개월(1000*60*60*24*180))
		FB.api("/"+snsPageId+"/feed","POST"
				,{
					"access_token" : acesToken,
					"message" : contents,
					"scheduled_publish_time" : resultPostDate,
					"published" : false,
					"value" : openRange
				}
				, function (post_result) {
					if(post_result && !post_result.error){
						alert(CONTENTS.FB.error_MSG_M02142);
						//포스팅 이후, postId(post_result.id)를 데이터베이스에 저장
						$.ifvSyncPostJSON(CONTENTS.FB.setPostId, {
							id : conid
							, postId : post_result.id
						}, function(result) {
						});	
						setCampaignCompleted();
					}else{
						alert(CONTENTS.FB.error_MSG_M02193);
						$.ifvProgressControl(false);
					}
				}
			);
	}else{
		alert(CONTENTS.FB.error_MSG_M02151);
		$.ifvProgressControl(false);
	}
}

//포스팅 시, 단일 이미지 업로드
function postFBSingleImage(snsPageId, appId, appSecurCode, acesToken, acesExpDt, contents, openRange, reservePost, numOfImages, imageInfo, imageInfoId, postId, conid, camStatusCd, attType, fileUrl){
	reservedDate = "";
	currentDate = "";
	resultPostDate = "";
	
	//date to unix timestamp 변환
	convertDateToUnixTimestamp(reservePost);
	
	if( (reservedDate.getTime() - currentDate.getTime() > 1000*60*10) && (reservedDate.getTime() - currentDate.getTime() < 1000*60*60*24*180) ){
		//게시물 예약(10분(1000*60*10) ~ 6개월(1000*60*60*24*180))
		FB.api("/"+snsPageId+"/photos","POST"
			,{
				"url" : imageInfo[0],
				"access_token" : acesToken,
				"message" : contents,
				"scheduled_publish_time" : resultPostDate,
				"published" : false,
				"value" : openRange
			}
			,function(post_result){
				if(post_result && !post_result.error){
					alert(CONTENTS.FB.error_MSG_M02142);
					//포스팅 이후, postId(post_result.id)를 데이터베이스에 저장
					$.ifvSyncPostJSON(CONTENTS.FB.setPostId, {
						id : conid
						, postId : post_result.id
					},function(result){
					});
					setCampaignCompleted();
				}else{
					alert(CONTENTS.FB.error_MSG_M02193);
					$.ifvProgressControl(false);
				}
			}
		);
		imageInfoId = [];
	}else{
		alert(CONTENTS.FB.error_MSG_M02151);
		$.ifvProgressControl(false);
	}
}

//페이스북 포스팅하기
function facebookPosting(snsPageId, appId, appSecurCode, acesToken, acesExpDt, contents, openRange, reservePost, numOfImages, imageInfo, imageInfoId, postId, conid, camStatusCd, attType, fileUrl){
	//initSDK(appId);
	var today = new Date();
	
	//페이스북 콘텐츠 템플릿을 저장한 이후에, 페이스북 포스팅을 진행할 수 있다.
	if(acesExpDt == null || acesExpDt == "" || acesToken == null || acesToken == "" || new Date(acesExpDt) < today){
	//장기토큰 미생성 혹은 장기토큰 만료일이 지났을 경우, 새로 장기토큰을 발급받아 데이터베이스에 저장한다.
		FB.login(function(login_result){
			if (login_result.status === 'connected') {
				getFBAccessToken(snsPageId, appId, appSecurCode, acesToken, acesExpDt, contents, openRange, reservePost, numOfImages, imageInfo, imageInfoId, postId, conid, camStatusCd, attType, fileUrl);
			}else if(login_result.status === 'not_authorized') {
				alert(CONTENTS.FB.error_MSG_M02149);
				$.ifvProgressControl(false);
			}else{
				alert(CONTENTS.FB.error_MSG_M02148);
				$.ifvProgressControl(false);
			}
		},{
			//권한 범위 설정
			scope : 'publish_pages,manage_pages,user_photos,user_posts,user_videos'
		});
	}else{
		/* alert('포스팅 내용 삽입 장기토큰 미생성'); */
		if(attType == "IMAGE"){
			getIdByFBMultipleImages(snsPageId, appId, appSecurCode, acesToken, acesExpDt, contents, openRange, reservePost, numOfImages, imageInfo, imageInfoId, postId, conid, camStatusCd, attType, fileUrl);
		}else if(attType == "VIDEO"){
			uploadNonResumVideo(snsPageId, appId, appSecurCode, acesToken, acesExpDt, contents, openRange, reservePost, numOfImages, imageInfo, imageInfoId, postId, conid, camStatusCd, attType, fileUrl);
		}else if(attType == "NONE"){
			postFBAMessage(snsPageId, appId, appSecurCode, acesToken, acesExpDt, contents, openRange, reservePost, numOfImages, imageInfo, imageInfoId, postId, conid, camStatusCd, attType, fileUrl);
		}
	}
}

//재개불가능 동영상 업로드
function uploadNonResumVideo(snsPageId, appId, appSecurCode, acesToken, acesExpDt, contents, openRange, reservePost, numOfImages, imageInfo, imageInfoId, postId, conid, camStatusCd, attType, fileUrl){
	reservedDate = "";
	currentDate = "";
	resultPostDate = "";
	//local에서 동영상 업로드 테스트
	//fileUrl = "http://devmkt2.icignal.com/resources/UploadFile/A25151161401081997.mp4";
	
	//date to unix timestamp 변환
	convertDateToUnixTimestamp(reservePost);
	
	if( (reservedDate.getTime() - currentDate.getTime() > 1000*60*10) && (reservedDate.getTime() - currentDate.getTime() < 1000*60*60*24*180) ){
		//게시물 예약(10분(1000*60*10) ~ 6개월(1000*60*60*24*180))
		FB.api("/"+snsPageId+"/videos","POST"
			,{
				"file_url" : fileUrl,
				"access_token" : acesToken,
				"message" : contents,
				"scheduled_publish_time" : resultPostDate,
				"published" : false,
				"value" : openRange
			}
			,function(post_result){
				if(post_result && !post_result.error){
					//내용 설정을 위한 해당 동영상 포스팅 업데이트
					/*FB.api("/"+post_result.id,"POST"
							,{
								"access_token" : acesToken,
								"message" : contents
							}
							,function(post_result){
								if(post_result && !post_result.error){
									alert(CONTENTS.FB.error_MSG_M02142);
									//포스팅 이후, postId(post_result.id)를 데이터베이스에 저장
									$.ifvSyncPostJSON(CONTENTS.FB.setPostId, {
										id : conid
										, postId : post_result.id
									},function(result){
									});
									setCampaignCompleted();
								}else{
									alert(CONTENTS.FB.error_MSG_M02193);
									$.ifvProgressControl(false);
								}
							}
						);*/
					alert(CONTENTS.FB.error_MSG_M02142);
					//포스팅 이후, postId(post_result.id)를 데이터베이스에 저장
					$.ifvSyncPostJSON(CONTENTS.FB.setPostId, {
						id : conid
						, postId : post_result.id
					},function(result){
					});
					setCampaignCompleted();
				}else{
					alert(CONTENTS.FB.error_MSG_M02193);
					$.ifvProgressControl(false);
				}
			}
		);
	}else{
		alert(CONTENTS.FB.error_MSG_M02151);
		$.ifvProgressControl(false);
	}
}

//액세스 토큰 생성
function getFBAccessToken(snsPageId, appId, appSecurCode, acesToken, acesExpDt, contents, openRange, reservePost, numOfImages, imageInfo, imageInfoId, postId, conid, camStatusCd, attType, fileUrl){
	FB.api("/"+snsPageId+"/", "GET", {
		"fields" : "access_token"
	}, function(token_result){
		//액세스 토큰 : token_result.access_token
		//단기 액세스 토큰을 장기 액세스 토큰으로 전환
		$.ifvSyncPostJSON(CONTENTS.FB.makeShortToLongLivedToken, {
			fbId : $("#facebookType").val(),
			snsPageId : snsPageId,
			appId : appId,
			appSecurCode : appSecurCode,
			shortLivedToken : token_result.access_token
		}, function(result){
			if(result && !result.error) {
				/* alert('포스팅 내용 삽입 장기토큰 생성'); */
				acesToken = result.longLivedToken;
				if(attType == "IMAGE"){
					getIdByFBMultipleImages(snsPageId, appId, appSecurCode, acesToken, acesExpDt, contents, openRange, reservePost, numOfImages, imageInfo, imageInfoId, postId, conid, camStatusCd, attType, fileUrl);
				}else if(attType == "VIDEO"){
					uploadNonResumVideo(snsPageId, appId, appSecurCode, acesToken, acesExpDt, contents, openRange, reservePost, numOfImages, imageInfo, imageInfoId, postId, conid, camStatusCd, attType, fileUrl);
				}else if(attType == "NONE"){
					postFBAMessage(snsPageId, appId, appSecurCode, acesToken, acesExpDt, contents, openRange, reservePost, numOfImages, imageInfo, imageInfoId, postId, conid, camStatusCd, attType, fileUrl);
				}
			}else{
				alert(CONTENTS.FB.error_MSG_M02194);
				$.ifvProgressControl(false);
			}
		});
	});
}

//FB SDK init
function initSDK(appId) {
	window.fbAsyncInit = function() {
		FB.init({
			appId : appId,
			xfbml : true,
			version : 'v2.9'
		});
		FB.AppEvents.logPageView();
	};
	(function(d, s, id){
		var js, fjs = d.getElementsByTagName(s)[0];
		if(d.getElementById(id)){
			return;
		}
		js = d.createElement(s);
		js.id = id;
		js.src = "//connect.facebook.net/en_US/sdk.js";
		fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));
}

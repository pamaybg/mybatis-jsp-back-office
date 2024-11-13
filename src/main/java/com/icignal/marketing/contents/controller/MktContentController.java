package com.icignal.marketing.contents.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.icignal.loyalty.survey.dto.response.LoySurveyListResDto;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.dto.response.TempUploadResDto;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.marketing.contents.dto.request.MktChnlReqDto;
import com.icignal.marketing.contents.dto.request.MktCondReqDto;
import com.icignal.marketing.contents.dto.request.MktContentChlReqDto;
import com.icignal.marketing.contents.dto.request.MktContentKaKaoReqDto;
import com.icignal.marketing.contents.dto.request.MktContentReqDto;
import com.icignal.marketing.contents.dto.request.MktConvertDateToUnixTimestampReqDto;
import com.icignal.marketing.contents.dto.request.MktEmailDtlReqDto;
import com.icignal.marketing.contents.dto.request.MktFacebookDtlReqDto;
import com.icignal.marketing.contents.dto.request.MktFileUploadReqDto;
import com.icignal.marketing.contents.dto.request.MktGetAttachmentTypeReqDto;
import com.icignal.marketing.contents.dto.request.MktGetFacebookOpenRangeInfoReqDto;
import com.icignal.marketing.contents.dto.request.MktGetFacebookPageInfoReqDto;
import com.icignal.marketing.contents.dto.request.MktGetInstagramDtlReqDto;
import com.icignal.marketing.contents.dto.request.MktGetInstagramInfoReqDto;
import com.icignal.marketing.contents.dto.request.MktImgOptionReqDto;
import com.icignal.marketing.contents.dto.request.MktMmsDtlReqDto;
import com.icignal.marketing.contents.dto.request.MktParsnalEditReqDto;
import com.icignal.marketing.contents.dto.request.MktPersnalFileReqDto;
import com.icignal.marketing.contents.dto.request.MktPersnalFileUploadReqDto;
import com.icignal.marketing.contents.dto.request.MktSetPostIdReqDto;
import com.icignal.marketing.contents.dto.request.MktSetRspnsInfoReqDto;
import com.icignal.marketing.contents.dto.request.MktUploadImageToInstaReqDto;
import com.icignal.marketing.contents.dto.request.MktUploadVideoToInstaReqDto;
import com.icignal.marketing.contents.dto.request.notiAltTestReqDto;
import com.icignal.marketing.contents.dto.response.MktAddFacebookPostingResDto;
import com.icignal.marketing.contents.dto.response.MktChnlResDto;
import com.icignal.marketing.contents.dto.response.MktCondResDto;
import com.icignal.marketing.contents.dto.response.MktContentChlResDto;
import com.icignal.marketing.contents.dto.response.MktContentKaKaoResDto;
import com.icignal.marketing.contents.dto.response.MktContentListResDto;
import com.icignal.marketing.contents.dto.response.MktContentResDto;
import com.icignal.marketing.contents.dto.response.MktConvertDateToUnixTimestampResDto;
import com.icignal.marketing.contents.dto.response.MktEmailDtlResDto;
import com.icignal.marketing.contents.dto.response.MktFacebookDtlResDto;
import com.icignal.marketing.contents.dto.response.MktGetAttachmentTypeResDto;
import com.icignal.marketing.contents.dto.response.MktGetFacebookOpenRangeInfoResDto;
import com.icignal.marketing.contents.dto.response.MktGetFacebookPageInfoResDto;
import com.icignal.marketing.contents.dto.response.MktGetInstagramDtlResDto;
import com.icignal.marketing.contents.dto.response.MktGetInstagramInfoResDto;
import com.icignal.marketing.contents.dto.response.MktImgOptionResDto;
import com.icignal.marketing.contents.dto.response.MktMmsDtlResDto;
import com.icignal.marketing.contents.dto.response.MktPersnalFileResDto;
import com.icignal.marketing.contents.dto.response.MktPersnalFileUploadResDto;
import com.icignal.marketing.contents.service.MktContentService;
import com.icignal.marketing.plan.dto.request.MktplanNodeUpdateReqDto;
import com.icignal.offer.dto.request.OfferReqDto;
import com.icignal.offer.dto.response.OfferResDto;

/**
 * @name : 콘텐츠 Controller
 * @date : 2015. 9. 30.
 * @author 박지열
 * @description : 콘텐츠 서비스 컨트롤러
 */       
@Controller
@RequestMapping("/marketing/content")
public class MktContentController extends BaseController {

	@Autowired
	private MktContentService mktContentService;
		
	@Autowired
	AuthHelper authHelper;
	
	/**
	 * @programId : MKT_CTE_001
	 * @name : getContent
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_contents (콘텐츠 관리 테이블)
	 * @return : List<MKTContentResponseDTO>
	 * @description : 콘텐츠 목록 조회 - 조건 조회를 통한 콘텐츠 목록 조회
	 */
	@RequestMapping(value = "/getContent.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<MktContentListResDto> getContent(HttpServletRequest request, HttpServletResponse response, @RequestBody MktContentReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcr.setLoginInfo(loginInfo);
		
		return mktContentService.getContent(mcr);
	}
	
	/**
	 * @programId : MKT_CTE_P05
	 * @name : getContentChlType
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_contents (콘텐츠 관리 테이블)
	 * @return : List<MKTContentResponseDTO>
	 * @description : 콘텐츠 유형 조회 - 신규 버튼 클릭 시 콘텐츠 유형 목록 조회
	 */
	@RequestMapping(value = "/getContentChlType.do", method = RequestMethod.POST)
	public @ResponseBody List<MktContentResDto> getContentChlType(HttpServletRequest request, HttpServletResponse response, @RequestBody MktContentReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		mcr.setLoginInfo(loginInfo);
					
		return mktContentService.getContentChlType(mcr);
	}
	
	
	/**
	 * @programId : MKT_CTE_002
	 * @name : setContent
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_contents (콘텐츠 관리 테이블)
	 * @return : StatusResDto
	 * @description : 콘첸츠 추가 - 유형 선택 후 콘텐츠를 추가
	 */
	@RequestMapping(value = "/setContent.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setContent(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestBody MktContentReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		mcr.setLoginInfo(loginInfo);
				
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mcr.setMemId(loginInfo.getId());
		
		return mktContentService.setContent(session,mcr);
	}
	
	/**
	 * @programId : MKT_CTE_002
	 * @name : editResponseContent
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_contents (콘텐츠 관리 테이블)
	 * @return : StatusResDto
	 * @description : 콘첸츠 수정 - 콘텐츠를 선택하고 들어온 뒤 수정
	 */
	@RequestMapping(value = "/editResponseContent.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editResponseContent(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestBody MktContentReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		mcr.setLoginInfo(loginInfo);
						
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mcr.setMemId(loginInfo.getId());

		return mktContentService.editResponseContent(session,mcr);
	}
	
	/**
	 * @programId : MKT_CTE_002
	 * @name : getDeatilContent
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_contents (콘텐츠 관리 테이블)
	 * @return : MKTContentResponseDTO
	 * @description : 컨텐츠 상세 조회
	 */
	@RequestMapping(value = "/getDetailContent.do", method = RequestMethod.POST)
	public @ResponseBody MktContentResDto getDeatilContent(HttpServletRequest request, HttpServletResponse response, @RequestBody MktContentReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);

		//로그인 여부
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		mcr.setLoginInfo(loginInfo);
		
		return mktContentService.getDetailContent(mcr);
	}
	
	/**
	 * @programId : MKT_CTE_003
	 * @name : getEmailDtlList
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_contents (콘텐츠 관리 테이블)
	 * @return : MKTEmailDtlResponseDTO
	 * @description : 이메일 상세 조회
	 */
	@RequestMapping(value = "/getEmailDtlList.do", method = RequestMethod.POST)
	public @ResponseBody MktEmailDtlResDto getEmailDtlList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktEmailDtlReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);

		//로그인 여부
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		mcr.setLoginInfo(loginInfo);
		
		return mktContentService.getEmailDtlList(mcr);
	}
	
	/**
	 * @programId : MKT_CTE_004
	 * @name : getMmsDtlList
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_contents (콘텐츠 관리 테이블)
	 * @return : MKTContentResponseDTO
	 * @description : MMS 상세 조회
	 */ 
	@RequestMapping(value = "/getMmsDtlList.do", method = RequestMethod.POST)
	public @ResponseBody MktMmsDtlResDto getMmsDtlList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktMmsDtlReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);

		//로그인 여부
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		mcr.setLoginInfo(loginInfo);
		
		return mktContentService.getMmsDtlList(mcr);
	}
	
	/**
	 * @programId :
	 * @name : getChnlGuide
	 * @date : 2018 .09 .18
	 * @author : 금동우
	 * @table : 
	 * @return : MKTMmsDtlResponseDTO
	 * @description : 채널 가이드 조회
	 */
	@RequestMapping(value = "/getChnlGuide.do", method = RequestMethod.POST)
	public @ResponseBody MktMmsDtlResDto getChnlGuide(HttpServletRequest request, HttpServletResponse response, @RequestBody MktMmsDtlReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);

		//로그인 여부
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		mcr.setLoginInfo(loginInfo);
		
		return mktContentService.getChnlGuide(mcr);
	}
	
	/**
	 * @programId : MKT_CTE_002
	 * @name : removeContent
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_contents (콘텐츠 관리 테이블)
	 * @return : List<MKTTemplateListResponseDTO>
	 * @description : 콘첸츠 삭제 
	 */
	@RequestMapping(value="/removeContent.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeContent(HttpServletRequest request, HttpServletResponse response, @RequestBody MktContentReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		mcr.setLoginInfo(loginInfo);
		
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mcr.setMemId(loginInfo.getId());

		return mktContentService.removeContent(mcr);
	}
	
	/**
	 * @programId : MKT_CTE_002
	 * @name : getChannelType
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_conts_type_chnl_rel (콘텐츠 채널 관계 테이블)
	 * @return : List<MKTContentChlResponseDTO>
	 * @description : 콘텐츠 신규 생성을 위한 채널 유형 조회
	 */
	@RequestMapping(value="/getChannelType.do", method = RequestMethod.POST)
	public @ResponseBody List<MktContentChlResDto> getChannelType(HttpServletRequest request, HttpServletResponse response, @RequestBody MktContentChlReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		mcr.setLoginInfo(loginInfo);
		
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mcr.setMemId(loginInfo.getId());

		return mktContentService.getChannelType(mcr);
	}
	
	/**
	 * @programId : MKT_CTE_002
	 * @name : getChannelType
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_conts_type_chnl_rel,mkt_chnl (콘텐츠 채널 관계 테이블, 마케팅 채널)
	 * @return : List<MKTContentChlResponseDTO>
	 * @description : 콘텐츠에 따른 등록한 채널 조회
	 */
	@RequestMapping(value="/getChnnl.do", method = RequestMethod.POST)
	public @ResponseBody List<MktContentChlResDto> getChnnl(HttpServletRequest request, HttpServletResponse response, @RequestBody MktContentChlReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		mcr.setLoginInfo(loginInfo);
		
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mcr.setMemId(loginInfo.getId());
		
		return mktContentService.getChnnl(mcr);
	}
	
	/**
	 * @programId : MKT_CTE_003
	 * @name : addfile
	 * @date : 2015. 10. 30.
	 * @author : 박지열
	 * @table : file (파일 관리 테이블)
	 * @return : StatusResDto
	 * @description : 파일 추가
	 */
	@RequestMapping(value="/addfile.do", method=RequestMethod.POST)
	public @ResponseBody StatusResDto addfile(HttpServletRequest request, HttpServletResponse response, @RequestBody MktFileUploadReqDto adr, HttpSession session) {
        LogUtil.param(this.getClass(), adr);
        
        //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        adr.setLoginInfo(loginInfo);
        
        adr.setUserId((String) session.getAttribute(CommonUtil.CURR_STORE_PROP));
        String SessionString = request.getSession().getServletContext().getRealPath("/");
        
        return mktContentService.addfile(adr, SessionString, session);
    }
	
	/**
	 * @programId : MKT_CTE_003
	 * @name : deleteContentFile
	 * @date : 2015. 10. 30.
	 * @author : 박지열
	 * @table : mkt_conts_type_chnl_rel,mkt_chnl (콘텐츠 채널 관계 테이블, 마케팅 채널)
	 * @return : List<MKTContentChlResponseDTO>
	 * @description : 파일을 바꿀 시 연결되어 있는 파일 제거
	 */
	@RequestMapping(value="/removeContentFile.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeContentFile(HttpServletRequest request, HttpServletResponse response, @RequestBody MktFileUploadReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		mcr.setLoginInfo(loginInfo);
        
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mcr.setMemId(loginInfo.getId());
		
		
		return mktContentService.removeContentFile(mcr);
	}

	/**
	 * @programId : MKT_CTE_002
	 * @name : getCouponList
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_offer_mst (오퍼 마스터 테이블)
	 * @return : GridPagingResDto
	 * @description : 바코드 생성 후 경로 뿌려주기.
	 */
	/*@RequestMapping(value = "/getBarcode.do", method = RequestMethod.POST)
	public @ResponseBody MKTContentResponseDTO getBarcode(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestBody MKTOfferRequestDTO mor) {
	   LogUtil.param(this.getClass(), mor);
	   
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		mor.setLoginInfo(loginInfo);
	       
	   return mktContentService.getBarcode(session, mor);
	}*/
	
	
	/**
	 * @programId : MKT_CTE_P02
	 * @name : sendChannelTest
	 * @date : 2015. 11. 05.
	 * @author : 박지열
	 * @table : mst_conts_mst (콘텐츠 마스터 테이블)
	 * @return : StatusResDto
	 * @description : sms Test 발송
	 */
	@RequestMapping(value = "/sendChannelTest.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto sendChannelTest(HttpServletRequest request, HttpServletResponse response, @RequestBody MktContentReqDto mcr) {
	   LogUtil.param(this.getClass(), mcr);
	   
	   //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
	   LoginResDto loginInfo = this.checkLoginSession(request, response);
	   mcr.setLoginInfo(loginInfo);
	   
	   //세션에 저장되어 있는 지원의 아이디를 셋팅
	   mcr.setUserId(loginInfo.getEmpEmail());
	   mcr.setMemId(loginInfo.getId());
	   
	   return mktContentService.sendChannelTest(mcr);
	}	
	
	/**
	 * @programId : MKT_CHL_P03
	 * @name : getFileUpType
	 * @date : 2015. 11. 16.
	 * @author : 박지열
	 * @table : mkt_chnl_capa (채널 용량 관리 테이블)
	 * @return : List<MKTCondResponseDTO>
	 * @description : 해당 채널에 관련된 파일 업로드 타입 반환.
	 */
	@RequestMapping(value = "/getFileUpType.do", method = RequestMethod.POST)
	public @ResponseBody List<MktCondResDto> getFileUpType(HttpServletRequest request, HttpServletResponse response, @RequestBody MktContentReqDto mcr) {
	   LogUtil.param(this.getClass(), mcr);
	   
	   //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
	   LoginResDto loginInfo = this.checkLoginSession(request, response);
	   mcr.setLoginInfo(loginInfo);
	 				
	   //세션에 저장되어 있는 지원의 아이디를 셋팅
	   mcr.setUserId(loginInfo.getEmpEmail());
	 	
	   return mktContentService.getFileUpType(mcr);
	
	}
	
	/**
	 * @programId : MKT_CTE_P06
	 * @name : getImageOptionList
	 * @date : 2015. 11. 16.
	 * @author : 박지열
	 * @table : mkt_chnl_capa (채널 용량 관리 테이블)
	 * @return : List<MKTImgOptionResponseDTO>
	 * @description : 바코드 생성을 위한 해당 채널에 대한 이미지 옵션을 가져오기.
	 */
	@RequestMapping(value = "/getImageOptionList.do", method = RequestMethod.POST)
	public @ResponseBody List<MktImgOptionResDto> getImageOptionList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktImgOptionReqDto mior) {
	   LogUtil.param(this.getClass(), mior);
	   
	   //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
	   LoginResDto loginInfo = this.checkLoginSession(request, response);
	   mior.setLoginInfo(loginInfo);
	 				 	
	   return mktContentService.getImageOptionList(mior);
	
	}
	
	/**
	 * @programId : MKT_CTE_P05
	 * @name : getchnlCodeName
	 * @date : 2015. 11. 16.
	 * @author : 박지열
	 * @table : mkt_chnl (채널 관리 테이블)
	 * @return : MKTCondResponseDTO
	 * @description : Test 발송을 위한 채널 시스템 코드 가져오기.
	 */
	@RequestMapping(value = "/getchnlCodeName.do", method = RequestMethod.POST)
	public @ResponseBody MktCondResDto getchnlCodeName(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCondReqDto mcr) {
	   LogUtil.param(this.getClass(), mcr);
	   
	   //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
	   LoginResDto loginInfo = this.checkLoginSession(request, response);
	   mcr.setLoginInfo(loginInfo);
			 	
	   return mktContentService.getchnlCodeName(mcr);
	}
	
	/**
	 * @programId : MKT_CTE_002
	 * @name : getPersonalList
	 * @date : 2016. 01. 11.
	 * @author : 박지열
	 * @table : mkt_chnl (채널 관리 테이블)
	 * @return : MKTCondResponseDTO
	 * @description : 개인화 속성 리스트 가져오기
	 */
	@RequestMapping(value = "/getPersonalList.do", method = RequestMethod.POST)
	public @ResponseBody List<MktCondResDto> getPersonalList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCondReqDto mcr) {
	   LogUtil.param(this.getClass(), mcr);
	   
	   //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
	   LoginResDto loginInfo = this.checkLoginSession(request, response);
	   mcr.setLoginInfo(loginInfo);
			 	
	   return mktContentService.getPersonalList(mcr);
	}
	
	/**
	 * @programId : MKT_CTE_002
	 * @name : getChnlId
	 * @date : 2016. 01. 11.
	 * @author : 박지열
	 * @table : mkt_chnl (채널 관리 테이블)
	 * @return : MKTCondResponseDTO
	 * @description : 채널 아이디 가져오기
	 */
	@RequestMapping(value = "/getChnlId.do", method = RequestMethod.POST)
	public @ResponseBody 
	GridPagingResDto<MktChnlResDto> getChnlId(HttpServletRequest request, HttpServletResponse response, @RequestBody MktChnlReqDto mcr) {
	   LogUtil.param(this.getClass(), mcr);
	   
	   //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
	   LoginResDto loginInfo = this.checkLoginSession(request, response);
	   mcr.setLoginInfo(loginInfo);
		 	
	   return mktContentService.getChnlId(mcr);
	}
	
    /**
     * @programId : 
     * @name : getChannelByCodeName
     * @date : 2016. 3. 7.
     * @author : "류동균"
     * @table : mkt_chnl
     * @return : MKTContentChlResponseDTO
     * @description : 채널정보 조회
     */
    @RequestMapping(value = "/getChannelByCodeName.do", method = RequestMethod.POST)
    public @ResponseBody MktContentChlResDto getChannelByCodeName(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestBody MktContentChlReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcr.setLoginInfo(loginInfo);
                
        //세션에 저장되어 있는 지원의 아이디를 셋팅
        mcr.setMemId(loginInfo.getId());
        
        return mktContentService.getChannelByCodeName(mcr);
    }
	
    /**
     * @name : getFacebookPageInfo
     * @date : 2017. 5. 2.
     * @author : jun.lee
     * @return : GridPagingResDto
     * @description : Facebook 페이지 정보 조회
     */
    @RequestMapping(value="/getFacebookPageInfo.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<MktGetFacebookPageInfoResDto> getFacebookPageInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody MktGetFacebookPageInfoReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
	    
		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        bccr.setLoginInfo(loginInfo);
        
		return mktContentService.getFacebookPageInfo(bccr);
	}
    
    /**
     * @name : getFacebookDtlList
     * @date : 2017. 5. 2.
     * @author : jun.lee
     * @return : MKTEmailDtlResponseDTO 
     * @description : Facebook 상세 조회 
     */
    @RequestMapping(value = "/getFacebookDtlList.do", method = RequestMethod.POST)
	public @ResponseBody MktFacebookDtlResDto getFacebookDtlList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktFacebookDtlReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcr.setLoginInfo(loginInfo);
		
		return mktContentService.getFacebookDtlList(mcr);
	}
    
    /**
     * @name : tempUploadIE
     * @date : 2017. 5. 22.
     * @author : jun.lee
     * @return : ModelAndView
     * @description : tempUploadIE
     */
    @RequestMapping(value="/tempUploadIE.do", method=RequestMethod.POST, headers="content-type=multipart/*", produces = "text/plain")
	//multipart 입력폼 생성 - 파일전송 타입 - 모든 파입, Produces : 출력하고자 하는 데이터 포맷 text/plain 미디어 유형, accept 헤더를 참고
	public ModelAndView tempUploadIE(@RequestParam(value = "file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
    	LogUtil.param(this.getClass(), "");
    	
		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
    	
    	//@RequestParam 업로드 파일 데이터 전송 방식
		HttpSession session = request.getSession(true);

		List<TempUploadResDto> results = mktContentService.tempUpload(request.getSession().getServletContext().getRealPath("/"), session.getId(), file);

		String convertJSON = StringUtil.getJSONtoObject(results).trim().replace("\r\n", "").replace(" ", "").replace("\n", ""); //경로값을 스트링으로 바꿔주며, 공백을 제거
		
		return new ModelAndView("marketing/content/facebookFormNew", "ImageInfo", convertJSON ); //화면에 뿌려줌
	}
    
    /**
     * @name : getFacebookPageInfoById
     * @date : 2017. 5. 22.
     * @author : jun.lee
     * @return : MKTGetFacebookPageInfoResponseDTO
     * @description : 페이스북 페이지 정보 조회
     */
    @RequestMapping(value="/getFacebookPageInfoById.do", method = RequestMethod.POST)
	public @ResponseBody MktGetFacebookPageInfoResDto getFacebookPageInfoById(HttpServletRequest request, HttpServletResponse response, @RequestBody MktGetFacebookPageInfoReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
	     
		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        bccr.setLoginInfo(loginInfo);
        
		return mktContentService.getFacebookPageInfoById(bccr);
	}
    
    /**
     * @name : getFacebookOpenRangeInfo
     * @date : 2017. 6. 7.
     * @author : jun.lee
     * @return : GridPagingResDto
     * @description : 페이스북 공개 범위 정보 조회
     */
    @RequestMapping(value="/getFacebookOpenRangeInfo.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<MktGetFacebookOpenRangeInfoResDto> getFacebookOpenRangeInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody MktGetFacebookOpenRangeInfoReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
	     
		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        bccr.setLoginInfo(loginInfo);
        
		return mktContentService.getFacebookOpenRangeInfo(bccr);
	}
    
    /**
     * @name : requesFaceBooktAccesToken
     * @date : 2017. 5. 22.
     * @author : jun.lee
     * @return : String 
     * @description : 단기 액세스 토큰을 장기 액세스 토큰으로 전환
     */
    @RequestMapping(value="/makeShortToLongLivedToken.do", method = RequestMethod.POST)
	public @ResponseBody MktAddFacebookPostingResDto makeShortToLongLivedToken(HttpServletRequest request, HttpServletResponse response, @RequestBody MktGetFacebookPageInfoReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
	     
		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        bccr.setLoginInfo(loginInfo);
		
		return mktContentService.makeShortToLongLivedToken(bccr);
	}
    
    /**
     * @name : setPostId
     * @date : 2017. 5. 29.
     * @author : jun.lee
     * @return : StatusResDto
     * @description : 포스팅 시, postId 저장
     */
    @RequestMapping(value="/setPostId.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setPostId(HttpServletRequest request, HttpServletResponse response, @RequestBody MktSetPostIdReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
	     
		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        bccr.setLoginInfo(loginInfo);
		bccr.setMemId(loginInfo.getId());
		
		return mktContentService.setPostId(bccr);
	}
    
    /**
     * @name : convertDateToUnixTimestamp
     * @date : 2017. 5. 29.
     * @author : jun.lee
     * @return : MKTConvertDateToUnixTimestampResponseDTO
     * @description : date를 unix timestamp로 변환
     */
    @RequestMapping(value="/convertDateToUnixTimestamp.do", method = RequestMethod.POST)
	public @ResponseBody MktConvertDateToUnixTimestampResDto convertDateToUnixTimestamp(HttpServletRequest request, HttpServletResponse response, @RequestBody MktConvertDateToUnixTimestampReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		
		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        bccr.setLoginInfo(loginInfo);
		
		return mktContentService.convertDateToUnixTimestamp(bccr);
	}
    
    /**
     * @name : setReactionsRspnsInfo
     * @date : 2017. 6. 7.
     * @author : jun.lee
     * @return : StatusResDto
     * @description : 페이스북 종류별 좋아요 반응정보 수집
     */
    @RequestMapping(value="/setReactionsRspnsInfo.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setReactionsRspnsInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody MktSetRspnsInfoReqDto bccr) throws IOException, ParseException {
		LogUtil.param(this.getClass(), bccr);
	     
		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        bccr.setLoginInfo(loginInfo);
		bccr.setMemId(loginInfo.getId());
		
		return mktContentService.setReactionsRspnsInfo(bccr);
	}
    
    /**
     * @name : setSharedpostsRspnsInfo
     * @date : 2017. 6. 7.
     * @author : jun.lee
     * @return : StatusResDto 
     * @description : 페이스북 공유 반응정보 수집
     */
    @RequestMapping(value="/setSharedpostsRspnsInfo.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setSharedpostsRspnsInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody MktSetRspnsInfoReqDto bccr) throws IOException, ParseException {
		LogUtil.param(this.getClass(), bccr);
	     
		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        bccr.setLoginInfo(loginInfo);
		bccr.setMemId(loginInfo.getId());
		
		return mktContentService.setSharedpostsRspnsInfo(bccr);
	}
    
    /**
     * @name : setCommentsRspnsInfo
     * @date : 2017. 6. 7.
     * @author : jun.lee
     * @return : StatusResDto
     * @description : 페이스북 댓글 반응정보 수집
     */
    @RequestMapping(value="/setCommentsRspnsInfo.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setCommentsRspnsInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody MktSetRspnsInfoReqDto bccr) throws IOException, ParseException {
		LogUtil.param(this.getClass(), bccr);
	     
		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        bccr.setLoginInfo(loginInfo);
		bccr.setMemId(loginInfo.getId());
		
		return mktContentService.setCommentsRspnsInfo(bccr);
	}
    
    /**
     * @name : getAttachmentType
     * @date : 2017. 7. 5.
     * @author : jun.lee
     * @return : GridPagingResDto
     * @description : 페이스북 첨부파일 조회
     */
    @RequestMapping(value="/getAttachmentType.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<MktGetAttachmentTypeResDto> getAttachmentType(HttpServletRequest request, HttpServletResponse response, @RequestBody MktGetAttachmentTypeReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
	     
		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        bccr.setLoginInfo(loginInfo);

        return mktContentService.getAttachmentType(bccr);
	}
    
    /**
     * @name : uploadImageToInsta
     * @date : 2017. 7. 17.
     * @author : jun.lee
     * @return : StatusResDto
     * @description : 인스타그램에 단일이미지 업로드
     */
    @RequestMapping(value="/uploadImageToInsta.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto uploadImageToInsta(HttpServletRequest request, HttpServletResponse response, @RequestBody MktUploadImageToInstaReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
	     
		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        bccr.setLoginInfo(loginInfo);
		
		return mktContentService.uploadImageToInsta(bccr);
	}
    
    /**
     * @name : uploadVideoToInsta
     * @date : 2017. 7. 17.
     * @author : jun.lee
     * @return : StatusResDto
     * @description : 인스타그램에 단일동영상 업로드
     */
    @RequestMapping(value="/uploadVideoToInsta.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto uploadVideoToInsta(HttpServletRequest request, HttpServletResponse response, @RequestBody MktUploadVideoToInstaReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
	     
		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        bccr.setLoginInfo(loginInfo);
		
		return mktContentService.uploadVideoToInsta(bccr);
	}
    
    /**
     * @name : getInstagramInfo
     * @date : 2017. 7. 17.
     * @author : jun.lee
     * @return : GridPagingResDto
     * @description : 인스타그램 계정 정보 조회
     */
    @RequestMapping(value="/getInstagramInfo.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<MktGetInstagramInfoResDto> getInstagramInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody MktGetInstagramInfoReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
	     
		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        bccr.setLoginInfo(loginInfo);
        
		return mktContentService.getInstagramInfo(bccr);
	}
    
    /**
     * @name : getInstagramDtlList
     * @date : 2017. 7. 17.
     * @author : jun.lee
     * @return : MKTGetInstagramDtlResponseDTO
     * @description : 인스타그램 채널 상세 조회
     */
    @RequestMapping(value = "/getInstagramDtlList.do", method = RequestMethod.POST)
	public @ResponseBody MktGetInstagramDtlResDto getInstagramDtlList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktGetInstagramDtlReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcr.setLoginInfo(loginInfo);
		
		return mktContentService.getInstagramDtlList(mcr);
	}
    
    /**
     * @name : getInstagramInfoById
     * @date : 2017. 7. 17.
     * @author : jun.lee
     * @return : MKTGetInstagramInfoResponseDTO
     * @description : id로 인스타그램 계정 정보 조회
     */
    @RequestMapping(value="/getInstagramInfoById.do", method = RequestMethod.POST)
	public @ResponseBody MktGetInstagramInfoResDto getInstagramInfoById(HttpServletRequest request, HttpServletResponse response, @RequestBody MktGetInstagramInfoReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
	     
		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        bccr.setLoginInfo(loginInfo);
		
		return mktContentService.getInstagramInfoById(bccr);
    }
    
    /**
     * 개인화 파일 조회
     * 
     * @programId : 
     * @name : getPersnalFile
     * @date : 2017. 12. 7.
     * @author : jh.kim
     * @table : 
     * @return : MKTPersnalFileResponseDTO
     * @description : 
     */
    @RequestMapping(value="/getContsPrsnlFile.do", method = RequestMethod.POST)
    public @ResponseBody MktPersnalFileResDto getContsPrsnlFile(HttpServletRequest request, HttpServletResponse response, @RequestBody MktPersnalFileReqDto param) {
        LogUtil.param(this.getClass(), param);
        
		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);
        
        return mktContentService.getContsPrsnlFile(param);
    }

    /**
     * 개인화 파일 등록
     * 
     * @programId : 
     * @name : uploadPrsnlFile
     * @date : 2017. 12. 8.
     * @author : jh.kim
     * @table : 
     * @return : MKTPersnalFileUploadResponseDTO
     * @description : 
     */
    @RequestMapping(value="/uploadPrsnlFile.do", method = RequestMethod.POST, headers = "content-type=multipart/*")
    public @ResponseBody MktPersnalFileUploadResDto uploadPrsnlFile(
            @RequestParam(value = "file") MultipartFile file, 
            @RequestParam(value = "contsId") String contsId,
            HttpServletRequest request, HttpServletResponse response,
            HttpSession session) {
        LogUtil.param(this.getClass(), null);
        
		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        
        MktPersnalFileUploadReqDto param = new MktPersnalFileUploadReqDto();
        param.setLoginInfo(loginInfo);
        param.setContsId(contsId);

        String realPath = request.getSession().getServletContext().getRealPath("/");
        param.setOrgFilePath(realPath);
        
        return mktContentService.uploadPrsnlFile(param, file);
    }

    /**
     * 개인화 파일 및 데이터 삭제 
     * 
     * @programId : 
     * @name : removePrsnlFile
     * @date : 2017. 12. 8.
     * @author : jh.kim
     * @table : 
     * @return : StatusResDto
     * @description : 
     */
    @RequestMapping(value="/removePrsnl.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto removePrsnl(HttpServletRequest request, HttpServletResponse response, @RequestBody MktParsnalEditReqDto param) {
        LogUtil.param(this.getClass(), param);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);
        
        return mktContentService.removePrsnl(param);
    }
    

	/**
	 * @programId : 
	 * @name : getImgSize
	 * @date : 2020. 03. 30.
	 * @author :yj.choi
	 * @table : com.image
	 * @return : MktContentResDto
	 * @description : 이미지 파일 사이즈 
	 */
	@RequestMapping(value = "/getImgSize.do", method = RequestMethod.POST)
	public @ResponseBody MktContentResDto getImgSize(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestBody MktContentReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		mcr.setLoginInfo(loginInfo);
				
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mcr.setMemId(loginInfo.getId());
		
		return mktContentService.getImgSize(mcr);
	}
	
	
	/**
	 * @programId : 
	 * @name : getCpnList
	 * @date : 2020. 11. 12.
	 * @author :yj.choi
	 * @table : loy_ofr
	 * @return : MktContentResDto
	 * @description : 쿠폰 조회 
	 */
	@RequestMapping(value = "/getCpnList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<OfferResDto> getCpnList(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestBody OfferReqDto mcr) {
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		
		LogUtil.param(this.getClass(), mcr);
		mcr.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return mktContentService.getCpnList(mcr);
	}

	/**
	 * @programId :
	 * @name : getCpnList
	 * @date : 2020. 11. 12.
	 * @author :yj.choi
	 * @table : loy_ofr
	 * @return : MktContentResDto
	 * @description : 캠페인 키 조회
	 */
	@RequestMapping(value = "/getCampaignKeyList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<OfferResDto> getCampaignKeyList(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestBody OfferReqDto mcr) {
		LoginResDto loginInfo = this.checkLoginSession(request, response);

		LogUtil.param(this.getClass(), mcr);
		mcr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return mktContentService.getCampaignKeyList(mcr);
	}

	/**
	 * @programId :
	 * @description : 캠페인 키 불러오기
	 */
	@RequestMapping(value = "/getBrazeCampaignLoad.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto getBrazeCampaignLoad(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestBody OfferReqDto mcr) {
		LoginResDto loginInfo = this.checkLoginSession(request, response);

		LogUtil.param(this.getClass(), mcr);
		mcr.setLoginInfo(authHelper.checkLoginSession(request, response));

		StatusResDto rtnValue = new StatusResDto();
		rtnValue = mktContentService.getBrazeCampaignLoad(mcr);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : getPointOfrList
	 * @return : MktContentResDto
	 * @description : 포인트 오퍼 조회
	 */
	@RequestMapping(value = "/getPointOfrList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<OfferResDto> getPointOfrList(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestBody OfferReqDto mcr) {
		LoginResDto loginInfo = this.checkLoginSession(request, response);

		LogUtil.param(this.getClass(), mcr);
		mcr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return mktContentService.getPointOfrList(mcr);
	}

	/**
	 * @programId : 
	 * @name : saveContsOfr
	 * @date : 2020. 11. 13.
	 * @author : yj.choi
	 * @table : loy_cpn_mbr
	 * @return : StatusResDto
	 * @description : 컨텐츠 오퍼 rid 저장
	 */
	@RequestMapping(value = "/saveContsOfr.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveContsOfr(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestBody OfferReqDto reqDto) {
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return mktContentService.saveContsOfr(reqDto);
		
	}
 
	/**
	 * @programId : 
	 * @name : saveContsKakao
	 * @date : 2021. 01. 07.
	 * @author : lee gyeong young
	 * @table : 
	 * @return : StatusResDto
	 * @description : 카카오 알림톡/친구톡 신규
	 */
	@RequestMapping(value = "/saveContsKakao.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveContsKakao(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestBody MktContentReqDto reqDto) {
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return mktContentService.saveContsKakao(reqDto);
		
	}
	/**
	 * @programId : 
	 * @name : changeSaveContsKakao
	 * @date : 2021. 01. 07.
	 * @author : lee gyeong young
	 * @table : 
	 * @return : StatusResDto
	 * @description : 카카오 알림톡/친구톡 수정
	 */
	@RequestMapping(value = "/changeSaveContsKakao.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto changeSaveContsKakao(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestBody MktContentReqDto reqDto) {
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return mktContentService.changeSaveContsKakao(reqDto);
	}
	/**
	 * @programId : 
	 * @name : getDescContsKakao
	 * @date : 2021. 01. 07.
	 * @author : lee gyeong young
	 * @table : 
	 * @return : StatusResDto
	 * @description : 카카오 알림톡/친구톡 조회 상세
	 */
	@RequestMapping(value = "/getDescContsKakao.do", method = RequestMethod.POST)
	public @ResponseBody MktContentResDto getDescContsKakao(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestBody MktContentReqDto reqDto) {
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return mktContentService.getDescContsKakao(reqDto);
	}	
	/**
	 * @programId : 
	 * @name : getGridContsKakao
	 * @date : 2021. 01. 07.
	 * @author : lee gyeong young
	 * @table : 
	 * @return : GridPagingResDto<MktContentKaKaoReqDto>
	 * @description : 카카오 알림톡/친구톡 조회 그리드
	 */
	@RequestMapping(value = "/getGridContsKakao.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<MktContentKaKaoResDto> getGridContsKakao(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestBody MktContentReqDto reqDto) {
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return mktContentService.getGridContsKakao(reqDto);
	}	
	
	/**
	 * @programId : 
	 * @name : sendChannelTestSend
	 * @date : 2021. 01. 13.
	 * @author : lee gyeong young
	 * @table : 
	 * @description : 카카오 알림톡/친구톡 테스트 발송
	 */
	@RequestMapping(value = "/sendChannelTestSend.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto sendChannelTestSend(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestBody notiAltTestReqDto reqDto) {
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return mktContentService.sendChannelTestSend(reqDto);
	}	
	
	/**
	 * @programId : 
	 * @name : sendEmailTestSend
	 * @date : 2021. 01. 13.
	 * @author : lee gyeong young
	 * @table : 
	 * @description : 이메일 테스트 발송
	 */
	@RequestMapping(value = "/sendEmailTestSend.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto sendEmailTestSend(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestBody notiAltTestReqDto reqDto) {
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return mktContentService.sendEmailTestSend(reqDto);
	}

	/**
	 * @programId : MKT_CHL_P03
	 * @name : getPersonalType
	 * @date : 2022. 04. 06.
	 * @author : 정수지
	 * @table : mkt_chnl_capa (채널 용량 관리 테이블)
	 * @return : List<MKTCondResponseDTO>
	 * @description : 개인화 속성 불러오기
	 */
	@RequestMapping(value = "/getPersonalType.do", method = RequestMethod.POST)
	public @ResponseBody List<MktCondResDto> getPersonalType(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCondReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);

		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		mcr.setLoginInfo(loginInfo);

		return mktContentService.getPersonalType(mcr);

	}

	/**
	 * @programId : MKT_CHL_P03
	 * @name : getPersonalType
	 * @date : 2022. 04. 06.
	 * @author : 정수지
	 * @table : mkt_chnl_capa (채널 용량 관리 테이블)
	 * @return : List<MKTCondResponseDTO>
	 * @description : 전화번호 조회
	 */
	@RequestMapping(value = "/selectPhoneNo.do", method = RequestMethod.POST)
	public @ResponseBody MktContentResDto selectPhoneNo(HttpServletRequest request, HttpServletResponse response, @RequestBody MktContentReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);

		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		mcr.setLoginInfo(loginInfo);

		return mktContentService.selectPhoneNo(mcr);

	}


}
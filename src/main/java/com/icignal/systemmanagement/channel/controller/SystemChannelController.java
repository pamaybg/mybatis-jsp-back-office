package com.icignal.systemmanagement.channel.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.systemmanagement.channel.dto.request.SystemChannelDetailReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemChannelInsertReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemChannelReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemChannelcapaDeleteReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemChannelcapaReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemDeleteSnsAdtnInfoReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemImgOptionDeleteReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemImgOptionListReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemImgOptionReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemImgOptionlInsertReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemImgOptionlUpdateReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemInsertSnsAdtnInfoReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemSnsAdtnInfoReqDto;
import com.icignal.systemmanagement.channel.dto.response.SystemAccountResDto;
import com.icignal.systemmanagement.channel.dto.response.SystemChannelDetailResDto;
import com.icignal.systemmanagement.channel.dto.response.SystemChannelResDto;
import com.icignal.systemmanagement.channel.dto.response.SystemChannelcapaResDto;
import com.icignal.systemmanagement.channel.dto.response.SystemGetDetailSnsAdtnInfoResDto;
import com.icignal.systemmanagement.channel.dto.response.SystemImgOptionListResDto;
import com.icignal.systemmanagement.channel.dto.response.SystemImgOptionResDto;
import com.icignal.systemmanagement.channel.dto.response.SystemSnsAdtnInfoResDto;
import com.icignal.systemmanagement.channel.service.SystemChannelService;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCodeRequestDTO;

@Controller
@RequestMapping("/system/channel")
public class SystemChannelController extends BaseController{

	@Autowired SystemChannelService systemChannelService;
	@Autowired AuthHelper authhelper;
	
	/**
	 * @programId : MKT_CHL_001
	 * @name : getChannel
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_channel (마케팅 채널 관리 테이블)
	 * @return : GridPagingResDto
	 * @description : 마케팅 채널 조회 - 조건 관리를 통해 마케팅 채널 조회
	 */
	@RequestMapping(value = "/getChannel.do")
	public @ResponseBody
	GridPagingResDto<SystemChannelResDto> getChannel(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemChannelReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		//로그인 여부 체크 
		this.authhelper.checkLoginSession(request, response);

		return systemChannelService.getChannel(mcr);
	}
	
	/**
	 * @programId : MKT_CHL_P03
	 * @name : removeImgOption
	 * @date : 2015.11. 19.
	 * @author : 박지열
	 * @table : mkt_chnl_capa (채널 용량 관리 테이블)
	 * @return : StatusResDto
	 * @description : 콘텐츠 파일 옵션 삭제
	 */
	@RequestMapping(value="/removeImgOption.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeImgOption(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemImgOptionDeleteReqDto midr) {
		LogUtil.param(this.getClass(), midr);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		midr.setMemId(loginInfo.getId());

		return systemChannelService.removeImgOption(midr);
	}
	
	/**
	 * @programId : MKT_CHL_002
	 * @name : getDetailChannel
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_channel (마케팅 채널 관리 테이블)
	 * @return : List<MKTChannelResponseDTO>
	 * @description : 마케팅 채널 상제 조회 - 마케팅 채널 선택 후 클릭 시 나오는 정보
	 */
	@RequestMapping(value = "/DetailgetChannel.do")
	public @ResponseBody
	SystemChannelDetailResDto getDetailChannel(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemChannelDetailReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		authhelper.checkLoginSession(request, response);

		return systemChannelService.getDetailChannel(mcr);
	}
	
	/**
	 * @programId : MKT_CHL_002
	 * @name : editResponseChannel
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_channel (마케팅 채널 관리 테이블)
	 * @return : StatusResDto
	 * @description : 마케팅 채널 수정 - 마케팅 채널 선택 후 선택 채널 수정
	 */
	@RequestMapping(value = "/editChannel.do")
	public @ResponseBody
	StatusResDto editResponseChannel(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemChannelReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
								
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mcr.setMemId(loginInfo.getId());
		
		return systemChannelService.editResponseChannel(mcr);
	}
	
	/**
	 * @programId : MKT_CHL_002
	 * @name : getChannelCheck
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_chnl_mst (채널 관리 테이블)
	 * @return : MKTChannelResponseDTO
	 * @description : 콘텐츠 유형으로 추가되어 있는 콘텐츠가 잇는지 확인.
	 */
	@RequestMapping(value = "/getChannelCheck.do", method = RequestMethod.POST)
	public @ResponseBody
	SystemChannelResDto getChannelCheck(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemChannelReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
		
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		//mcr.setAccountId(loginInfo.getAccountOrgId());
		SystemChannelResDto rtnValue = new SystemChannelResDto();
		systemChannelService.getChannelCheck(mcr);
		
		return rtnValue;
	}
	
	/**
	 * @programId : MKT_CHL_002
	 * @name : setChannel
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_channel (마케팅 채널 관리 테이블)
	 * @return : StatusResDto
	 * @description : 마케팅 채널 등록 - 신규 버튼 클릭 후 마케팅 채널 등록
	 */
	@RequestMapping(value = "/setChannel.do")
	public @ResponseBody
	StatusResDto setChannel(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemChannelInsertReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
				
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mcr.setMemId(loginInfo.getId());
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		//mcr.setAccountId(loginInfo.getAccountOrgId());
		
		return systemChannelService.setChannel(mcr);
	}
	
	@RequestMapping(value="/deleteSnsAdtnInfo.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto deleteSnsAdtnInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDeleteSnsAdtnInfoReqDto mcdr) {
		LogUtil.param(this.getClass(), mcdr);
		
		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
		mcdr.setMemId(loginInfo.getId());

		return systemChannelService.deleteSnsAdtnInfo(mcdr);
	}
	
	/**
	 * @name : getDateInfo
	 * @date : 2015. 12. 31.
	 * @author : 박지열
	 * @table : -
	 * @return : String
	 * @description : 현재 날자 조회
	 */
	@RequestMapping(value="/getDateInfo.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto getDateInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTCommonCodeRequestDTO slir) {

		LogUtil.param(this.getClass(),slir);

		authhelper.checkLoginSession(request, response);

		return systemChannelService.getDateInfo(slir);
	}

	
	/**
	 * @programId : MKT_CHL_001
	 * @name : setChannelStore
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_channel (마케팅 채널 관리 테이블)
	 * @return : StatusResDto
	 * @description : 채널 용량 조회 - 각 채널별 용량 조회
	 */
	@RequestMapping(value = "/getChannelStore.do")
	public @ResponseBody
	GridPagingResDto<SystemChannelcapaResDto> getChannelStore(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemChannelcapaReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		authhelper.checkLoginSession(request, response);
		
		return systemChannelService.getChannelStore(mcr);
	}
	
	/**
	 * @programId : MKT_CHL_003
	 * @name : removeCapa
	 * @date : 2015.11. 19.
	 * @author : 박지열
	 * @table : mkt_chnl_capa (채널 용량 관리 테이블)
	 * @return : StatusResDto
	 * @description : 콘텐츠 용량 옵션 삭제
	 */
	@RequestMapping(value="/removeCapa.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeCapa(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemChannelcapaDeleteReqDto mcdr) {
		LogUtil.param(this.getClass(), mcdr);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mcdr.setMemId(loginInfo.getId());

		return systemChannelService.removeCapa(mcdr);
	}
	
	/**
	 * @programId : MKT_CHL_P02
	 * @name : getChannelOrg
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : account (account 관리 테이블)
	 * @return : GridPagingResDto
	 * @description : 캠페인 실행 업체 조회
	 */
	@RequestMapping(value = "/getChannelOrg.do")
	public @ResponseBody
	GridPagingResDto<SystemAccountResDto> getChannelOrg(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemChannelReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		//로그인 여부 체크
		authhelper.checkLoginSession(request, response);
		
		return systemChannelService.getChannelOrg(mcr);
	}
	
	/**
	 * @name : getSnsAdtnInfoList
	 * @date : 2017. 4. 28.
	 * @author : jun.lee
	 * @return : GridPagingResDto
	 * @description : 소셜부가정보 리스트 출력
	 */
	@RequestMapping(value = "/getSnsAdtnInfoList.do")
	public @ResponseBody
	GridPagingResDto<SystemSnsAdtnInfoResDto> getSnsAdtnInfoList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemSnsAdtnInfoReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		authhelper.checkLoginSession(request, response);
		
		return systemChannelService.getSnsAdtnInfoList(mcr);
	}
	
	/**
	 * @programId : MKT_CHL_003
	 * @name : geImgOption
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_chnl_capa (마케팅 채널 용량 관리 테이블)
	 * @return : GridPagingResponseDTO
	 * @description : 채널 용량 파일 옵션 조회 - 각 채널별 용량 조회
	 */
	@RequestMapping(value = "/getImgOption.do")
	public @ResponseBody
	GridPagingResDto<SystemImgOptionListResDto> getImgOption(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemImgOptionListReqDto mior) {
		LogUtil.param(this.getClass(), mior);
		authhelper.checkLoginSession(request, response);
		
		return systemChannelService.getImgOption(mior);
	}

	/**
	 * @programId : MKT_CHL_004
	 * @name : editImgOption
	 * @date : 2015. 10. 26.
	 * @author : 박지열
	 * @table : mkt_conts_type_chnl_rel (채널 용량 관리 테이블)
	 * @return : StatusResponseDTO
	 * @description : 선택 채널의 파일 option 수정
	 */
	@RequestMapping(value = "/editImgOption.do")
	public @ResponseBody
	StatusResDto editImgOption(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemImgOptionlUpdateReqDto miou) {
		LogUtil.param(this.getClass(), miou);
		
		//로그인 여부 체크
		authhelper.checkLoginSession(request, response);
		
		return systemChannelService.editImgOption(miou);
	}
	
	/**
	 * @programId : MKT_CHL_P03
	 * @name : getContypeId
	 * @date : 2015.11. 19.
	 * @author : 박지열
	 * @table : mkt_chnl (채널 관리 테이블)
	 * @return : MKTImgOptionResponseDTO
	 * @description : 채널에 설정된 콘텐츠 유형 조회
	 */
	@RequestMapping(value="/getContypeId.do", method = RequestMethod.POST)
	public @ResponseBody
	SystemImgOptionResDto getContypeId(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemChannelReqDto mcdr) {
		LogUtil.param(this.getClass(), mcdr);
		
		SystemImgOptionResDto resDto = new SystemImgOptionResDto();
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mcdr.setMemId(loginInfo.getId());
		//mcdr.setAccountId(loginInfo.getAccountOrgId());
		
		resDto = systemChannelService.getContypeId(mcdr);
		
		resDto.setSuccess(true);

		return resDto;
	}
	
	/**
	 * @programId : MKT_CHL_004
	 * @name : setImgOption
	 * @date : 2015. 10. 26.
	 * @author : 박지열
	 * @table : mkt_conts_type_chnl_rel (채널 용량 관리 테이블)
	 * @return : StatusResponseDTO
	 * @description : 선택 채널의 Image option 추가.
	 */
	@RequestMapping(value = "/setImgOption.do")
	public @ResponseBody
	StatusResDto setImgOption(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemImgOptionlInsertReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		//로그인 여부 체크
		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
		mcr.setMemId(loginInfo.getId());
		
		return systemChannelService.setImgOption(mcr);
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
	public @ResponseBody
	List<SystemImgOptionResDto> getImageOptionList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemImgOptionReqDto mior) {
	   LogUtil.param(this.getClass(), mior);
	   
	   //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
	   LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
	   
	   //mior.setAccntId(loginInfo.getAccountOrgId());
	 				 	
	   return systemChannelService.getImageOptionList(mior);
	
	}
	
	/**
	 * @programId : MKT_CHL_001
	 * @name : setChannelStore
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_channel (마케팅 채널 관리 테이블)
	 * @return : StatusResponseDTO
	 * @description : 채널 용량 추가 - 각 채널별 용량 추가
	 */
	@RequestMapping(value = "/setChannelStore.do")
	public @ResponseBody
	StatusResDto setChannelStore(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemChannelcapaReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
						
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mcr.setMemId(loginInfo.getId());
		
		return systemChannelService.setChannelStore(mcr);
	}
	
	/**
	 * @programId : MKT_CHL_P01
	 * @name : editCapaChannel
	 * @date : 2015. 10. 26.
	 * @author : 박지열
	 * @table : mkt_conts_type_chnl_rel (채널 용량 관리 테이블)
	 * @return : StatusResponseDTO
	 * @description : 선택 용량 정보 수정
	 */
	@RequestMapping(value = "/editCapaChannel.do")
	public @ResponseBody
	StatusResDto editCapaChannel(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemChannelcapaReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
								
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mcr.setMemId(loginInfo.getId());
		
		return systemChannelService.editCapaChannel(mcr);
	}
	
	/**
	 * @programId : MKT_CHL_P01
	 * @name : getDetailCapa
	 * @date : 2015. 10. 26.
	 * @author : 박지열
	 * @table : mkt_conts_type_chnl_rel (채널 용량 관리 테이블)
	 * @return : MKTChannelcapaResponseDTO
	 * @description : 선택 용량 상세 조회
	 */
	@RequestMapping(value = "/getDetailCapa.do")
	public @ResponseBody
	SystemChannelcapaResDto getDetailCapa(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemChannelcapaReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		//로그인 여부 체크
		authhelper.checkLoginSession(request, response);

		return systemChannelService.getDetailCapa(mcr);
	}
	
	/**
	 * @programId : MKT_CHL_003
	 * @name : getImgDetailOption
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_chnl_capa (마케팅 채널 용량 관리 테이블)
	 * @return : GridPagingResponseDTO
	 * @description : 채널 용량 파일 옵션 상세 조회
	 */
	@RequestMapping(value = "/getImgDetailOption.do")
	public @ResponseBody
	SystemImgOptionResDto getImgDetailOption(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemImgOptionReqDto mior) {
		LogUtil.param(this.getClass(), mior);
		authhelper.checkLoginSession(request, response);


		return systemChannelService.getImgDetailOption(mior);
	}
	
	/**
	 * @name : insertSnsAdtnInfo
	 * @date : 2017. 5. 2.
	 * @author : jun.lee
	 * @return : StatusResponseDTO
	 * @description : 소셜부가정보 추가
	 */
	@RequestMapping(value = "/insertSnsAdtnInfo.do")
	public @ResponseBody
	StatusResDto insertSnsAdtnInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemInsertSnsAdtnInfoReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		//로그인 여부 체크
		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
		mcr.setMemId(loginInfo.getId());
		
		return systemChannelService.insertSnsAdtnInfo(mcr);
	}
	
	/**
	 * @name : getDetailSnsAdtnInfo
	 * @date : 2017. 5. 2.
	 * @author : jun.lee
	 * @return : MKTGetDetailSnsAdtnInfoResponseDTO
	 * @description : 소셜부가정보 상세
	 */
	@RequestMapping(value = "/getDetailSnsAdtnInfo.do")
	public @ResponseBody
	SystemGetDetailSnsAdtnInfoResDto getDetailSnsAdtnInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemSnsAdtnInfoReqDto mcr) {
		
		LogUtil.param(this.getClass(), mcr);
		
		authhelper.checkLoginSession(request, response);
		
		return systemChannelService.getDetailSnsAdtnInfo(mcr);
	}
	
	/**
	 * @name : updateSnsAdtnInfo
	 * @date : 2017. 5. 2.
	 * @author : jun.lee
	 * @return : StatusResponseDTO
	 * @description : 소셜부가정보 수정
	 */
	@RequestMapping(value = "/updateSnsAdtnInfo.do")
	public @ResponseBody
	StatusResDto updateSnsAdtnInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemInsertSnsAdtnInfoReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		//로그인 여부 체크
		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
		mcr.setMemId(loginInfo.getId());
		
		return systemChannelService.updateSnsAdtnInfo(mcr);
	}
	
}

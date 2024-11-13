package com.icignal.loyalty.tiers.tiermaster.controller;

import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyDelTierChnlReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyDelTierupMatrixReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyEditTierBnftReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyEditTierChnlReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyEditTierDtlReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyEditTierGroupListReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyEditTierupMatrixReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyGetMbrMstPopReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyGetTierBnftListReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyGetTierChnlListReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyGetTierGroupListReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyGetTierGrpDtlListReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyGetTierupMatrixListReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoySetTierBnftReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoySetTierChnlReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoySetTierDtlReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoySetTierGroupListReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierBnftReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierCondListReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierCondReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierGroupDetailReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierGrpDsMasterReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierGrpJobDetailReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierGrpJobMasterReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierNewPageReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierRuleMasterReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyDataSetItemListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyDataSetListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyGetMbrMstPopResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyGetTierBnftListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyGetTierChnlListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyGetTierGroupListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyGetTierGrpDtlListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyGetTierupMatrixListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierBnftDetailResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierBnftListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierCondListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierGroupDetailResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierGrpDsListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierGrpJobDetailResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierGrpJobListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierListNewPageResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierListNewResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierRuleResDto;
import com.icignal.loyalty.tiers.tiermaster.service.LoyTiersService;


/*
 * 1. 클래스명	: LoyTiersController
 * 2. 파일명	: LoyTiersController.java
 * 3. 패키지명	: com.icignal.loyalty.tiers.tiermaster.controller
 * 4. 작성자명	: 이원준
 * 5. 작성일자	: 2016. 11. 9.
 */
/**
 * <PRE>
 * 1. 설명
 *  기준정보 - 등급 controller
 * </PRE>
 */ 
@Controller 
@RequestMapping("/loyalty/membership/tiers")
public class LoyTiersController extends BaseController {

		@Autowired
		private LoyTiersService loyTiersService;
		
		@Autowired
		AuthHelper authHelper;
		
		@Override
		@RequestMapping(value = "/popup/{name:.+}", method = RequestMethod.GET)
		public String NavigatePopMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
			LogUtil.debug("NavigatePopMenu start.....");
		
			RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
			Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
			String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
			String respUrl = requestPath + "/popup/" +  name + ".modal-tiles";

			if( checkProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
			return null;
		}
		
		@Override
		@RequestMapping(value = "/include/{name:.+}", method = RequestMethod.GET)
		public String NavigateIncludeMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
			RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
			Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
			String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
			String respUrl = requestPath + "/include/" + name + ".include-tiles";
			if( checkIncludeProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
			return null;
			
		}

		/**
		 *
		 * @programId : PLOY_101
		 * @name : getTierGroupList
		 * @date : 2016. 11. 8.
		 * @author : 이원준
		 * @table : loy_tier_group, loy_tiers
		 * @return :
		 * @description : 등급 그룹 목록 조회
		 */
		@RequestMapping(value = "/getTierGroupList.do", method = RequestMethod.POST)
		public @ResponseBody GridPagingResDto<LoyGetTierGroupListResDto> getTierGroupList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetTierGroupListReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.getTierGroupList(reqDto);
		}

		/**
		 *
		 * @programId : PLOY_102
		 * @name : getTierGrpDtl
		 * @date : 2016. 11. 9.
		 * @author : 이원준
		 * @table : loy_tier_group, loy_tiers
		 * @return : LoyGetTierGroupListResDto
		 * @description : 등급그룹 조회
		 */
		@RequestMapping(value = "/getTierGrpDtl.do", method = RequestMethod.POST)
		public @ResponseBody LoyGetTierGroupListResDto getTierGrpDtl(HttpServletRequest request, HttpServletResponse response,
				@RequestBody LoyGetTierGroupListReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.getTierGrpDtl(reqDto);
		}

		/**
		 *
		 * @programId : PLOY_102
		 * @name : setTierGrp
		 * @date : 2016. 11. 11.
		 * @author : 이원준
		 * @table : loy_tier_group
		 * @return :
		 * @description : 등급그룹 저장
		 */
		@RequestMapping(value = "/setTierGrp.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto setTierGrp(HttpServletRequest request, HttpServletResponse response,
				@RequestBody LoySetTierGroupListReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.setTierGrp(reqDto);
		}

		/**
		 *
		 * @programId : PLOY_102
		 * @name : editTierGrp
		 * @date : 2016. 11. 11.
		 * @author : 이원준
		 * @table : loy_tier_group
		 * @return :
		 * @description : 등급그룹 수정
		 */
		@RequestMapping(value = "/editTierGrp.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto editTierGrp(HttpServletRequest request, HttpServletResponse response,
				@RequestBody LoyEditTierGroupListReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.editTierGrp(reqDto);
		}

		/**
		 *
		 * @programId : POP_905
		 * @name : getTierListPop
		 * @date : 2016. 11. 14.
		 * @author : 이원준
		 * @table : loy_tiers
		 * @return :
		 * @description : 등급목록 팝업 조회
		 */
		@RequestMapping(value = "/getTierListPop.do", method = RequestMethod.POST)
		public @ResponseBody GridPagingResDto<LoyGetTierGrpDtlListResDto> getTierListPop(HttpServletRequest request, HttpServletResponse response,
				@RequestBody LoyGetTierGrpDtlListReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.getTierListPop(reqDto);
		}

		/**
		 *
		 * @programId : PLOY_103
		 * @name : getTierDtlList
		 * @date : 2016. 11. 11.
		 * @author : 이원준
		 * @table : loy_tiers
		 * @return :
		 * @description : 등급상세 목록 조회
		 */
		@RequestMapping(value = "/getTierDtlList.do", method = RequestMethod.POST)
		public @ResponseBody GridPagingResDto<LoyGetTierGrpDtlListResDto> getTierDtlList(HttpServletRequest request, HttpServletResponse response,
				@RequestBody LoyGetTierGrpDtlListReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.getTierDtlList(reqDto);
		}

		/**
		 *
		 * @programId : PLOY_103
		 * @name : getTierDtl
		 * @date : 2016. 11. 14.
		 * @author : 이원준
		 * @table : loy_tiers
		 * @return :
		 * @description : 등급 그룹 상세(탭)-등급 목록 조회
		 */
		@RequestMapping(value = "/getTierDtl.do", method = RequestMethod.POST)
		public @ResponseBody LoyGetTierGrpDtlListResDto getTierDtl(HttpServletRequest request, HttpServletResponse response,
				@RequestBody LoyGetTierGrpDtlListReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.getTierDtl(reqDto);
		}

		/**
		 *
		 * @programId : PLOY_103
		 * @name : getTierDtl
		 * @date : 2016. 11. 14.
		 * @author : 이원준
		 * @table : loy_tiers
		 * @return :
		 * @description : 등급 그룹 상세(탭)-등급 중복 순서_기간 조회
		 */
		@RequestMapping(value = "/chkValid.do", method = RequestMethod.POST)
		public @ResponseBody LoyGetTierGrpDtlListResDto chkValid(HttpServletRequest request, HttpServletResponse response,
				@RequestBody LoySetTierDtlReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.chkValid(reqDto);
		}

		/**
		 *
		 * @programId : PLOY_103
		 * @name : setTierDtl
		 * @date : 2016. 11. 14.
		 * @author : 이원준
		 * @table : loy_tiers
		 * @return :
		 * @description : 등급 그룹 상세(탭)-등급 목록 저장
		 */
		@RequestMapping(value = "/setTierDtl.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto setTierDtl(HttpServletRequest request, HttpServletResponse response,
				@RequestBody LoySetTierDtlReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.setTierDtl(reqDto);
		}

		/**
		 *
		 * @programId : PLOY_103
		 * @name : editTierDtl
		 * @date : 2016. 11. 14.
		 * @author : 이원준
		 * @table : loy_tiers
		 * @return :
		 * @description : 등급 그룹 상세(탭)-등급 목록 수정
		 */
		@RequestMapping(value = "/editTierDtl.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto editTierDtl(HttpServletRequest request, HttpServletResponse response,
				@RequestBody LoyEditTierDtlReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.editTierDtl(reqDto);
		}

		/**
		 *
		 * @programId : PLOY_104
		 * @name : getTierChnlList
		 * @date : 2016. 11. 15.
		 * @author : 이원준
		 * @table : loy_tier_grp_chnl, loy_channel
		 * @return :
		 * @description : 등급 그룹 상세(탭)-채널 목록 조회
		 */
		@RequestMapping(value = "/getTierChnlList.do", method = RequestMethod.POST)
		public @ResponseBody GridPagingResDto<LoyGetTierChnlListResDto> getTierChnlList(HttpServletRequest request, HttpServletResponse response,
				@RequestBody LoyGetTierChnlListReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.getTierChnlList(reqDto);
		}

		/**
		 *
		 * @programId : PLOY_104
		 * @name : setTierChnl
		 * @date : 2016. 11. 15.
		 * @author : 이원준
		 * @table : loy_tier_grp_chnl, loy_channel
		 * @return :
		 * @description : 등급 그룹 상세(탭)-채널 목록 저장
		 */
		@RequestMapping(value = "/setTierChnl.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto setTierChnl(HttpServletRequest request, HttpServletResponse response,
				@RequestBody LoySetTierChnlReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.setTierChnl(reqDto);
		}

		/**
		 *
		 * @programId : PLOY_104
		 * @name : editTierChnl
		 * @date : 2016. 11. 15.
		 * @author : 이원준
		 * @table : loy_tier_grp_chnl, loy_channel
		 * @return :
		 * @description : 등급 그룹 상세(탭)-채널 목록 수정
		 */
		@RequestMapping(value = "/editTierChnl.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto editTierChnl(HttpServletRequest request, HttpServletResponse response,
				@RequestBody LoyEditTierChnlReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.editTierChnl(reqDto);
		}

		/**
		 *
		 * @programId : PLOY_104
		 * @name : removeTierChnl
		 * @date : 2016. 11. 15.
		 * @author : 이원준
		 * @table : loy_tier_grp_chnl, loy_channel
		 * @return :
		 * @description : 등급 그룹 상세(탭)-채널 목록 삭제
		 */
		@RequestMapping(value = "/removeTierChnl.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto removeTierChnl(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyDelTierChnlReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.removeTierChnl(reqDto);
		}

		/**
		 *
		 * @programId : PLOY_105
		 * @name : getTierUpMatrixList
		 * @date : 2016. 11. 24.
		 * @author : 이원준
		 * @table : loy_tierup_matrix, loy_tierup_matrix_dtl, loy_tiers
		 * @return :
		 * @description : 등급 그룹 상세(탭)-승급 매트릭스 조회
		 */
		@RequestMapping(value = "/getTierUpMatrixList.do", method = RequestMethod.POST)
		public @ResponseBody GridPagingResDto<LoyGetTierupMatrixListResDto> getTierUpMatrixList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetTierupMatrixListReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.getTierUpMatrixList(reqDto);
		}

		/**
		 *
		 * @programId : PLOY_106
		 * @name : getTierUpMatrix
		 * @date : 2017.01.26
		 * @author : 이원준
		 * @table : loy_tierup_matrix, loy_tierup_matrix_dtl
		 * @return :
		 * @description : 승급 매트릭스 상세조회
		 */
		@RequestMapping(value = "/getTierUpMatrix.do", method = RequestMethod.POST)
		public @ResponseBody LoyGetTierupMatrixListResDto getTierUpMatrix(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetTierupMatrixListReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.getTierUpMatrix(reqDto);
		}

		/**
		 *
		 * @programId : PLOY_106
		 * @name : editTierUpMatrix
		 * @date : 2017.01.26
		 * @author : 이원준
		 * @table : loy_tierup_matrix, loy_tierup_matrix_dtl
		 * @return :
		 * @description : 승급 매트릭스 저장
		 */
		@RequestMapping(value = "/editTierUpMatrix.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto editTierUpMatrix(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyEditTierupMatrixReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.editTierUpMatrix(reqDto);
		}

		/**
		 *
		 * @programId : PLOY_106
		 * @name : removeTierupMatrix
		 * @date : 2017.01.26
		 * @author : 이원준
		 * @table : loy_tierup_matrix, loy_tierup_matrix_dtl
		 * @return :
		 * @description : 승급 매트릭스 상세 삭제
		 */
		@RequestMapping(value = "/removeTierupMatrix.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto removeTierupMatrix(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyDelTierupMatrixReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.removeTierupMatrix(reqDto);
		}

		/**
		 *
		 * @programId : POP_902
		 * @name : getTierUpMatrixList
		 * @date : 2016. 11. 24.
		 * @author : 이원준
		 * @table : loy_mbr, loy_chnl_mbr, loy_cust, loy_tiers
		 * @return :
		 * @description : 회원마스터 조회
		 */
		@RequestMapping(value = "/getMbrMstPop.do", method = RequestMethod.POST)
		public @ResponseBody GridPagingResDto<LoyGetMbrMstPopResDto> getMbrMstPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetMbrMstPopReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.getMbrMstPop(reqDto);
		}

		/**
		 *
		 * @programId : PLOY_102
		 * @name : getTierBnftList
		 * @date : 2016. 12. 05
		 * @author : 이원준
		 * @table : loy_tiers, loy_tier_bnft, mkt_cam_mst
		 * @return :
		 * @description : 등급별 혜택 조회
		 */
		@RequestMapping(value = "/getTierBnftList.do", method = RequestMethod.POST)
		public @ResponseBody GridPagingResDto<LoyGetTierBnftListResDto> getTierBnftList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetTierBnftListReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.getTierBnftList(reqDto);
		}

		/**
		 *
		 * @programId : PLOY_105
		 * @name : getTierBnft
		 * @date : 2016. 11. 24.
		 * @author : 이원준
		 * @table : loy_tier_bnft, loy_tier_bnft_hist
		 * @return :
		 * @description : 등급혜택 조회
		 */
		@RequestMapping(value = "/getTierBnft.do", method = RequestMethod.POST)
		public @ResponseBody LoyGetTierBnftListResDto getTierBnft(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetTierBnftListReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.getTierBnft(reqDto);
		}

		/**
		 *
		 * @programId : PLOY_105
		 * @name : setTierBnft
		 * @date : 2016. 11. 24.
		 * @author : 이원준
		 * @table : loy_tier_bnft, loy_tier_bnft_hist
		 * @return :
		 * @description : 등급혜택 저장
		 */
		@RequestMapping(value = "/setTierBnft.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto setTierBnft(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySetTierBnftReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.setTierBnft(reqDto);
		}

		/**
		 *
		 * @programId : PLOY_105
		 * @name : editTierBnft
		 * @date : 2016. 11. 24.
		 * @author : 이원준
		 * @table : loy_tier_bnft, loy_tier_bnft_hist
		 * @return :
		 * @description : 등급혜택 수정
		 */
		@RequestMapping(value = "/editTierBnft.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto editTierBnft(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyEditTierBnftReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.editTierBnft(reqDto);
		}



		/**
		 *
		 * @programId :
		 * @name : removeTier
		 * @date : 2017. 03. 20.
		 * @author : 이성원
		 * @table : loy_tier_bnft, loy_tier_bnft_hist
		 * @return :
		 * @description : 등급그룹 삭제
		 */
		@RequestMapping(value = "/removeTierGrp.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto removeTier(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyEditTierGroupListReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.removeTierGrp(reqDto);
		}

		 /*
		  * 1. 메소드명: getTierRuleDetail
		  * 2. 클래스명: LoyTiersController
		  * 3. 작성자명: 
		  * 4. 작성일자: 2020. 2. 21.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param request
		 *   @param response
		 *   @param reqDto
		 *   @return	
		 */
		@RequestMapping(value = "/getTierRuleDetail.do", method = RequestMethod.POST)
		public @ResponseBody LoyGetTierupMatrixListResDto getTierRuleDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetTierupMatrixListReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.getTierRuleDetail(reqDto);
		}

		 /*
		  * 1. 메소드명: saveTierRuleDetail
		  * 2. 클래스명: LoyTiersController
		  * 3. 작성자명: 
		  * 4. 작성일자: 2020. 2. 21.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param request
		 *   @param response
		 *   @param reqDto
		 *   @return	
		 */
		@RequestMapping(value = "/saveTierRuleDetail.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto saveTierRuleDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyEditTierupMatrixReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.saveTierRuleDetail(reqDto);
		}


		 /*
		  * 1. 메소드명: editTierRuleDetail
		  * 2. 클래스명: LoyTiersController
		  * 3. 작성자명: hr.noh 
		  * 4. 작성일자: 2020. 2. 21.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param request
		 *   @param response
		 *   @param reqDto
		 *   @return	
		 */
		@RequestMapping(value = "/editTierRuleDetail.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto editTierRuleDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyEditTierupMatrixReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

			return loyTiersService.editTierRuleDetail(reqDto);
		}


		 /*
		  * 1. 메소드명: removeTierRuleDetail
		  * 2. 클래스명: LoyTiersController
		  * 3. 작성자명: hr.noh 
		  * 4. 작성일자: 2020. 2. 21.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param request
		 *   @param response
		 *   @param reqDto
		 *   @return	
		 */
		@RequestMapping(value = "/removeTierRuleDetail.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto removeTierRuleDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyEditTierupMatrixReqDto reqDto) {
			LogUtil.param(LoyTiersController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

	        return loyTiersService.removeTierRuleDetail(reqDto);
	    }

	    /**
	     * 그룹별 등급 목록 조회
	     *
	     * @programId :
	     * @name : getTierListByGroup
	     * @date : 2017. 11. 22.
	     * @author : jh.kim
	     * @table :
	     * @return : GridPagingResDto
	     * @description :
	     *
	     * 마케팅 > 오퍼 > 오퍼상세 > 등급차감(탭) > 신규(팝업) > 그룹별 등급 목록 조회
	     */
	    @RequestMapping(value = "/getTierListByGroup.do", method = RequestMethod.POST)
	    public @ResponseBody GridPagingResDto<LoyGetMbrMstPopResDto> getTierListByGroup(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetMbrMstPopReqDto tlr) {
	       LogUtil.param(LoyTiersController.class, tlr);
	       tlr.setLoginInfo(authHelper.checkLoginSession(request, response));

	       return loyTiersService.getTierListByGroup(tlr);
	    }
	    
	     /*
	      * 1. 메소드명: getCondTierList
	      * 2. 클래스명: LoyTiersController
	      * 3. 작성자명: 
	      * 4. 작성일자: 2020. 2. 28.
	      */
	    /**
	     * <PRE>
	     * 1. 설명
	     *		
	     * 2. 사용법
	     *		
	     * </PRE>
	     *   @param request
	     *   @param response
	     *   @param tlr
	     *   @return	
	     */
	    @RequestMapping(value = "/getCondTierList.do", method = RequestMethod.POST)
	    public @ResponseBody GridPagingResDto<LoyTierListResDto> getCondTierList(
	            HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierCondListReqDto tlr) {
	        LogUtil.param(LoyTiersController.class, tlr);

	        tlr.setLoginInfo(authHelper.checkLoginSession(request, response));

	        return loyTiersService.getCondTierList(tlr);
	    }

	    
	    /**
	    * @programId :
	    * @name : getTierCondList
	    * @date : 2019. 4. 2.
	    * @author : hy.jun
	    * @table :
	    * @return : GridPagingResDto
	    * @description : 등급 그룹 상세(탭)-승급 룰 조회
	    */
	    @RequestMapping(value = "/getTierCondList.do", method = RequestMethod.POST)
	    public @ResponseBody GridPagingResDto<LoyTierCondListResDto> getTierCondList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierCondListReqDto tlr) {
	    	LogUtil.param(this.getClass(), tlr);
		    tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
		    
	    	return loyTiersService.getTierCondList(tlr);
	    }
	    
	    /**
	    * @programId :
	    * @name : removeTiersCond
	    * @date : 2019. 4. 8.
	    * @author : hy.jun
	    * @table :
	    * @return : GridPagingResDto
	    * @description : 등급 그룹 상세(탭)-승급 룰 삭제
	    */
	    @RequestMapping(value = "/removeTiersCondAll.do", method = RequestMethod.POST)
	    public @ResponseBody StatusResDto removeTiersCondAll(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierCondReqDto tlr) {
	    	LogUtil.param(this.getClass(), tlr);
	    	tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
	    	
	    	return loyTiersService.removeTiersCondAll(tlr);
	    }
	    
	    /**
	    * @programId :
	    * @name : editTiersCond
	    * @date : 2019. 4. 8.
	    * @author : hy.jun
	    * @table :
	    * @return : StatusResDto
	    * @description : 등급 그룹 상세(탭)-승급 룰 수정
	    */
	    @RequestMapping(value = "/editTiersCond.do", method = RequestMethod.POST)
	    public @ResponseBody StatusResDto editTiersCond(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierCondReqDto tlr) {
	    	LogUtil.param(this.getClass(), tlr);
	    	tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
	    	
	    	return loyTiersService.editTiersCond(tlr);
	    }
	    /**
	    * @programId :
	    * @name : getTiersCond
	    * @date : 2019. 4. 8.
	    * @author : hy.jun
	    * @table :
	    * @return : LOYTierCondRequestDTO
	    * @description : 등급 그룹 상세(탭)-승급 룰 상세 조회
	    */
	    @RequestMapping(value = "/getTiersCond.do", method = RequestMethod.POST)
	    public @ResponseBody LoyTierCondReqDto getTiersCond(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierCondReqDto tlr) {
	    	LogUtil.param(this.getClass(), tlr);
	    	tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
	    	
	    	return loyTiersService.getTiersCond(tlr);
	    }
	    
	    /**
		    * @programId :
		    * @name : getTierCondList
		    * @date : 2019. 4. 2.
		    * @author : hy.jun
		    * @table :
		    * @return : GridPagingResDto
		    * @description : 등급 그룹 상세(탭)-승급 룰 조회
		    */
		    @RequestMapping(value = "/getTierGroupListNew.do", method = RequestMethod.POST)
		    public @ResponseBody GridPagingResDto<LoyTierListNewResDto> getTierGroupListNew(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetTierGroupListReqDto tlr) {
		    	LogUtil.param(this.getClass(), tlr);
			    tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
			    
		    	return loyTiersService.getTierGroupListNew(tlr);
		    }
		    
		/**
			* @programId :
			* @name : getTiersCond
			* @date : 2019. 4. 8.
			* @author : hy.jun
			* @table :
			* @return : LOYTierCondRequestDTO
			* @description : 등급 그룹 상세(탭)-승급 룰 상세 조회
			*/
		    @RequestMapping(value = "/getTierGroupDetailNew.do", method = RequestMethod.POST)
			public @ResponseBody LoyTierGroupDetailResDto getTierGroupDetailNew(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetTierGroupListReqDto tlr) {
		    	LogUtil.param(this.getClass(), tlr);
			    tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
			    	
			    return loyTiersService.getTierGroupDetailNew(tlr);
			}
		    
		    /**
			    * @programId :
			    * @name : editTiersCond
			    * @date : 2019. 4. 8.
			    * @author : hy.jun
			    * @table :
			    * @return : StatusResDto
			    * @description : 등급 그룹 상세(탭)-승급 룰 수정
			    */
			    @RequestMapping(value = "/savetierGroup.do", method = RequestMethod.POST)
			    public @ResponseBody StatusResDto savetierGroup(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierGroupDetailReqDto tlr) {
			    	LogUtil.param(this.getClass(), tlr);
			    	tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
			    	
			    	return loyTiersService.savetierGroup(tlr);
			    }
			    
			    /**
				    * @programId :
				    * @name : editTiersCond
				    * @date : 2019. 4. 8.
				    * @author : hy.jun
				    * @table :
				    * @return : StatusResDto
				    * @description : 등급 그룹 상세(탭)-승급 룰 수정
				    */
				    @RequestMapping(value = "/modifytierGroup.do", method = RequestMethod.POST)
				    public @ResponseBody StatusResDto modifytierGroup(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierGroupDetailReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
				    	tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
				    	
				    	return loyTiersService.modifytierGroup(tlr);
				    }
				    
				    @RequestMapping(value = "/getDatasetList.do", method = RequestMethod.POST)
					public @ResponseBody GridPagingResDto<LoyDataSetListResDto> getDatasetList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetTierGroupListReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
					    tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
					    	
					    return loyTiersService.getDatasetList(tlr);
					}
				    
				    @RequestMapping(value = "/getTierListNewPage.do", method = RequestMethod.POST)
					public @ResponseBody GridPagingResDto<LoyTierListNewPageResDto> getTierListNewPage(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierNewPageReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
					    tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
					    	
					    return loyTiersService.getTierListNewPage(tlr);
					}
				    
				    @RequestMapping(value = "/getTierDetail.do", method = RequestMethod.POST)
					public @ResponseBody LoyTierListNewPageResDto getTierDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierNewPageReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
					    tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
					    	
					    return loyTiersService.getTierDetail(tlr);
					}
				    
				    @RequestMapping(value = "/saveTier.do", method = RequestMethod.POST)
				    public @ResponseBody StatusResDto saveTier(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierNewPageReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
				    	tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
				    	
				    	return loyTiersService.saveTier(tlr);
				    }
				    
				    @RequestMapping(value = "/modifyTier.do", method = RequestMethod.POST)
				    public @ResponseBody StatusResDto modifyTier(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierNewPageReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
				    	tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
				    	
				    	return loyTiersService.modifyTier(tlr);
				    }
				    
				    @RequestMapping(value = "/getTierBnftListNew.do", method = RequestMethod.POST)
					public @ResponseBody GridPagingResDto<LoyTierBnftListResDto> getTierBnftListNew(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierNewPageReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
					    tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
					    	
					    return loyTiersService.getTierBnftListNew(tlr);
					}
				    
				    @RequestMapping(value = "/getTierBnftDetail.do", method = RequestMethod.POST)
					public @ResponseBody LoyTierBnftDetailResDto getTierBnftDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierNewPageReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
					    tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
					    	
					    return loyTiersService.getTierBnftDetail(tlr);
					}
	
				    @RequestMapping(value = "/saveTierBnft.do", method = RequestMethod.POST)
				    public @ResponseBody StatusResDto saveTierBnft(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierBnftReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
				    	tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
				    	
				    	return loyTiersService.saveTierBnft(tlr);
				    }
				    
				    @RequestMapping(value = "/modifyTierBnft.do", method = RequestMethod.POST)
				    public @ResponseBody StatusResDto modifyTierBnft(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierBnftReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
				    	tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
				    	
				    	return loyTiersService.modifyTierBnft(tlr);
				    }
				    
				    @RequestMapping(value = "/removeTierBnft.do", method = RequestMethod.POST)
				    public @ResponseBody StatusResDto removeTierBnft(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierNewPageReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
				    	tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
				    	
				    	return loyTiersService.removeTierBnft(tlr);
				    }
				    
				    @RequestMapping(value = "/getTierGroupJobList.do", method = RequestMethod.POST)
					public @ResponseBody GridPagingResDto<LoyTierGrpJobListResDto> getTierGroupJobList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierNewPageReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
					    tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
					    	
					    return loyTiersService.getTierGroupJobList(tlr);
					}
				    
				    @RequestMapping(value = "/getTierGrpJobDetail.do", method = RequestMethod.POST)
					public @ResponseBody LoyTierGrpJobDetailResDto getTierGrpJobDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierGrpJobMasterReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
					    tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
					    	
					    return loyTiersService.getTierGrpJobDetail(tlr);
					}
				    
				    @RequestMapping(value = "/saveTierGrpJob.do", method = RequestMethod.POST)
				    public @ResponseBody StatusResDto saveTierGrpJob(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierGrpJobDetailReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
				    	tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
				    	
				    	return loyTiersService.saveTierGrpJob(tlr);
				    }
				    
				    @RequestMapping(value = "/modifyTierGrpJob.do", method = RequestMethod.POST)
				    public @ResponseBody StatusResDto modifyTierGrpJob(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierGrpJobDetailReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
				    	tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
				    	
				    	return loyTiersService.modifyTierGrpJob(tlr);
				    }
				    
				    @RequestMapping(value = "/getTierGrpDsListNew.do", method = RequestMethod.POST)
				    public @ResponseBody GridPagingResDto<LoyTierGrpDsListResDto> getTierGrpDsListNew(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierGrpDsMasterReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
				    	tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
				    	
				    	return loyTiersService.getTierGrpDsListNew(tlr);
				    }
				    
				    @RequestMapping(value = "/getTierGrpDsDetail.do", method = RequestMethod.POST)
				    public @ResponseBody LoyTierGrpDsListResDto getTierGrpDsDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierGrpDsMasterReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
				    	tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
				    	
				    	return loyTiersService.getTierGrpDsDetail(tlr);
				    }
				    
				    @RequestMapping(value = "/saveTierGrpDs.do", method = RequestMethod.POST)
				    public @ResponseBody StatusResDto saveTierGrpDs(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierGrpDsMasterReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
				    	tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
				    	
				    	return loyTiersService.saveTierGrpDs(tlr);
				    }
				    
				    @RequestMapping(value = "/modifyTierGrpDs.do", method = RequestMethod.POST)
				    public @ResponseBody StatusResDto modifyTierGrpDs(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierGrpDsMasterReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
				    	tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
				    	
				    	return loyTiersService.modifyTierGrpDs(tlr);
				    }
				    
				    @RequestMapping(value = "/removeTierGrpDs.do", method = RequestMethod.POST)
				    public @ResponseBody StatusResDto removeTierGrpDs(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierGrpDsMasterReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
				    	tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
				    	
				    	return loyTiersService.removeTierGrpDs(tlr);
				    }
				    
				    @RequestMapping(value = "/removeTierGrpJob.do", method = RequestMethod.POST)
				    public @ResponseBody StatusResDto removeTierGrpJob(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierGrpDsMasterReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
				    	tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
				    	
				    	return loyTiersService.removeTierGrpJob(tlr);
				    }
				    
				    @RequestMapping(value = "/getTierGrpDsDatasetList.do", method = RequestMethod.POST)
					public @ResponseBody GridPagingResDto<LoyDataSetListResDto> getTierGrpDsDatasetList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetTierGroupListReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
					    tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
					    	
					    return loyTiersService.getTierGrpDsDatasetList(tlr);
					}
				    
				    @RequestMapping(value = "/getTierRuleListNew.do", method = RequestMethod.POST)
					public @ResponseBody GridPagingResDto<LoyTierRuleResDto> getTierRuleListNew(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierRuleMasterReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
					    tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
					    	
					    return loyTiersService.getTierRuleListNew(tlr);
					}
				    
				    @RequestMapping(value = "/getTierGrpRuleList.do", method = RequestMethod.POST)
					public @ResponseBody LoyTierRuleMasterReqDto getTierGrpRuleList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierRuleMasterReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
					    tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
					    	
					    return loyTiersService.getTierGrpRuleList(tlr);
					}
				    
				    @RequestMapping(value = "/getTierGrpRuleDetailPop.do", method = RequestMethod.POST)
					public @ResponseBody GridPagingResDto<LoyTierRuleResDto> getTierGrpRuleDetailPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierRuleMasterReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
					    tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
					    	
					    return loyTiersService.getTierGrpRuleDetailPop(tlr);
					}
				    
				    @RequestMapping(value = "/getDataSetList.do", method = RequestMethod.POST)
					public @ResponseBody GridPagingResDto<LoyDataSetListResDto> getDataSetList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierRuleMasterReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
					    tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
					    	
					    return loyTiersService.getDataSetList(tlr);
					}
				    
				    @RequestMapping(value = "/getDataSetItemList.do", method = RequestMethod.POST)
					public @ResponseBody GridPagingResDto<LoyDataSetItemListResDto> getDataSetItemList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierRuleMasterReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
					    tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
					    	
					    return loyTiersService.getDataSetItemList(tlr);
					}
				    
				    @RequestMapping(value = "/editTiersRule.do", method = RequestMethod.POST)
					public @ResponseBody StatusResDto editTiersRule(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierRuleMasterReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
					    tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
					    	
					    return loyTiersService.editTiersRule(tlr);
					}
				    
				    @RequestMapping(value = "/getTiersDatasetItemList.do", method = RequestMethod.POST)
					public @ResponseBody GridPagingResDto<LoyDataSetItemListResDto> getTiersDatasetItemList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierRuleMasterReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
					    tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
					    	
					    return loyTiersService.getTiersDatasetItemList(tlr);
					}
				    
				    @RequestMapping(value = "/removeTierRule.do", method = RequestMethod.POST)
					public @ResponseBody StatusResDto removeTierRule(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierRuleMasterReqDto tlr) {
				    	LogUtil.param(this.getClass(), tlr);
					    tlr.setLoginInfo(authHelper.checkLoginSession(request, response));
					    	
					    return loyTiersService.removeTierRule(tlr);
					}
				    
				    @RequestMapping(value = "/removeTiersGrp.do", method = RequestMethod.POST)
					public @ResponseBody StatusResDto removeTiersGrp(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierNewPageReqDto reqDto) {
						LogUtil.param(LoyTiersController.class, reqDto);
						reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

						return loyTiersService.removeTiersGrp(reqDto);
					}
				    
				    @RequestMapping(value = "/removeTier.do", method = RequestMethod.POST)
					public @ResponseBody StatusResDto removeTier(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierNewPageReqDto reqDto) {
						LogUtil.param(LoyTiersController.class, reqDto);
						reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

						return loyTiersService.removeTier(reqDto);
					}
				    
				    @RequestMapping(value = "/tierBatchCall.do", method = RequestMethod.POST)
					public @ResponseBody StatusResDto tierBatchCall(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierNewPageReqDto reqDto) {
						LogUtil.param(LoyTiersController.class, reqDto);
						reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

						return loyTiersService.tierBatchCall(reqDto);
					}
				    
				    @RequestMapping(value = "/tierInitCall.do", method = RequestMethod.POST)
					public @ResponseBody StatusResDto tierInitCall(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierNewPageReqDto reqDto) {
						LogUtil.param(LoyTiersController.class, reqDto);
						reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

						return loyTiersService.tierInitCall(reqDto);
					}
				    
				    @RequestMapping(value = "/getTierGroupListPop.do", method = RequestMethod.POST)
					public @ResponseBody GridPagingResDto<LoyTierListNewPageResDto> getTierGroupListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierNewPageReqDto reqDto) {
						LogUtil.param(LoyTiersController.class, reqDto);
						reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

						return loyTiersService.getTierGroupListPop(reqDto);
					}
				    
				    @RequestMapping(value = "/getTiersListPop.do", method = RequestMethod.POST)
					public @ResponseBody GridPagingResDto<LoyTierListNewPageResDto> getTiersListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierNewPageReqDto reqDto) {
						LogUtil.param(LoyTiersController.class, reqDto);
						reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

						return loyTiersService.getTiersListPop(reqDto);
					}
	    
}

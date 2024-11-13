package com.icignal.marketing.realtime.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.marketing.realtime.api.dto.RealCampaignApiDTO;
import com.icignal.marketing.realtime.dto.request.MktCampaignChnlReqDto;
import com.icignal.marketing.realtime.dto.request.MktCampaignStoreReqDto;
import com.icignal.marketing.realtime.dto.request.MktRealTimeCampExecReqDto;
import com.icignal.marketing.realtime.dto.request.MktRealTimeCampaignReqDto;
import com.icignal.marketing.realtime.dto.response.MktCampaignChnlResDto;
import com.icignal.marketing.realtime.dto.response.MktCampaignStoreResDto;
import com.icignal.marketing.realtime.dto.response.MktRTIntactTypeListResDto;
import com.icignal.marketing.realtime.dto.response.MktRealTimeCampExecResDto;
import com.icignal.marketing.realtime.dto.response.MktRealTimeCampaignResDto;
import com.icignal.marketing.realtime.service.MktRealTimeCampaignService;



@Controller
@RequestMapping("/marketing/realtime")
public class MktRealTimeCampaignController extends BaseController {

	
	@Autowired
	private MktRealTimeCampaignService mktRealTimeCampaignService;
	 /**
	    * @programId :
	    * @name : getRealTimeCampExeList
	    * @date : 2020. 6. 3.
	    * @author : yj.choi
	    * @table :
	    * @description : 실시간 캠페인 실행 현황
	    */
	   
	   @RequestMapping(value="/getRealTimeCampExeList.do", method = RequestMethod.POST)
		public @ResponseBody
		GridPagingResDto<MktRealTimeCampaignResDto> getRealTimeCampExeList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktRealTimeCampaignReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);

	        reqDto.setLoginInfo(this.checkLoginSession(request, response));

	        return mktRealTimeCampaignService.getRealTimeCampExeList(reqDto);
	    }
	   
	   /**
	    * @programId :
	    * @name : getRTCampChnlExeList
	    * @date : 2020. 6. 4.
	    * @author : yj.choi
	    * @table :
	    * @description : 실시간 캠페인 채널실행 정보
	    */
	   
	   @RequestMapping(value="/getRTCampChnlExeList.do", method = RequestMethod.POST)
		public @ResponseBody
		GridPagingResDto<MktRealTimeCampaignResDto> getRTCampChnlExeList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktRealTimeCampaignReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);

	        reqDto.setLoginInfo(this.checkLoginSession(request, response));

	        return mktRealTimeCampaignService.getRTCampChnlExeList(reqDto);
	    }
	   
	   
	   /**
	    * @programId :
	    * @name : getRTCampErrorHist
	    * @date : 2020. 6. 4.
	    * @author : yj.choi
	    * @table :
	    * @description : 실시간 캠페인 오류내역조회
	    */
	   
	   @RequestMapping(value="/getRTCampErrorHist.do", method = RequestMethod.POST)
	   public @ResponseBody
	   GridPagingResDto<MktRealTimeCampaignResDto> getRTCampErrorHist(HttpServletRequest request, HttpServletResponse response, @RequestBody MktRealTimeCampaignReqDto reqDto) {
		   LogUtil.param(this.getClass(), reqDto);
		   
		   reqDto.setLoginInfo(this.checkLoginSession(request, response));
		   
		   return mktRealTimeCampaignService.getRTCampErrorHist(reqDto);
	   }
	   
	   
	   
	   /**
	    * @programId :
	    * @name : getRTCampTargetReact
	    * @date : 2020. 6. 4.
	    * @author : yj.choi
	    * @table :
	    * @description : 실시간 캠페인 대상자 반응조회
	    */
	   
	   @RequestMapping(value="/getRTCampTargetReact.do", method = RequestMethod.POST)
	   public @ResponseBody
	   GridPagingResDto<MktRealTimeCampaignResDto> getRTCampTargetReact(HttpServletRequest request, HttpServletResponse response, @RequestBody MktRealTimeCampaignReqDto reqDto) {
		   LogUtil.param(this.getClass(), reqDto);
		   
		   reqDto.setLoginInfo(this.checkLoginSession(request, response));
		   
		   return mktRealTimeCampaignService.getRTCampTargetReact(reqDto);
	   }
	   
	   /**
	    * @programId :
	    * @name : getRealTimeCampaignExecutionList
	    * @date : 2020. 6. 4.
	    * @author : 
	    * @table :
	    * @description : 실시간 캠페인 실행 관리 리스트
	    */
	   
	   @RequestMapping(value="/getRealTimeCampaignExecutionList.do", method = RequestMethod.POST)
	   public @ResponseBody
	   GridPagingResDto<MktRealTimeCampExecResDto> getRealTimeCampaignExecutionList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktRealTimeCampExecReqDto reqDto) {
		   LogUtil.param(this.getClass(), reqDto);
		   
		   reqDto.setLoginInfo(this.checkLoginSession(request, response));
		   
		   return mktRealTimeCampaignService.getRealTimeCampaignExecutionList(reqDto);
	   }
	   
	   /**
	     * 실시간 캠페인 실행 관리 상세
	     *
	     * @param request
	     * @param response
	     * @param param
	     * @return
	     * @programId :
	     * @name : getEventDetail
	     * @date : 2019. 9. 9.
	     * @author : sh.park
	     * @table :
	     * @description : 실시간 캠페인 실행 관리 상세
	     */
	    @RequestMapping(value = "/getRealTimeCampaignExecutionDetail.do", method = RequestMethod.POST)
	    public @ResponseBody
	    MktRealTimeCampExecResDto getRealTimeCampaignExecutionDetail(
	            HttpServletRequest request, HttpServletResponse response, @RequestBody MktRealTimeCampExecReqDto reqDto) {
	    	LogUtil.param(this.getClass(), reqDto);
		   
		    reqDto.setLoginInfo(this.checkLoginSession(request, response));

	        return  mktRealTimeCampaignService.getRealTimeCampaignExecutionDetail(reqDto);
	    }

	    
	    /**
	     * 실시간 캠페인 실행 관리 수정
	     *
	     * @param request
	     * @param response
	     * @param param
	     * @return
	     * @programId :
	     * @name : editRealCampaigExecution
	     * @date : 2019. 9. 9.
	     * @author : sh.park
	     * @table :
	     * @description : 실시간 캠페인 실행 관리 수정
	     */
	    @RequestMapping(value = "/editRealCampaigExecution.do", method = RequestMethod.POST)
	    public @ResponseBody
	    StatusResDto editRealCampaigExecution(
	            HttpServletRequest request, HttpServletResponse response, @RequestBody MktRealTimeCampExecReqDto reqDto) {
	    	LogUtil.param(this.getClass(), reqDto);
		    reqDto.setLoginInfo(this.checkLoginSession(request, response));

	        return mktRealTimeCampaignService.editRealCampaigExecution(reqDto);
	    }
	    
	    /**
	     * 실시간 캠페인 실행 관리 신규 등록
	     *
	     * @param request
	     * @param response
	     * @param param
	     * @return
	     * @programId :
	     * @name : addRealCampaigExecution
	     * @date : 2019. 9. 9.
	     * @author : sh.park
	     * @table :
	     * @description : 실시간 캠페인 실행 관리 신규 등록
	     */
	    @RequestMapping(value = "/addRealCampaigExecution.do", method = RequestMethod.POST)
	    public @ResponseBody
	    StatusResDto addRealCampaigExecution(
	            HttpServletRequest request, HttpServletResponse response, @RequestBody MktRealTimeCampExecReqDto reqDto) {
	    	LogUtil.param(this.getClass(), reqDto);
	    	reqDto.setLoginInfo(this.checkLoginSession(request, response));

	        return mktRealTimeCampaignService.addRealCampaigExecution(reqDto);
	    }
	    
	    
	    /**
	     * 실시간 캠페인 리스트 삭제
	     *
	     * @param request
	     * @param response
	     * @param param
	     * @return
	     * @programId :
	     * @name : removeEventTrigger
	     * @date : 2019. 9. 9.
	     * @author : sh.park
	     * @table :
	     * @description :실시간 캠페인 리스트 삭제
	     */
	    @RequestMapping(value = "/removeRealTimeCampaign.do", method = RequestMethod.POST)
	    public @ResponseBody
	    StatusResDto removeRealTimeCampaign(
	            HttpServletRequest request, HttpServletResponse response, @RequestBody MktRealTimeCampaignReqDto param) {
	    	LogUtil.param(this.getClass(), param);
	    	param.setLoginInfo(this.checkLoginSession(request, response));

	        return mktRealTimeCampaignService.removeRealTimeCampaign(param);
	    }

	    /**
	     * 실시간 캠페인 실행,중지 API 호출
	     *
	     * @param request
	     * @param response
	     * @param param
	     * @return
	     * @programId :
	     * @name : callApiCampaignExecutor
	     * @date : 2019. 9. 10.
	     * @author : sh.park
	     * @table :
	     * @description : 실시간 캠페인 서비스 실행 중단 API 호출
	     */

	    @RequestMapping(value = "/callApiCampaignExecutor.do", method = RequestMethod.POST)
	    public @ResponseBody
	    RealCampaignApiDTO.Response callApiCampaignExecutor(HttpServletRequest request, HttpServletResponse response, @RequestBody MktRealTimeCampExecReqDto param) throws Exception {
	    	LogUtil.param(this.getClass(), param);
	    	param.setLoginInfo(this.checkLoginSession(request, response));
	        return mktRealTimeCampaignService.callApiCampaignExecutor(param);


	    }
	    
	    
	    /**
	     * @programId : PLOY_060_P01
	     * @name : getETIntactTypeList
	     * @date : 2016. 11. 17.
	     * @author : dg.ryu
	     * @table : loy.loy_intact_type
	     * @return :
	     * @description : et 인터랙션 유형 목록 조회
	     */
	    @RequestMapping(value="/getETIntactTypeList.do", method = RequestMethod.POST)
		public @ResponseBody
		GridPagingResDto<MktRTIntactTypeListResDto> getETIntactTypeList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktRealTimeCampExecReqDto reqDto) {
	    	LogUtil.param(this.getClass(), reqDto);
	    	reqDto.setLoginInfo(this.checkLoginSession(request, response));

	        return mktRealTimeCampaignService.getETIntactTypeList(reqDto);
	    }
	    
	    /**
	     * @name : getStoreTreeList
	     * @date : 2019. 9. 19.
	     * @author : jy.seok
	     * @description : 지점 신규 tree 구조 조회
	     */
	     @RequestMapping(value="/getStoreTreeList.do", method = RequestMethod.POST)
	 	public @ResponseBody
	 	List<MktCampaignStoreResDto> getStoreTreeList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignStoreReqDto reqDto) {
	    	 LogUtil.param(this.getClass(), reqDto);
		    	reqDto.setLoginInfo(this.checkLoginSession(request, response));

	         return mktRealTimeCampaignService.getStoreTreeList(reqDto);
	     }
	     
	    
	    /**
	    * @programId :
	    * @name : saveCampaignStore
	    * @date : 2019. 9. 24.
	    * @author : jy.seok
	    * @table :
	    * @return : 
	    * @description : 지점매핑 저장
	    */
	    @RequestMapping(value = "/saveCampaignStore.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto saveCampaignStore(HttpServletRequest request, HttpServletResponse response,
					@RequestBody MktCampaignStoreReqDto reqDto) {
	    	LogUtil.param(this.getClass(), reqDto);
	    	reqDto.setLoginInfo(this.checkLoginSession(request, response));

				return mktRealTimeCampaignService.saveCampaignStore(reqDto);
		}
	    
	    /**
	     * @programId :
	     * @name : editCampaignStore
	     * @date : 2019. 10. 31.
	     * @author : jy.seok
	     * @table :
	     * @return : StatusResponseDTO
	     * @description :지점매핑 수정
	     */
	     @RequestMapping(value = "/editCampaignStore.do", method = RequestMethod.POST)
	 	public @ResponseBody StatusResDto editCampaignStore(HttpServletRequest request, HttpServletResponse response,
	 			@RequestBody MktCampaignStoreReqDto reqDto) {
	    	 LogUtil.param(this.getClass(), reqDto);
		    	reqDto.setLoginInfo(this.checkLoginSession(request, response));

	 		return mktRealTimeCampaignService.editCampaignStore(reqDto);
	 	}
	     
	     /**
	      * @programId :
	      * @name : removeCampaignStore
	      * @date : 2019. 10. 31.
	      * @author : jy.seok
	      * @table :
	      * @return : StatusResponseDTO
	      * @description :지점매핑 삭제
	      */
	      @RequestMapping(value = "/removeCampaignStore.do", method = RequestMethod.POST)
	  	public @ResponseBody StatusResDto removeCampaignStore(HttpServletRequest request, HttpServletResponse response,
	  				@RequestBody MktCampaignStoreReqDto reqDto) {
	    		LogUtil.param(this.getClass(), reqDto);
			    reqDto.setLoginInfo(this.checkLoginSession(request, response));

	  			return mktRealTimeCampaignService.removeCampaignStore(reqDto);
	  	}

	    /**
	    * @programId :
	    * @name : getStoreTreeSeachList
	    * @date : 2019. 11. 1.
	    * @author : jy.seok
	    * @table :
	    * @return : List<MKTCampaignStoreResponseDTO>
	    * @description : 지점 검색조건
	    */
	    @RequestMapping(value="/getStoreTreeSearchList.do", method = RequestMethod.POST)
		public @ResponseBody
		List<MktCampaignStoreResDto> getStoreTreeSearchList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignStoreReqDto reqDto) {
	    	LogUtil.param(this.getClass(), reqDto);
		    reqDto.setLoginInfo(this.checkLoginSession(request, response));

	        return mktRealTimeCampaignService.getStoreTreeSearchList(reqDto);
	    }	      
      
	    /**
	     * @name : getStoreMappingList
	     * @date : 2019. 9. 19.
	     * @author : jy.seok
	     * @description : 캠페인 기본정보 지점매핑 조회
	     */
	     @RequestMapping(value="/getStoreMappingList.do", method = RequestMethod.POST)
	 	public @ResponseBody
	 	GridPagingResDto<MktCampaignStoreResDto> getStoreMappingList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignStoreReqDto reqDto) {
	    		LogUtil.param(this.getClass(), reqDto);
			    reqDto.setLoginInfo(this.checkLoginSession(request, response));

	         return mktRealTimeCampaignService.getStoreMappingList(reqDto);
	     }
	    
	    
		  /**
	 	
			 * @name : getCampaignListRFC
			 * @date : 2019. 9. 17.
			 * @author : sh.park
			 * @table : 계열사 조회
			 * @return : 
			 * 
			 * @description : 계열사 조회
			 */
		@RequestMapping(value="/getChnlCd.do", method = RequestMethod.POST)
		public @ResponseBody List<MktCampaignChnlResDto> getChnlCd(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignChnlReqDto reqDto) {
			LogUtil.param(this.getClass(), reqDto);
			return mktRealTimeCampaignService.getChnlCd(reqDto);
		}
	     
		
		@RequestMapping(value="/getBrdCd.do", method = RequestMethod.POST)
		public @ResponseBody List<MktCampaignChnlResDto> getBrdCd(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignChnlReqDto reqDto) {
			LogUtil.param(this.getClass(), reqDto);
			return mktRealTimeCampaignService.getBrdCd(reqDto);
		}
		
		 /**
		
		 * @name : getCampaignListRFC
		 * @date : 2019. 9. 17.
		 * @author : sh.park
		 * @table : 지점 조회
		 * @return : 
		 * 
		 * @description : 지점 조회
		 */
		
		@RequestMapping(value="/getMktStoreCd.do", method = RequestMethod.POST)
		public @ResponseBody List<MktCampaignChnlResDto> getStoreCd(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignChnlReqDto reqDto) {
			LogUtil.param(this.getClass(), reqDto);
			return mktRealTimeCampaignService.getStoreCd(reqDto);
		}
		
		
		/**
		* @programId :
		* @name : getSndChnlCd, getSndBrdCd, getSndStoreCd
		* @date : 2019. 9. 25.
		* @author : jy.seok
		* @table :
		* @return : List<MktCampaignChnlResDto>
		* @description : 메시지 전송점 계열사, 브랜드, 지점
		*/
		@RequestMapping(value="/getSndChnlCd.do", method = RequestMethod.POST)
		public @ResponseBody List<MktCampaignChnlResDto> getSndChnlCd(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignChnlReqDto reqDto) {
			LogUtil.param(this.getClass(), reqDto);
			return mktRealTimeCampaignService.getSndChnlCd(reqDto);
		}
		
		
		@RequestMapping(value="/getSndBrdCd.do", method = RequestMethod.POST)
		public @ResponseBody List<MktCampaignChnlResDto> getSndBrdCd(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignChnlReqDto reqDto) {
			LogUtil.param(this.getClass(), reqDto);
			return mktRealTimeCampaignService.getSndBrdCd(reqDto);
		}
		
		 
		@RequestMapping(value="/getSndStoreCd.do", method = RequestMethod.POST)
		public @ResponseBody List<MktCampaignChnlResDto> getSndStoreCd(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignChnlReqDto reqDto) {
			LogUtil.param(this.getClass(), reqDto);
			return mktRealTimeCampaignService.getSndStoreCd(reqDto);
		}
		
		@RequestMapping(value="/getBrdCdByRid.do", method = RequestMethod.POST)
		public @ResponseBody List<MktCampaignChnlResDto> getBrdCdByRid(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignChnlReqDto reqDto) {
			LogUtil.param(this.getClass(), reqDto);
			return mktRealTimeCampaignService.getBrdCdByRid(reqDto);
		}
		
		@RequestMapping(value="/getStoreCdByRid.do", method = RequestMethod.POST)
		public @ResponseBody List<MktCampaignChnlResDto> getStoreCdByRid(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignChnlReqDto reqDto) {
			LogUtil.param(this.getClass(), reqDto);
			return mktRealTimeCampaignService.getStoreCdByRid(reqDto);
		}
		
}

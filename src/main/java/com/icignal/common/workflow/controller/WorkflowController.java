package com.icignal.common.workflow.controller;

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
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.common.workflow.dto.request.WorkflowPaletteReqDto;
import com.icignal.common.workflow.dto.request.WorkflowTaskReqDto;
import com.icignal.common.workflow.dto.response.WorkflowPaletteListResDto;
import com.icignal.common.workflow.dto.response.WorkflowTaskResDto;
import com.icignal.common.workflow.service.WorkflowService;



@Controller
@RequestMapping("/loyalty/workflow")
public class WorkflowController extends BaseController{

	
	@Autowired private WorkflowService workflowService;
	
    /**
     * @programId : 
     * @name : getWorkflowPaletteList
     * @date : 2015. 10. 5.
     * @author : 류동균
     * @table : 
     * @return : 
     * @description : 팔레트 목록
     */
    @RequestMapping(value="/getWorkflowPaletteList.do", method = RequestMethod.POST)
	public @ResponseBody
	List<WorkflowPaletteListResDto> getWorkflowPaletteList(HttpServletRequest request, HttpServletResponse response, @RequestBody WorkflowPaletteReqDto mwpr) {
        LogUtil.param(this.getClass(), mwpr);
        
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mwpr.setLoginInfo(loginInfo);
        
        return workflowService.getWorkflowPaletteList(mwpr);
    }
    
    /**
     * @programId : MKT_MNG_P02
     * @name : getWorkflowTask
     * @date : 2015. 10. 2.
     * @author : 류동균
     * @table : com.workflow_task
     * @return : 
     * @description : 워크플로우 테스크 조회
     */
	@RequestMapping(value="/getWorkflowTask.do", method = RequestMethod.POST)
	public @ResponseBody
	WorkflowTaskResDto getWorkflowTask(HttpServletRequest request, HttpServletResponse response, @RequestBody WorkflowTaskReqDto mwtr) {
	    LogUtil.param(this.getClass(), mwtr);
        
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mwtr.setLoginInfo(loginInfo);
        
        return workflowService.getWorkflowTask(mwtr);
    }
	
	/**
	 * @programId : MKT_MNG_P02
	 * @name : saveWorkflowTask
	 * @date : 2015. 10. 12.
	 * @author : 류동균
	 * @table : 
	 * @return : 
	 * @description : 워크플로우 테스크 저장
	 */
	@RequestMapping(value="/saveWorkflowTask.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto saveWorkflowTask(HttpServletRequest request, HttpServletResponse response, @RequestBody WorkflowTaskReqDto mwnlr) {
        LogUtil.param(this.getClass(), mwnlr);
        
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mwnlr.setLoginInfo(loginInfo);
        
        return workflowService.saveWorkflowTask(mwnlr);
    }
	

}

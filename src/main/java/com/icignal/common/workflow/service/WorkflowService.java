package com.icignal.common.workflow.service;



import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.common.workflow.dto.request.WorkflowConnectorReqDto;
import com.icignal.common.workflow.dto.request.WorkflowHandleReqDto;
import com.icignal.common.workflow.dto.request.WorkflowNodeReqDto;
import com.icignal.common.workflow.dto.request.WorkflowPaletteReqDto;
import com.icignal.common.workflow.dto.request.WorkflowTaskConnectorReqDto;
import com.icignal.common.workflow.dto.request.WorkflowTaskHeaderReqDto;
import com.icignal.common.workflow.dto.request.WorkflowTaskNodeReqDto;
import com.icignal.common.workflow.dto.request.WorkflowTaskReqDto;
import com.icignal.common.workflow.dto.response.WorkflowConnectorListResDto;
import com.icignal.common.workflow.dto.response.WorkflowHandleListResDto;
import com.icignal.common.workflow.dto.response.WorkflowNodeListResDto;
import com.icignal.common.workflow.dto.response.WorkflowPaletteListResDto;
import com.icignal.common.workflow.dto.response.WorkflowTaskNodeListResDto;
import com.icignal.common.workflow.dto.response.WorkflowTaskResDto;
import com.icignal.common.workflow.mapper.WorkflowMapper;



/**
 * @name : infavor.marketing.workflow.service.impl
 * @date : 2015. 10. 2.
 * @author : 류동균
 * @description : 워크플로우 Service
 */
@Service
public class WorkflowService {

    
	@Autowired private WorkflowMapper workflowMapper;
	
    /**
     * @programId : 
     * @name : getWorkflowPaletteList
     * @date : 2015. 10. 5.
     * @author : 류동균
     * @table : com.workflow_node
     * @return : 
     * @description : 워크플로우 팔레트 목록
     */
    public List<WorkflowPaletteListResDto> getWorkflowPaletteList(WorkflowPaletteReqDto mwpr) {
        LogUtil.param(WorkflowService.class, mwpr);
        
        mwpr.setActYn("1"); //노드 활성화여부
        //팔레트유형목록
        List<WorkflowPaletteListResDto> paletteList = new ArrayList<WorkflowPaletteListResDto>();
                     
        mwpr.setSVCAlias("w");
        //팔레트유형에 해당 하는 노드목록 얻는다.
        for (WorkflowPaletteListResDto palette : workflowMapper.selectWorkflowPaletteTypeList(mwpr)) {
            //노드 조회
            WorkflowNodeReqDto nodeReq = new WorkflowNodeReqDto();
            nodeReq.setSystemColumn(mwpr.getSystemColumn());
            nodeReq.setPaletteType(palette.getId()); //팔레트 유형 아이디
            nodeReq.setActYn("1"); //노드 활성화여부
            nodeReq.setType(mwpr.getType()); //팔레트 사용처 구분 (ex)MKT,SCR...)
            
            List<WorkflowNodeListResDto> nodeList = new ArrayList<WorkflowNodeListResDto>();
            nodeList = getWorkflowNodeList(nodeReq);
            
            //커넥터 조회
            WorkflowConnectorReqDto connectorReq = new WorkflowConnectorReqDto();
            connectorReq.setSystemColumn(mwpr.getSystemColumn());
            connectorReq.setPaletteType(palette.getId()); //팔레트 유형 아이디
            connectorReq.setActYn("1"); //노드 활성화여부
            
            List<WorkflowConnectorListResDto> connectorList = new ArrayList<WorkflowConnectorListResDto>();
            
            connectorReq.setSVCAlias("wc");
            
            connectorList = workflowMapper.selectWorkflowConnectorList(connectorReq);
            
            palette.setNodeList(nodeList);
            palette.setConnectorList(connectorList);
            paletteList.add(palette);
        }
        
        return paletteList;
    }
    
    
    /**
     * @programId : MKT_MNG_P02
     * @name : getWorkflowTaskList
     * @date : 2015. 10. 2.
     * @author : 류동균
     * @table : com.workflow_task
     * @return : 
     * @description : 워크플로우 테스크 조회
     */
    public WorkflowTaskResDto getWorkflowTask(WorkflowTaskReqDto mwtr) {
        LogUtil.param(WorkflowService.class, mwtr);
        
        WorkflowTaskResDto task = new WorkflowTaskResDto();
        
        //테스크 헤더
        //헤더의 아이디 또는 상위아이디 확인
        if (ObjectUtil.isNotEmpty(mwtr.getParentId()) || ObjectUtil.isNotEmpty(mwtr.getId())) {
            WorkflowTaskHeaderReqDto mwthr = new WorkflowTaskHeaderReqDto();
            mwthr.setSystemColumn(mwtr.getSystemColumn());
            mwthr.setId(mwtr.getId());
            mwthr.setParentId(mwtr.getParentId());
            
            task = workflowMapper.selectWorkflowTaskHeader(mwthr);
            
            if (ObjectUtil.isNotEmpty(task)) {
                //테스크 노드 목록 조회
                WorkflowTaskNodeReqDto mwtnr = new WorkflowTaskNodeReqDto();
                mwtnr.setSystemColumn(mwtr.getSystemColumn());
                mwtnr.setTaskHeaderId(task.getId());
                
                task.setNodeList(getWorkflowTaskNodeList(mwtnr));
                
                //테스크 커넥터 목록 조회
                WorkflowTaskConnectorReqDto  mwtcr = new WorkflowTaskConnectorReqDto();
                mwtnr.setSystemColumn(mwtr.getSystemColumn());
                mwtcr.setTaskHeaderId(task.getId());
                mwtcr.setSVCAlias("wtc");
                task.setConnectorList(workflowMapper.selectWorkflowTaskConnectorList(mwtcr));
                
                task.setSuccess(true);
            }
        }
        
        return task;
    }
    /**
     * @programId : 
     * @name : saveWorkflowTask
     * @date : 2015. 10. 5.
     * @author : 류동균
     * @table : 
     * @return : 
     * @description : 워크플로우 전체 테스크 저장(헤더/노드/커넥터)
     */
    public StatusResDto saveWorkflowTask(WorkflowTaskReqDto mwtr) {
        LogUtil.param(WorkflowService.class, mwtr);
        
        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);
        
        //테스크 헤더 저장
        WorkflowTaskHeaderReqDto mwthr = new WorkflowTaskHeaderReqDto();
        mwthr.setSystemColumn(mwtr.getSystemColumn());
        mwthr.setId(mwtr.getId());
        mwthr.setWorkflowName(mwtr.getWorkflowName());
        mwthr.setWorkflowDescText(mwtr.getWorkflowDescText());
        
        if (ObjectUtil.isEmpty(mwthr.getId())) {
        	  String dispNo = workflowMapper.selectWorkflowDispNo(mwthr);
              mwthr.setWorkflowDispNo(dispNo);
              String id = StringUtil.genID();
              mwthr.setId(id); 
              workflowMapper.insertWorkflowTaskHeader(mwthr);
              
              if (id != null) {
                  rtnValue.setSuccess(true);
                  rtnValue.setMessage(id);
              }
            mwthr.setId(rtnValue.getMessage());
        } else {
            
            workflowMapper.updateWorkflowTaskHeader(mwthr);
            rtnValue.setSuccess(true);
        }
        
        //테스크 노드 저장
        //기존 Task를 모두 삭제처리 후 아래 등록/수정에서 기존 Task의 삭제를 번복한다.
        WorkflowTaskNodeReqDto mwtnr = new WorkflowTaskNodeReqDto();
        mwtnr.setSystemColumn(mwtr.getSystemColumn());
        mwtnr.setTaskHeaderId(mwthr.getId());
        
       workflowMapper.deleteWorkflowTaskNodeByParentId(mwtnr);
       rtnValue.setSuccess(true);
        //Task 등록 및 수정
        if (rtnValue.getSuccess()) {
            for (WorkflowTaskNodeReqDto node : mwtr.getNodeList()) {
            	node.setSystemColumn(mwtr.getSystemColumn());
                node.setTaskHeaderId(mwthr.getId());
                
                if (workflowMapper.selectWorkflowTaskNodeCheck(node) > 0) {
                    workflowMapper.updateWorkflowTaskNode(node);
                    rtnValue.setSuccess(true);
                } else {
                     workflowMapper.insertWorkflowTaskNode(node);
                     rtnValue.setSuccess(true);
                }
            }
        }
        
        //테스크 커넥터 저장
        //기존 Task를 모두 삭제처리 후 아래 등록/수정에서 기존 Task의 삭제를 번복한다.
        WorkflowTaskConnectorReqDto  mwtcr = new WorkflowTaskConnectorReqDto();
        mwtcr.setSystemColumn(mwtr.getSystemColumn());
        mwtcr.setTaskHeaderId(mwthr.getId());
        
       workflowMapper.deleteWorkflowTaskConnectorByParentId(mwtcr);
       rtnValue.setSuccess(true); 
        //Task 등록 및 수정
        if (rtnValue.getSuccess()) {
            for (WorkflowTaskConnectorReqDto connector : mwtr.getConnectorList()) {
            	connector.setSystemColumn(mwtr.getSystemColumn());
                connector.setTaskHeaderId(mwthr.getId());
                
                if (workflowMapper.selectWorkflowTaskConnectorCheck(connector) > 0) {
                    workflowMapper.updateWorkflowTaskConnector(connector);
                    rtnValue.setSuccess(true);
                } else {
                    workflowMapper.insertWorkflowTaskConnector(connector);
                    rtnValue.setSuccess(true);
                }
            }
        }
        
        
        //헤더 아이디 반환
        rtnValue.setMessage(mwthr.getId());
        
        return rtnValue;
    }  
    
    /** 메소드로 만들었음
     * @programId : MKT_MNG_P02
     * @name : getWorkflowNodeList
     * @date : 2015. 10. 12.
     * @author : 류동균
     * @table : 
     * @return : 
     * @description : 워크픞로우 노드 목록 조회
     */
    public List<WorkflowNodeListResDto> getWorkflowNodeList(WorkflowNodeReqDto mwnr) {
        LogUtil.param(WorkflowService.class, mwnr);
        
        List<WorkflowNodeListResDto> nodeList = new ArrayList<WorkflowNodeListResDto>();
        mwnr.setSVCAlias("wn");
        //노드목록
        for (WorkflowNodeListResDto node : workflowMapper.selectWorkflowNodeList(mwnr)) {
            WorkflowHandleReqDto handleReq = new WorkflowHandleReqDto();
            handleReq.setSystemColumn(mwnr.getSystemColumn());
            handleReq.setNodeId(node.getId()); //노드아이디
            handleReq.setSVCAlias("wh");
            List<WorkflowHandleListResDto> handleList = new ArrayList<WorkflowHandleListResDto>();
            handleList = (List<WorkflowHandleListResDto>) workflowMapper.selectWorkflowHandleList(handleReq);
            
            node.setHandleList(handleList);
            nodeList.add(node);
        }
        
        return nodeList;
    }
	
    
    /**메소드로 만들었음
     * @programId : MKT_MNG_P02
     * @name : getWorkflowTaskNodeList
     * @date : 2015. 10. 14.
     * @author : 류동균
     * @table : com.workflow_handle
     * @return : 
     * @description : 워크플로우 테스크노드 핸들 목록 조회
     */
    public List<WorkflowTaskNodeListResDto> getWorkflowTaskNodeList(WorkflowTaskNodeReqDto mwtnr) {
        LogUtil.param(WorkflowService.class, mwtnr);
        
        List<WorkflowTaskNodeListResDto> nodeList = new ArrayList<WorkflowTaskNodeListResDto>();
        mwtnr.setSVCAlias("wtn");
        //노드목록
        for (WorkflowTaskNodeListResDto node : workflowMapper.selectWorkflowTaskNodeList(mwtnr)) {
            WorkflowHandleReqDto handleReq = new WorkflowHandleReqDto();
            handleReq.setSystemColumn(mwtnr.getSystemColumn());
            handleReq.setNodeId(node.getNodeId()); //노드아이디
            handleReq.setSVCAlias("wh");
            List<WorkflowHandleListResDto> handleList = new ArrayList<WorkflowHandleListResDto>();
            handleList = workflowMapper.selectWorkflowHandleList(handleReq);
            
            node.setHandleList(handleList);
            nodeList.add(node);
        }
        
        return nodeList;
    }


	
}

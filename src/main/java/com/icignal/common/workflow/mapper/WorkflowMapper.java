package com.icignal.common.workflow.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.common.workflow.dto.request.WorkflowConnectorReqDto;
import com.icignal.common.workflow.dto.request.WorkflowHandleReqDto;
import com.icignal.common.workflow.dto.request.WorkflowNodeReqDto;
import com.icignal.common.workflow.dto.request.WorkflowPaletteReqDto;
import com.icignal.common.workflow.dto.request.WorkflowTaskConnectorReqDto;
import com.icignal.common.workflow.dto.request.WorkflowTaskHeaderReqDto;
import com.icignal.common.workflow.dto.request.WorkflowTaskNodeReqDto;
import com.icignal.common.workflow.dto.response.WorkflowConnectorListResDto;
import com.icignal.common.workflow.dto.response.WorkflowHandleListResDto;
import com.icignal.common.workflow.dto.response.WorkflowNodeListResDto;
import com.icignal.common.workflow.dto.response.WorkflowPaletteListResDto;
import com.icignal.common.workflow.dto.response.WorkflowTaskConnectorListResDto;
import com.icignal.common.workflow.dto.response.WorkflowTaskNodeListResDto;
import com.icignal.common.workflow.dto.response.WorkflowTaskResDto;

@Mapper
public interface WorkflowMapper {

	public List<WorkflowPaletteListResDto> selectWorkflowPaletteTypeList(WorkflowPaletteReqDto mwpr);

	public List<WorkflowConnectorListResDto> selectWorkflowConnectorList(WorkflowConnectorReqDto connectorReq);

	public WorkflowTaskResDto selectWorkflowTaskHeader(WorkflowTaskHeaderReqDto mwthr);

	public List<WorkflowTaskConnectorListResDto> selectWorkflowTaskConnectorList(WorkflowTaskConnectorReqDto mwtcr);

	public String selectWorkflowDispNo(WorkflowTaskHeaderReqDto mwthr);

	public void insertWorkflowTaskHeader(WorkflowTaskHeaderReqDto mwthr);

	public void updateWorkflowTaskHeader(WorkflowTaskHeaderReqDto mwthr);

	public void deleteWorkflowTaskNodeByParentId(WorkflowTaskNodeReqDto mwtnr);

	public int selectWorkflowTaskNodeCheck(WorkflowTaskNodeReqDto node);

	public void updateWorkflowTaskNode(WorkflowTaskNodeReqDto node);

	public void insertWorkflowTaskNode(WorkflowTaskNodeReqDto node);

	public void deleteWorkflowTaskConnectorByParentId(WorkflowTaskConnectorReqDto mwtcr);

	public int selectWorkflowTaskConnectorCheck(WorkflowTaskConnectorReqDto connector);

	public void updateWorkflowTaskConnector(WorkflowTaskConnectorReqDto connector);

	public void insertWorkflowTaskConnector(WorkflowTaskConnectorReqDto connector);

	public  List<WorkflowNodeListResDto> selectWorkflowNodeList(WorkflowNodeReqDto mwnr);

	public List<WorkflowHandleListResDto> selectWorkflowHandleList(WorkflowHandleReqDto handleReq);

	public List<WorkflowTaskNodeListResDto> selectWorkflowTaskNodeList(WorkflowTaskNodeReqDto mwtnr);












}

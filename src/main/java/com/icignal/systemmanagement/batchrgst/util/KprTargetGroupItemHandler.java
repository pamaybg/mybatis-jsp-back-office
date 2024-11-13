package com.icignal.systemmanagement.batchrgst.util;

import com.icignal.common.util.ObjectUtil;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupItemReqDto;
import org.apache.poi.xssf.eventusermodel.XSSFSheetXMLHandler.SheetContentsHandler;
import org.apache.poi.xssf.usermodel.XSSFComment;

import java.util.ArrayList;
import java.util.List;

public class KprTargetGroupItemHandler implements SheetContentsHandler {
    private int rowNum;

    KprTargetGroupItemReqDto kprDto = new KprTargetGroupItemReqDto();
    List<KprTargetGroupItemReqDto> kprList = new ArrayList<>();

    public KprTargetGroupItemHandler() {
    }


    //Row의 시작 부분에서 발생하는 이벤트를 처리하는 method
    @Override
    public void startRow(int row) {
        rowNum = row;
        if (rowNum < 1) {
            return;
        }
        kprDto = new KprTargetGroupItemReqDto();
    }


    @Override
    public void headerFooter(String paramString1, boolean paramBoolean,
                             String paramString2) {
    }

    @SuppressWarnings("unchecked")
    @Override
    public void endRow(int rowNum) {
        if (rowNum < 1) return;
        if(ObjectUtil.isEmpty(kprDto.getMemId())) return;
        kprList.add(kprDto);
    }

    @Override
    public void cell(String cellReference, String formattedValue, XSSFComment comment) {
        if (rowNum < 1) return;
        if (ObjectUtil.isEmpty(formattedValue)) return;

        String cellVal =  cellReference.substring(0,1);
        if(cellVal.equals("A"))
            kprDto.setMemId(formattedValue);
        else if(cellVal.equals("B"))
            kprDto.setAttrib01(formattedValue);
        else if(cellVal.equals("C"))
            kprDto.setAttrib02(formattedValue);
        else if(cellVal.equals("D"))
            kprDto.setAttrib03(formattedValue);

    }

    public List<KprTargetGroupItemReqDto> getKprList() {
        return kprList;
    }

}

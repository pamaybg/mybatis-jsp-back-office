package com.icignal.common.base.dto.request;

import java.lang.reflect.Array;
import java.util.*;
import java.util.stream.Collectors;

import com.icignal.common.base.service.EnDeCryptedService;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.SecureDataCheck;
import com.icignal.common.util.SecurityUtil;
import com.icignal.common.util.StringUtil;

/**
 * @author : 장용
 * @name : MKTCommonCondRequestDTO.java
 * @date : 2015. 10. 16.
 * @description : 조건 조회 공통 dto
 */
public class CommonCondReqDto extends MKTGridPagingReqDto {

    private List<CommonCodeItemReqDto> item;
    private String strCondWhere;
    private String excelHeader;
    private String excelFooter;
    private String strMbrIntWhere;
    private String intRidMbr;
    private String intMbrNo;

    public String getStrMbrIntWhere() {
        String intWhere = "";

        if (this.getIntRidMbr() != null && this.getIntRidMbr().length() > 0) {
            intWhere += "(" + "SELECT lms.rid FROM LOY.LOY_MBR lms WHERE RID IN";
            intWhere += "( SELECT RID_MBR FROM LOY.LOY_MBR_INT lmi WHERE lmi.FLAG = 1 AND lmi.MBR_INT_CODE";
            intWhere += "='" + this.getIntRidMbr() + "'" + "))";
        } else if (intMbrNo != null) {
            intWhere += "(" + "SELECT lms.rid FROM LOY.LOY_MBR lms WHERE RID IN";
            intWhere += "( SELECT RID_MBR FROM LOY.LOY_MBR_INT lmi WHERE lmi.FLAG = 1 AND lmi.MBR_INT_CODE IN (";
            intWhere += "SELECT MBR_INT_CODE FROM LOY.LOY_MBR_INT WHERE rid_mbr =(select RID FROM LOY.LOY_MBR WHERE MBR_NO = '"
                    + this.getIntMbrNo() + "')";
            intWhere += "AND flag = 1)))";
        }
        this.setStrMbrIntWhere(intWhere);
        return strMbrIntWhere;
    }

    public String getIntMbrNo() {
        return intMbrNo;
    }

    public void setIntMbrNo(String intMbrNo) {
        this.intMbrNo = intMbrNo;
    }

    public String getIntRidMbr() {
        return intRidMbr;
    }

    public void setIntRidMbr(String intRidMbr) {
        this.intRidMbr = intRidMbr;
    }

    public void setStrMbrIntWhere(String strMbrIntWhere) {
        this.strMbrIntWhere = strMbrIntWhere;
    }

    public String getStrCondWhere() {
        String space = " ";
        String alias = "";
        String aliasMap = "";
        strCondWhere = "1=1";
        ArrayList<CommonCodeItemReqDto> itemColList = new ArrayList<CommonCodeItemReqDto>();
        LinkedHashMap<String, ArrayList<String>> itemColListMap = new LinkedHashMap<String, ArrayList<String>>();
        ArrayList<CommonCodeItemReqDto> resultColList = new ArrayList<CommonCodeItemReqDto>();

        if (item != null && item.size() > 0) {

            item = item.stream().sorted(Comparator.comparing(CommonCodeItemReqDto::getSrcCol).reversed().thenComparing(CommonCodeItemReqDto::getOperationType).reversed())
                    .collect(Collectors.toList());

            Collections.sort(item, (o1, o2) -> {
                if (o1.getOperationType().trim().equals("IN") || o1.getOperationType().trim().equals("NOT IN")) {
                    return -1;
                } else {
                    return 1;
                }

            });

            itemColList.addAll(item);
            resultColList.addAll(item);
            ArrayList<String> itemValueList = new ArrayList<String>();
            ArrayList<String> itemValueRidList = new ArrayList<String>();

            List<String> operationDataList = Arrays.asList("IN", "NOT IN");
            int calIndex = 0;

            for (int i = 0; i < item.size(); i++) {
                if (StringUtil.isNotEmpty(item.get(i).getWhereVal())
                        && item.get(i).getOperationType().trim().equals(operationDataList.get(0))
                        || item.get(i).getOperationType().trim().equals(operationDataList.get(1))) {

                    // set base alias
                    if (item.get(i).getBaseTblAlias() != null && item.get(i).getBaseTblAlias().length() > 0) {
                        alias = item.get(i).getBaseTblAlias() + ".";
                    }

                    // set target alias
                    if (item.get(i).getComprTgtTblAlias() != null && item.get(i).getComprTgtTblAlias().length() > 0) {
                        alias = item.get(i).getComprTgtTblAlias() + ".";
                    }

                    String oriItem = alias + item.get(i).getSrcCol().toString();

                    for (CommonCodeItemReqDto itemData : itemColList) {
                        if (StringUtil.isNotEmpty(itemData.getWhereVal())) {
                            // set base alias
                            if (itemData.getBaseTblAlias() != null && itemData.getBaseTblAlias().length() > 0) {
                                aliasMap = itemData.getBaseTblAlias() + ".";
                            }

                            // set target alias
                            if (itemData.getComprTgtTblAlias() != null && itemData.getComprTgtTblAlias().length() > 0) {
                                aliasMap = itemData.getComprTgtTblAlias() + ".";
                            }
                            if (oriItem.equals(aliasMap + itemData.getSrcCol()) == true) {
                                if (itemValueRidList.contains(item.get(i).getRid()) == false) {
                                    if (item.get(i).getSrcCol().equals(itemData.getSrcCol())) {
                                        if (item.get(i).getOperationType().trim().equals(operationDataList.get(0)) == true
                                                || item.get(i).getOperationType().trim().equals(operationDataList.get(1)) == true) {

                                            for (String operationData : operationDataList) {
                                                if (StringUtil.isNotEmpty(item.get(i).getWhereVal())
                                                        && item.get(i).getOperationType().trim().equals(operationData)) {
                                                    itemValueRidList.add(item.get(i).getRid());
                                                    itemValueList.add(item.get(i).getWhereVal() + "/"
                                                            + operationData);
                                                    break;
                                                }
                                            }
                                            if (calIndex == 0) { //First
                                                itemColListMap.put(item.get(i).getSrcCol(), itemValueList);
                                                if (i + 1 < item.size()) {
                                                    if (item.get(i).getSrcCol().equals(item.get(i + 1).getSrcCol()) == false) {
                                                        itemValueList = new ArrayList<String>();
                                                        itemValueRidList = new ArrayList<String>();
                                                    } else {
                                                        if (item.get(i + 1).getOperationType().trim().equals(operationDataList.get(0)) == false
                                                                && item.get(i + 1).getOperationType().trim().equals(operationDataList.get(1)) == false) {
                                                            itemValueList = new ArrayList<String>();
                                                            itemValueRidList = new ArrayList<String>();
                                                        }
                                                    }
                                                } else {
                                                    itemValueList = new ArrayList<String>();
                                                    itemValueRidList = new ArrayList<String>();
                                                }
                                                calIndex++;
                                                break;
                                            } else {
                                                if (i + 1 >= item.size()) { //Max
                                                    itemColListMap.put(item.get(i).getSrcCol(), itemValueList);
                                                    calIndex++;
                                                    break;
                                                } else { //Loop
                                                    itemColListMap.put(item.get(i).getSrcCol(), itemValueList);
                                                    if (item.get(i).getSrcCol().equals(item.get(i + 1).getSrcCol()) == false) {
                                                        itemValueList = new ArrayList<String>();
                                                        itemValueRidList = new ArrayList<String>();
                                                    } else {
                                                        if (item.get(i + 1).getOperationType().trim().equals(operationDataList.get(0)) == false
                                                                && item.get(i + 1).getOperationType().trim().equals(operationDataList.get(1)) == false) {
                                                            itemValueList = new ArrayList<String>();
                                                            itemValueRidList = new ArrayList<String>();
                                                        }
                                                    }
                                                    calIndex++;
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                for (String key : itemColListMap.keySet()) {
                    ArrayList<String> itemIterList = new ArrayList<String>();
                    for (Iterator<CommonCodeItemReqDto> iter = resultColList.iterator(); iter.hasNext(); ) {
                        CommonCodeItemReqDto itemData = iter.next();

                        if (StringUtil.isNotEmpty(itemData.getOperationType())) {
                            if (itemData.getOperationType().trim().equals(operationDataList.get(0))
                                    || itemData.getOperationType().trim().equals(operationDataList.get(1))) {
                                if (itemData.getSrcCol().toString().equals(key)) {
                                    itemIterList.add(itemData.getRid().toString());
                                }
                            }
                        }
                        if (itemIterList.size() > 1) {
                            if (itemData.getSrcCol().toString().equals(key)) {
                                if (itemData.getOperationType().trim().equals(operationDataList.get(0))
                                        || itemData.getOperationType().trim().equals(operationDataList.get(1))) {
                                    iter.remove();
                                }
                            }
                        }
                    }
                }
            }

            alias = "";
            aliasMap = "";

            for (int i = 0; i < resultColList.size(); i++) {
                // System.out.println("item.get(i).getCondType(): " +
                // item.get(i).getCondType());

                if (resultColList.get(i).getCondType().trim().equals("DATE")
                        || resultColList.get(i).getCondType().trim().equals("DATE_YYYYMMDD")
                        || resultColList.get(i).getCondType().trim().equals("DATE_YYYYMM")
                        || resultColList.get(i).getCondType().trim().equals("DATETIME")
                        || resultColList.get(i).getCondType().trim().equals("DATE_GREATER")
                        || ObjectUtil.isNotEmpty(resultColList.get(i).getWhereVal())) {

                    // set base alias
                    if (resultColList.get(i).getBaseTblAlias() != null
                            && resultColList.get(i).getBaseTblAlias().length() > 0) {
                        alias = resultColList.get(i).getBaseTblAlias() + ".";
                    }

                    // set target alias
                    if (resultColList.get(i).getComprTgtTblAlias() != null
                            && resultColList.get(i).getComprTgtTblAlias().length() > 0) {
                        alias = resultColList.get(i).getComprTgtTblAlias() + ".";
                    }

                    if (!(resultColList.get(i).getCondType().trim().equals("DATE")
                            || resultColList.get(i).getCondType().trim().equals("DATE_YYYYMMDD")
                            || resultColList.get(i).getCondType().trim().equals("DATE_YYYYMM")
                            || resultColList.get(i).getCondType().trim().equals("DATETIME")
                            || resultColList.get(i).getCondType().trim().equals("DATE_GREATER"))) {
                        SecureDataCheck.preventSqlInjection(resultColList.get(i).getWhereVal());
                    }
                    SecureDataCheck.preventSqlInjection(resultColList.get(i).getOperationType().trim());
                    /**
                     * DATE 날짜
                     */
                    if (resultColList.get(i).getCondType().trim().equals("DATE")) {
                        if (resultColList.get(i).getOperationType().trim().equals("BETWEEN")) {
                            if (ObjectUtil.isNotEmpty(resultColList.get(i).getStartDate())
                                    && ObjectUtil.isNotEmpty(resultColList.get(i).getEndDate())) {
                                if (CommonUtil.DB_TYPE.ORACLE.equals(CommonUtil.getInstance().getDBType())) {
                                    strCondWhere += " and" + space + alias + resultColList.get(i).getSrcCol() + space
                                            + resultColList.get(i).getOperationType() + space + "to_date('"
                                            + resultColList.get(i).getStartDate() + "', 'yyyy-mm-dd hh24:mi:ss')"
                                            + " and " + "to_date('" + resultColList.get(i).getEndDate()
                                            + "', 'yyyy-mm-dd hh24:mi:ss')";
                                } else if (CommonUtil.DB_TYPE.MSSQL.equals(CommonUtil.getInstance().getDBType())) {
                                    strCondWhere += " and" + space + alias + resultColList.get(i).getSrcCol() + space
                                            + resultColList.get(i).getOperationType() + space + "CONVERT(DATETIME, '"
                                            + resultColList.get(i).getStartDate() + "')" + " and "
                                            + "CONVERT(DATETIME, '" + resultColList.get(i).getEndDate() + "')";
                                } else {
                                    strCondWhere += " and" + space + alias + resultColList.get(i).getSrcCol() + space
                                            + resultColList.get(i).getOperationType() + space + "'"
                                            + resultColList.get(i).getStartDate() + "' and '"
                                            + resultColList.get(i).getEndDate() + "'";
                                }
                            }
                        } else {
                            if (ObjectUtil.isNotEmpty(resultColList.get(i).getWhereVal())) {
                                SecureDataCheck.preventSqlInjection(resultColList.get(i).getWhereVal());
                                strCondWhere += " and" + space + alias + resultColList.get(i).getSrcCol()
                                        + resultColList.get(i).getOperationType() + resultColList.get(i).getWhereVal();
                            }
                        }
                    }

                    /**
                     * DATE_YYYYMMDD 날짜 텍스트(YYYYMMDD)
                     */
                    else if (resultColList.get(i).getCondType().trim().equals("DATE_YYYYMMDD")) {
                        if (resultColList.get(i).getOperationType().trim().equals("BETWEEN")) {
                            if (ObjectUtil.isNotEmpty(resultColList.get(i).getStartDate())
                                    && ObjectUtil.isNotEmpty(resultColList.get(i).getEndDate())) {
                                if (CommonUtil.DB_TYPE.ORACLE.equals(CommonUtil.getInstance().getDBType())) {
                                    strCondWhere += " and" + space + "to_date(" + alias
                                            + resultColList.get(i).getSrcCol() + ", 'YYYYMMDD')" + space
                                            + resultColList.get(i).getOperationType() + space + "to_date('"
                                            + resultColList.get(i).getStartDate() + "', 'yyyy-mm-dd hh24:mi:ss')"
                                            + " and " + "to_date('" + resultColList.get(i).getEndDate()
                                            + "', 'yyyy-mm-dd hh24:mi:ss')";
                                } else if (CommonUtil.DB_TYPE.MSSQL.equals(CommonUtil.getInstance().getDBType())) {
                                    strCondWhere += " and" + space + "CONVERT(DATE," + alias
                                            + resultColList.get(i).getSrcCol() + ")" + space
                                            + resultColList.get(i).getOperationType() + space + "CONVERT(DATETIME, '"
                                            + resultColList.get(i).getStartDate() + "')" + " and "
                                            + "CONVERT(DATETIME, '" + resultColList.get(i).getEndDate() + "')";
                                } else {
                                    strCondWhere += " and" + space + "to_date(" + alias
                                            + resultColList.get(i).getSrcCol() + ", 'YYYYMMDD')" + space
                                            + resultColList.get(i).getOperationType() + space + "'"
                                            + resultColList.get(i).getStartDate() + "' and '"
                                            + resultColList.get(i).getEndDate() + "'";
                                }
                            }
                        } else {
                            if (ObjectUtil.isNotEmpty(resultColList.get(i).getWhereVal())) {
                                SecureDataCheck.preventSqlInjection(resultColList.get(i).getWhereVal());
                                strCondWhere += " and" + space + alias + resultColList.get(i).getSrcCol()
                                        + resultColList.get(i).getOperationType() + resultColList.get(i).getWhereVal();
                            }
                        }
                    }

                    /**
                     * DATE_YYYYMM 날짜 텍스트(YYYYMM)
                     */
                    else if (resultColList.get(i).getCondType().trim().equals("DATE_YYYYMM")) {
                        if (resultColList.get(i).getOperationType().trim().equals("BETWEEN")) {
                            if (ObjectUtil.isNotEmpty(resultColList.get(i).getStartDate())
                                    && ObjectUtil.isNotEmpty(resultColList.get(i).getEndDate())) {
                                if (CommonUtil.DB_TYPE.ORACLE.equals(CommonUtil.getInstance().getDBType())) {
                                    strCondWhere += " and" + space + "to_date(" + alias
                                            + resultColList.get(i).getSrcCol() + ", 'YYYYMM')" + space
                                            + resultColList.get(i).getOperationType() + space + "to_date('"
                                            + resultColList.get(i).getStartDate() + "', 'yyyy-mm-dd hh24:mi:ss')"
                                            + " and " + "to_date('" + resultColList.get(i).getEndDate()
                                            + "', 'yyyy-mm-dd hh24:mi:ss')";
                                } else if (CommonUtil.DB_TYPE.MSSQL.equals(CommonUtil.getInstance().getDBType())) {
                                    strCondWhere += " and" + space + "CONVERT(DATE, " + alias
                                            + resultColList.get(i).getSrcCol() + ")" + space
                                            + resultColList.get(i).getOperationType() + space + "CONVERT(DATETIME, '"
                                            + resultColList.get(i).getStartDate() + "')" + " and "
                                            + "CONVERT(DATETIME, '" + resultColList.get(i).getEndDate() + "')";
                                } else {
                                    strCondWhere += " and" + space + "to_date(" + alias
                                            + resultColList.get(i).getSrcCol() + ", 'YYYYMM')" + space
                                            + resultColList.get(i).getOperationType() + space + "'"
                                            + resultColList.get(i).getStartDate() + "' and '"
                                            + resultColList.get(i).getEndDate() + "'";
                                }
                            }
                        } else {
                            if (ObjectUtil.isNotEmpty(resultColList.get(i).getWhereVal())) {
                                SecureDataCheck.preventSqlInjection(resultColList.get(i).getWhereVal());
                                strCondWhere += " and" + space + alias + resultColList.get(i).getSrcCol()
                                        + resultColList.get(i).getOperationType() + resultColList.get(i).getWhereVal();
                            }
                        }
                    }

                    /**
                     * DATETIME 날짜(시분) 달력이랑 시간이랑 같이 보내야됨.
                     */
                    else if (resultColList.get(i).getCondType().trim().equals("DATETIME")) {
                        if (resultColList.get(i).getOperationType().trim().equals("BETWEEN")) {
                            if (ObjectUtil.isNotEmpty(resultColList.get(i).getStartDate())
                                    && ObjectUtil.isNotEmpty(resultColList.get(i).getStartTime())
                                    && ObjectUtil.isNotEmpty(resultColList.get(i).getEndDate())
                                    && ObjectUtil.isNotEmpty(resultColList.get(i).getEndTime())) {
                                if (CommonUtil.DB_TYPE.ORACLE.equals(CommonUtil.getInstance().getDBType())) {
                                    strCondWhere += " and" + space + alias + resultColList.get(i).getSrcCol() + space
                                            + resultColList.get(i).getOperationType() + space + "to_date('"
                                            + resultColList.get(i).getStartDate() + resultColList.get(i).getStartTime()
                                            + "', 'yyyy-mm-dd hh24:mi')" + " and " + "to_date('"
                                            + resultColList.get(i).getEndDate() + resultColList.get(i).getEndTime()
                                            + "', 'yyyy-mm-dd hh24:mi')";
                                } else if (CommonUtil.DB_TYPE.MSSQL.equals(CommonUtil.getInstance().getDBType())) {
                                    strCondWhere += " and" + space + alias + resultColList.get(i).getSrcCol() + space
                                            + resultColList.get(i).getOperationType() + space + "CONVERT(DATETIME, '"
                                            + resultColList.get(i).getStartDate() + " "
                                            + resultColList.get(i).getStartTime() + "')" + " and "
                                            + "CONVERT(DATETIME, '" + resultColList.get(i).getEndDate() + " "
                                            + resultColList.get(i).getEndTime() + "')";
                                } else {
                                    strCondWhere += " and" + space + alias + resultColList.get(i).getSrcCol() + space
                                            + resultColList.get(i).getOperationType() + space + "'"
                                            + resultColList.get(i).getStartDate() + resultColList.get(i).getStartTime()
                                            + "' and '" + resultColList.get(i).getEndDate()
                                            + resultColList.get(i).getEndTime() + "'";
                                }
                            }
                        } else {
                            if (ObjectUtil.isNotEmpty(resultColList.get(i).getWhereVal())) {
                                SecureDataCheck.preventSqlInjection(resultColList.get(i).getWhereVal());
                                strCondWhere += " and" + space + alias + resultColList.get(i).getSrcCol()
                                        + resultColList.get(i).getOperationType() + resultColList.get(i).getWhereVal();
                            }
                        }
                    }

                    /**
                     * INT 숫자
                     */
                    else if (resultColList.get(i).getCondType().trim().equals("INT")) {
                        if (StringUtil.isNotEmpty(resultColList.get(i).getWhereVal())) {
                            strCondWhere += " and" + space + alias + resultColList.get(i).getSrcCol()
                                    + resultColList.get(i).getOperationType() + resultColList.get(i).getWhereVal();
                        }
                    }

                    /**
                     * SECURITY_TEXT 암호화 텍스트 암호화 컬럼은 무조건적으로 '=' 만 가능
                     */
                    else if (resultColList.get(i).getCondType().trim().equals("SECURITY_TEXT")) {
                        if (StringUtil.isNotEmpty(resultColList.get(i).getWhereVal())) {

                            if (resultColList.get(i).getOperationType().trim().equals(operationDataList.get(0))
                                    || resultColList.get(i).getOperationType().trim().equals(operationDataList.get(1))) {
                                for (String key : itemColListMap.keySet()) {
                                    if (resultColList.get(i).getSrcCol().equals(key)) {
                                        int mapInCount = 0;
                                        int mapNotCount = 0;
                                        int allInCount = 0;
                                        int allNotInCount = 0;
                                        for (String countForData : itemColListMap.get(key)) {
                                            countForData = countForData.replaceAll("-", "");
                                            String[] dataSplitOrgin = countForData.split("/");
                                            if (dataSplitOrgin[1].equals(operationDataList.get(0))) {
                                                allInCount++;
                                            }
                                            if (dataSplitOrgin[1].equals(operationDataList.get(1))) {
                                                allNotInCount++;
                                            }
                                        }
                                        for (String data : itemColListMap.get(key)) {
                                            data = data.replaceAll("-", "");
                                            String[] dataSplitOrgin = data.split("/");
                                            if (dataSplitOrgin[1].equals(operationDataList.get(0))) {
                                                if (mapInCount == 0) {
                                                    if (StringUtil.isNotEmpty(resultColList.get(i))) {

                                                        strCondWhere += " and" + space + alias + key + space + operationDataList.get(0) + "(";
                                                        strCondWhere += getEncrypt(StringUtil.getStrWhereSecurityValueEncoded(dataSplitOrgin[0], dataSplitOrgin[1]));
                                                    }
                                                } else {
                                                    if (StringUtil.isNotEmpty(resultColList.get(i))) {
                                                        strCondWhere += "," + getEncrypt(StringUtil.getStrWhereSecurityValueEncoded(dataSplitOrgin[0], dataSplitOrgin[1]));
                                                    }
                                                }
                                                mapInCount++;
                                                if (mapInCount == allInCount) {
                                                    strCondWhere += ")"; // last one
                                                }
                                                continue;
                                            }
                                            if (dataSplitOrgin[1].equals(operationDataList.get(1))) {
                                                if (mapNotCount == 0) {
                                                    if (StringUtil.isNotEmpty(resultColList.get(i))) {
                                                        strCondWhere += " and" + space + alias + key + space + operationDataList.get(1) + "(";
                                                        strCondWhere += getEncrypt(StringUtil.getStrWhereSecurityValueEncoded(dataSplitOrgin[0], dataSplitOrgin[1]));
                                                    }
                                                } else {
                                                    if (StringUtil.isNotEmpty(resultColList.get(i))) {
                                                        strCondWhere += "," + getEncrypt(StringUtil.getStrWhereSecurityValueEncoded(dataSplitOrgin[0], dataSplitOrgin[1]));
                                                    }
                                                }
                                                mapNotCount++;
                                                if (mapNotCount == allNotInCount) {
                                                    strCondWhere += ")"; // last one
                                                }
                                            }
                                        }
                                        break;
                                    }
                                }
                            } else {
                                if (StringUtil.isNotEmpty(resultColList.get(i).getWhereVal())) {
                                    String value = resultColList.get(i).getWhereVal();
                                    value = value.replaceAll("-", "");
                                    String type = "";

                                    strCondWhere += " and" + space + alias + resultColList.get(i).getSrcCol() + " = N"
                                            + getEncrypt(StringUtil.getStrWhereSecurityValueEncoded(value, type));
                                }
                            }
                        }
                    }
                    /**
                     * DATE_GREATER 날짜(>)
                     */
                    else if (resultColList.get(i).getCondType().trim().equals("DATE_GREATER")) {
                        if (ObjectUtil.isNotEmpty(resultColList.get(i).getStartDate())) {
                            if (CommonUtil.DB_TYPE.ORACLE.equals(CommonUtil.getInstance().getDBType())) {
                                strCondWhere += " and" + space + alias + resultColList.get(i).getSrcCol() + space
                                        + resultColList.get(i).getOperationType() + space + "to_date('"
                                        + resultColList.get(i).getStartDate() + "', 'yyyy-mm-dd hh24:mi:ss')";
                            } else if (CommonUtil.DB_TYPE.MSSQL.equals(CommonUtil.getInstance().getDBType())) {
                                strCondWhere += " and" + space + alias + resultColList.get(i).getSrcCol() + space
                                        + resultColList.get(i).getOperationType() + space + "CONVERT(DATETIME, '"
                                        + resultColList.get(i).getStartDate() + "')";
                            } else {
                                strCondWhere += " and" + space + alias + resultColList.get(i).getSrcCol() + space
                                        + resultColList.get(i).getOperationType() + space + "'"
                                        + resultColList.get(i).getStartDate();
                            }
                        }
                    }

                    /**
                     * 그외
                     */
                    else {

                        String value = resultColList.get(i).getWhereVal();
                        String type = resultColList.get(i).getOperationType().trim();
                        if (resultColList.get(i).getOperationType().trim().equals("LIKE")) {
                            if (StringUtil.isNotEmpty(resultColList.get(i).getWhereVal())) {
                                strCondWhere += " and" + space + alias + resultColList.get(i).getSrcCol()
                                        + resultColList.get(i).getOperationType() +  " "
                                        + StringUtil.getStrWhereValueEncoded(value, type);
                            }
                        } else {
                            if (resultColList.get(i).getOperationType().trim().equals(operationDataList.get(0))
                                    || resultColList.get(i).getOperationType().trim().equals(operationDataList.get(1))) {
                                for (String key : itemColListMap.keySet()) {
                                    if (resultColList.get(i).getSrcCol().equals(key)) {
                                        int mapInCount = 0;
                                        int mapNotCount = 0;
                                        int allInCount = 0;
                                        int allNotInCount = 0;
                                        for (String countForData : itemColListMap.get(key)) {
                                            countForData = countForData.replaceAll("-", "");
                                            String[] dataSplitOrgin = countForData.split("/");
                                            if (dataSplitOrgin[1].equals(operationDataList.get(0))) {
                                                allInCount++;
                                            }
                                            if (dataSplitOrgin[1].equals(operationDataList.get(1))) {
                                                allNotInCount++;
                                            }
                                        }
                                        for (String data : itemColListMap.get(key)) {
                                            data = data.replaceAll("-", "");
                                            String[] dataSplitOrgin = data.split("/");
                                            if (dataSplitOrgin[1].equals(operationDataList.get(0))) {
                                                if (mapInCount == 0) {
                                                    if (StringUtil.isNotEmpty(resultColList.get(i))) {
                                                        strCondWhere += " and" + space + alias + key + space + operationDataList.get(0) + "(";
                                                        strCondWhere += StringUtil.getStrWhereValueEncoded(dataSplitOrgin[0], dataSplitOrgin[1]);
                                                    }
                                                } else {
                                                    if (StringUtil.isNotEmpty(resultColList.get(i))) {
                                                        strCondWhere += "," + StringUtil.getStrWhereValueEncoded(dataSplitOrgin[0], dataSplitOrgin[1]);
                                                    }
                                                }
                                                mapInCount++;
                                                if (mapInCount == allInCount) {
                                                    strCondWhere += ")"; // last one
                                                }
                                                continue;
                                            }
                                            if (dataSplitOrgin[1].equals(operationDataList.get(1))) {
                                                if (mapNotCount == 0) {
                                                    if (StringUtil.isNotEmpty(resultColList.get(i))) {
                                                        strCondWhere += " and" + space + alias + key + space + operationDataList.get(1) + "(";
                                                        strCondWhere += StringUtil.getStrWhereValueEncoded(dataSplitOrgin[0], dataSplitOrgin[1]);
                                                    }
                                                } else {
                                                    if (StringUtil.isNotEmpty(resultColList.get(i))) {
                                                        strCondWhere += "," + StringUtil.getStrWhereValueEncoded(dataSplitOrgin[0], dataSplitOrgin[1]);
                                                    }
                                                }
                                                mapNotCount++;
                                                if (mapNotCount == allNotInCount) {
                                                    strCondWhere += ")"; // last one
                                                }
                                            }
                                        }
                                        break;
                                    }
                                }
                            } else {
                                if (StringUtil.isNotEmpty(resultColList.get(i).getWhereVal())) {
                                    strCondWhere += " and" + space + alias + resultColList.get(i).getSrcCol()
                                            + resultColList.get(i).getOperationType()
                                            + StringUtil.getStrWhereValueEncoded(value, type);
                                }
                            }
                        }
                    }
                }

            }
        } else {
            strCondWhere = "1=1";
        }

        return strCondWhere;
    }

    // fn getDecrypt 텍스트
    public String getStr_fn_getDecrypt(String col) {
        String str = "";
        String key = "";

//        try {
//            // key 조회
////            key = CryptoManager.getCipherKey();
//        }
//        catch (Exception e) {
//            LogUtil.error(e);
//        }

        // str = dataValue;

        return str;
    }

    // fn_getEncrypt 텍스트
    public String getEncrypt(String txt) {
        String str = "";
        String key = "";
        String dataKey = BeansUtil.getDbEncryptDataKey();
        String dataValue = null;

        String decrypted = BeansUtil.getApplicationProperty("icignal.security.endecrytped.endecrypted");

        if ("JAVA".equals(decrypted)) {
            dataValue = SecurityUtil.encodeDbAES256(dataKey, txt);
        } else if ("DB".equals(decrypted)) {
            EnDeCryptedService enDeCryptedService = (EnDeCryptedService) BeansUtil.getBean("enDeCryptedService");
            dataValue = enDeCryptedService.getDbEncrypted(txt);
        }

        str = "'" + dataValue + "'";

        return str;
    }

    public List<CommonCodeItemReqDto> getItem() {
        if (item == null) {
            item = new ArrayList<>();
        }
        return item;
    }

    public void setItem(List<CommonCodeItemReqDto> item) {
        this.item = item;
    }

    public String getExcelHeader() {
        return excelHeader;
    }

    public void setExcelHeader(String excelHeader) {
        this.excelHeader = excelHeader;
    }

    public String getExcelFooter() {
        return excelFooter;
    }

    public void setExcelFooter(String excelFooter) {
        this.excelFooter = excelFooter;
    }

    public void setStrCondWhere(String strCondWhere) {
        this.strCondWhere = strCondWhere;
    }

}
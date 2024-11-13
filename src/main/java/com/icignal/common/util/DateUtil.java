package com.icignal.common.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.TimeZone;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

/**
 * @name : infavor.util
 * @date : 2015. 10. 28.
 * @author : 류동균
 * @description : date util
 */
public class DateUtil extends CommonUtil {

	static final Logger logger = LoggerFactory.getLogger(DateUtil.class);

    /**
    * 일자들끼리 연산을 수행할때 Return값의 단위를 정해주는 상수로 사용된다.
    * 이 상수는 일단위의 값을 Return하여 준다.
    */
    public static final char DAY = 'D';

    /**
    * 일자들끼리 연산을 수행할때 Return값의 단위를 정해주는 상수로 사용된다.
    * 이 상수는 시단위의 값을 Return하여 준다.
    */
    public static final char HOUR = 'H';

    /**
    * 일자들끼리 연산을 수행할때 Return값의 단위를 정해주는 상수로 사용된다.
    * 이 상수는 분단위의 값을 Return하여 준다.
    */
    public static final char MIN = 'M';

    public static int getHour( ) {
        Calendar cal = Calendar.getInstance(Locale.getDefault()) ;
        return cal.get(Calendar.HOUR_OF_DAY) ;
    }
    public static int getMinute( ) {
        Calendar cal = Calendar.getInstance(Locale.getDefault()) ;
        return cal.get(Calendar.MINUTE) ;
    }
    public static int getYear( ) {
        Calendar cal = Calendar.getInstance(Locale.getDefault()) ;
        return cal.get(Calendar.YEAR) ;
    }
    public static int getMonth( ) {
        Calendar cal = Calendar.getInstance(Locale.getDefault()) ;
        return cal.get(Calendar.MONTH) ;
    }
    public static int getDate( ) {
        Calendar cal = Calendar.getInstance(Locale.getDefault()) ;
        return cal.get(Calendar.DATE) ;
    }
    /**
    * 오늘 일자를 지정된 Format의 날짜 표현형식으로 돌려준다.
    *
    * 사용예) getToday("yyyy/MM/dd hh:mm a")
    * 결 과 ) 2001/12/07 10:10 오후
    *
    * Format은 J2SE의 SimpleDateFormat의 Documentation을 참고한다.
    *
    * @return java.lang.String
    * @param pOutformat String
    */
    public static String getToday( String pOutformat) {
        String rDateString = null;
        Date vDate = new Date();

        rDateString = getDateFormat( pOutformat, vDate);

        return rDateString;
    }

    /**
    * 전달받은 날짜(Date)를 지정된 Format의 날짜 표현형식으로 돌려준다.
    *
    * 사용예) getToday("yyyy/MM/dd hh:mm a")
    * 결 과 ) 2001/12/07 10:10 오후
    *
    * Format은 J2SE의 SimpleDateFormat의 Documentation을 참고한다.
    *
    * @return java.lang.String
    * @param pOutformat String
    */
    public static String getDateFormat( String pOutformat, Date vDate) {

        SimpleDateFormat pOutformatter =  new SimpleDateFormat (pOutformat, java.util.Locale.KOREA);

        String rDateString = null;

        rDateString = pOutformatter.format(vDate);

        return rDateString;
    }
    /**
    * 전달받은 날짜(Date)를 지정된 Format의 날짜 표현형식으로 돌려준다.
    *
    * 사용예) getToday("yyyy/MM/dd hh:mm a")
    * 결 과 ) 2001/12/07 10:10 오후
    *
    * Format은 J2SE의 SimpleDateFormat의 Documentation을 참고한다.
    *
    * @return java.lang.String
    * @param pOutformat String
    */
    public static String getDateFormat(String pIndate, String pInformat, String pOutformat ) {

        SimpleDateFormat pInformatter =  new SimpleDateFormat (pInformat, java.util.Locale.KOREA);

        String rDateString = "";
        Date vIndate = null;

        try {
			vIndate = pInformatter.parse(pIndate);
			rDateString = getDateFormat(pOutformat,vIndate ) ;
		} catch (ParseException e) {
			rDateString = pIndate;
			LogUtil.error(e.getMessage(),e);
		}
            
        return rDateString;
    }
    /**
    * 전달받은 날짜(Date)를 지정된 Format의 날짜 표현형식으로 돌려준다.
    *
    * 사용예) getDateFormat("20101121","-")
    * 결 과 ) 2010-11-21
    *
    *
    * @return java.lang.String
    * @param type String
    */
    public static String getDateFormat( String date, String type) {
        String rDateString = null;
        rDateString = date.substring(0,4) + type + date.substring(4,6)+ type + date.substring(6) ;
        return rDateString;
    }
    /**
    * 입력받은 날짜에 일/시/분 단위의 값을 더하여 출력Format에 따라 값을 넘겨준다.
    * Parameter는 입력일, 입력일 Format, 출력일 Format, 일단위 더하기, 시단위 더하기,
    * 분단위 더하기이다.
    *
    * 간단한 사용예는 다음과 같다.
    *
    * 사용예) LLog.debug.println( getFormattedDateAdd("200201010605","yyyyMMddhhmm","yyyy/MM/dd HH:mm",-100,10,-11) );
    * 결과) 2001/09/23 15:54
    *
    * Format은 J2SE의 SimpleDateFormat의 Documentation을 참고한다.
    *
    * @return java.lang.String
    * @param pIndate String
    * @param pInformat String
    * @param pOutformat String
    * @param pDay int
    * @param pHour int
    * @param pMin int
    */
    public static String getFormattedDateAdd(String pIndate, String pInformat, String pOutformat, int pDay, int pHour, int pMin ) {

        SimpleDateFormat pInformatter =  new SimpleDateFormat (pInformat, java.util.Locale.KOREA);
        SimpleDateFormat pOutformatter =  new SimpleDateFormat (pOutformat, java.util.Locale.KOREA);

        String rDateString = "";
        Date vIndate = null;
        long vAddon =  pDay * 24L*60L*60L*1000L  +  pHour * 60L*60L*1000L  +  pMin * 60L*1000L ;

        try
        {
            vIndate = pInformatter.parse(pIndate);
            Date vAddday = new Date( vIndate.getTime() + vAddon );
            rDateString = pOutformatter.format(vAddday);
        } catch( ParseException e ) {
        	LogUtil.error(e);
            rDateString = pIndate;
        }

        return rDateString;
    }
    /**
    * 입력받은 날짜에 월 단위의 값을 더하여 출력Format에 따라 값을 넘겨준다.
    * Parameter는 입력일, 입력일 Format, 출력일 Format, 일단위 더하기, 시단위 더하기,
    * 분단위 더하기이다.
    *
    * 간단한 사용예는 다음과 같다.
    *
    * 사용예) LLog.debug.println( getFormattedDateAdd("200201010605","yyyyMMddhhmm","yyyy/MM/dd HH:mm",-6) );
    * 결과) 2001/09/23 15:54
    *
    * Format은 J2SE의 SimpleDateFormat의 Documentation을 참고한다.
    *
    * @return java.lang.String
    * @param pIndate String
    * @param pInformat String
    * @param pOutformat String
    * @param pDay int
    * @param pHour int
    * @param pMin int
    */
    public static String getFormattedDateYearAdd(String pIndate, String pInformat, String pOutformat, int pYear) {

        SimpleDateFormat pInformatter =  new SimpleDateFormat (pInformat, java.util.Locale.KOREA);
        SimpleDateFormat pOutformatter =  new SimpleDateFormat (pOutformat, java.util.Locale.KOREA);
        Calendar cal = Calendar.getInstance(Locale.getDefault()) ;
        String rDateString = "";
        Date vIndate = null;

        try {
			vIndate = pInformatter.parse(pIndate);
            cal.setTime(vIndate) ;
            cal.add(Calendar.YEAR, pYear) ;
            rDateString = pOutformatter.format(cal.getTime());
		} catch (ParseException e) {
			LogUtil.error(e.getMessage(), e);
			rDateString = pIndate;
		}

        return rDateString;
    }
    /**
    * 입력받은 날짜에 월 단위의 값을 더하여 출력Format에 따라 값을 넘겨준다.
    * Parameter는 입력일, 입력일 Format, 출력일 Format, 일단위 더하기, 시단위 더하기,
    * 분단위 더하기이다.
    *
    * 간단한 사용예는 다음과 같다.
    *
    * 사용예) LLog.debug.println( getFormattedDateAdd("200201010605","yyyyMMddhhmm","yyyy/MM/dd HH:mm",-6) );
    * 결과) 2001/09/23 15:54
    *
    * Format은 J2SE의 SimpleDateFormat의 Documentation을 참고한다.
    *
    * @return java.lang.String
    * @param pIndate String
    * @param pInformat String
    * @param pOutformat String
    * @param pDay int
    * @param pHour int
    * @param pMin int
    */
    public static String getFormattedDateMonthAdd(String pIndate, String pInformat, String pOutformat, int pMonth) {

        SimpleDateFormat pInformatter =  new SimpleDateFormat (pInformat, java.util.Locale.KOREA);
        SimpleDateFormat pOutformatter =  new SimpleDateFormat (pOutformat, java.util.Locale.KOREA);
        Calendar cal = Calendar.getInstance(Locale.getDefault()) ;
        String rDateString = "";
        Date vIndate = null;

        try {
			vIndate = pInformatter.parse(pIndate);
            cal.setTime(vIndate) ;
            cal.add(Calendar.MONTH, pMonth) ;
            rDateString = pOutformatter.format(cal.getTime());
		} catch (ParseException e) {
			rDateString = pIndate;
			LogUtil.error(e.getMessage(), e);
		}

        return rDateString;
    }

    /**
    * 입력받은 날짜에 월 단위의 값을 더하여 출력Format에 따라 값을 넘겨준다.
    * Parameter는 입력일, 입력일 Format, 출력일 Format, 일단위 더하기, 시단위 더하기,
    * 분단위 더하기이다.
    *
    * 간단한 사용예는 다음과 같다.
    *
    * 사용예) LLog.debug.println( getFormattedDateAdd("200201010605","yyyyMMddhhmm","yyyy/MM/dd HH:mm",-6) );
    * 결과) 2001/09/23 15:54
    *
    * Format은 J2SE의 SimpleDateFormat의 Documentation을 참고한다.
    *
    * @return java.lang.String
    * @param pIndate String
    * @param pInformat String
    * @param pOutformat String
    * @param pDay int
    * @param pHour int
    * @param pMin int
    */
    public static String getFormattedDateHourAdd(String pIndate, String pInformat, String pOutformat, int pHour) {

        SimpleDateFormat pInformatter =  new SimpleDateFormat (pInformat, java.util.Locale.KOREA);
        SimpleDateFormat pOutformatter =  new SimpleDateFormat (pOutformat, java.util.Locale.KOREA);
        Calendar cal = Calendar.getInstance(Locale.getDefault()) ;
        String rDateString = "";
        Date vIndate = null;

        try {
			vIndate = pInformatter.parse(pIndate);
            cal.setTime(vIndate) ;
            cal.add(Calendar.HOUR, pHour) ;
            rDateString = pOutformatter.format(cal.getTime());
		} catch (ParseException e) {
			rDateString = pIndate;
			LogUtil.error(e.getMessage(),e);
		}

        return rDateString;
    }

    public static String getFormattedDateMonthAdd(Date date,String pOutformat, int pMonth) {
        SimpleDateFormat pOutformatter =  new SimpleDateFormat (pOutformat, java.util.Locale.KOREA);
        Calendar cal = Calendar.getInstance(Locale.getDefault()) ;
        String rDateString = "";
        try {
            cal.setTime(date) ;
            cal.add(Calendar.MONTH, pMonth) ;
            rDateString = pOutformatter.format(cal.getTime());

        } catch( Exception e ) {
        	LogUtil.error(e);
            rDateString = date.toString();
        }
        return rDateString;
    }
    public static boolean isDate( String pOutformat, String vDate) {
        SimpleDateFormat pOutformatter =  new SimpleDateFormat (pOutformat, java.util.Locale.KOREA);
  //      Calendar cal = Calendar.getInstance(Locale.getDefault()) ;
        try {
			pOutformatter.parse(vDate);
			return true;
		} catch (ParseException e) {
			LogUtil.error(e.getMessage(), e);
			return false;
		}
            
    }
    /**
    * 일자들의 계산을 수행한다..
    * 제일 마지막의 Parameter pType에 따라서 Return값이 다르다.
    * 둘째 Parameter는 첫째 Parameter의 입력 형식을 지정하고 넷째 Parameter는
    * 셋째 Parameter의 입력형식을 지정한다.
    * Return값의 단위를 정해주는 pType에는 4가지가 올 수 있는데
    * ECOMJDateU.DAY, ECOMJDateU.HOUR, ECOMJDateU.MIN, ECOMJDateU.SEC 이다.
    * 각각의 단위는 일단위, 시단위, 분단위 이다.
    * 첫째 Parameter로 입력받은 일자에서 셋째 Parameter로 입력받은 일자를 빼서
    * 나온 결과를 돌려준다.
    * Format은 J2SE의 SimpleDateFormat의 Documentation을 참고한다.
    * 간단한 사용예는 다음과 같다.
    *
    * LLog.debug.println(getComputedDate("2002/01/04 00:01","yyyy/MM/dd hh:mm","2002/01/02 23:59","yyyy/MM/dd hh:mm",ECOMJDateU.DAY));
    *
    * 작업 결과로 '1'이 표시된다.
    *
    * @return long
    * @param pIndate1 java.lang.String
    * @param pInformat1 java.lang.String
    * @param pIndate2 java.lang.String
    * @param pInformat2 java.lang.String
    * @param pType char
    */

    public static long getComputedDate( String pIndate1, String pInformat1, String pIndate2, String pInformat2) {

        SimpleDateFormat pInformatter1 =  new SimpleDateFormat (pInformat1, Locale.KOREA);
        SimpleDateFormat pInformatter2 =  new SimpleDateFormat (pInformat2, Locale.KOREA);
        long vDategap = 0;
        Date vIndate1, vIndate2;
		try {
			vIndate1 = pInformatter1.parse(pIndate1);
            vIndate2 = pInformatter2.parse(pIndate2);
            vDategap = vIndate1.getTime() - vIndate2.getTime();
		} catch (ParseException e) {
			LogUtil.error(e.getMessage(),e);
			return 0;
		}

        return vDategap;
    }

    public static long getComputedDate( String pIndate1, String pInformat1, String pIndate2, String pInformat2, String pType) {

        SimpleDateFormat pInformatter1 =  new SimpleDateFormat (pInformat1, Locale.KOREA);
        SimpleDateFormat pInformatter2 =  new SimpleDateFormat (pInformat2, Locale.KOREA);
        long vDategap = 0;
        Date vIndate1, vIndate2;
		try {
			vIndate1 = pInformatter1.parse(pIndate1);
			vIndate2 = pInformatter2.parse(pIndate2);
            vDategap = vIndate1.getTime() - vIndate2.getTime();

            if(pType.equals("S")){
                vDategap = vDategap /(1000);            //초
            }else if(pType.equals("M")){
                vDategap = vDategap /(60*1000);         //분
            }else if(pType.equals("H")){
                vDategap = vDategap /(60*60*1000);      //시간
            }else if(pType.equals("D")){
                vDategap = vDategap /(24*60*60*1000);   //일
            }
		} catch (ParseException e) {
			return 0;
		}
            
        return vDategap;
    }

    public static long getComputedDate( String pIndate, String pInformat , String pType) {

        SimpleDateFormat pInformatter1 =  new SimpleDateFormat (pInformat, Locale.KOREA);
        Date curDate = null ;
        Calendar calendar = Calendar.getInstance() ;
        curDate = calendar.getTime() ;
        long vDategap = 0;
        Date vIndate1;
		try {
			vIndate1 = pInformatter1.parse(pIndate);
            vDategap = vIndate1.getTime() - curDate.getTime();

            if(pType.equals("S")){
                vDategap = vDategap /(1000);            //초
            }else if(pType.equals("M")){
                vDategap = vDategap /(60*1000);         //분
            }else if(pType.equals("H")){
                vDategap = vDategap /(60*60*1000);      //시간
            }else if(pType.equals("D")){
                vDategap = vDategap /(24*60*60*1000);   //일
            }
		} catch (ParseException e) {
			LogUtil.error(e.getMessage(), e);
			return 0;
		}
        
        return vDategap;
    }
    /**
     * amount 차이만큼 날짜를 반환한다.
     * @param amount
     * @return
     */
    public static String getAddDate( int amount ) {
        Calendar cal = Calendar.getInstance(Locale.getDefault());
                 cal.add(Calendar.DATE, amount);
        StringBuilder buf = new StringBuilder();
        buf.append(Integer.toString(cal.get(1)));
        String month = Integer.toString(cal.get(2) + 1);
        if(month.length() == 1)
            month = "0" + month;
        String day = Integer.toString(cal.get(5));
        if(day.length() == 1)
            day = "0" + day;
        buf.append(month).append(day);
        return buf.toString();
    }

    /**
     * amount 차이만큼 날짜를 반환한다.
     * @param basicDate
     * @param amount
     * @return
     */
    public static String getAddMonth( String basicDate , int amount ) {

        Calendar cal = Calendar.getInstance(Locale.getDefault());
        int basicYear = Integer.parseInt(basicDate.substring(0,4));
        int basicMonth= Integer.parseInt(basicDate.substring(4,6))-1;
        int basicDay  = Integer.parseInt(basicDate.substring(6,8));

        cal.set(basicYear, basicMonth, basicDay) ;
        cal.add(Calendar.MONTH, amount);

        StringBuilder buf = new StringBuilder();
        buf.append(Integer.toString(cal.get(1)));
        String month = Integer.toString(cal.get(2) + 1);
        if(month.length() == 1)
            month = "0" + month;
        String day = Integer.toString(cal.get(5));
        if(day.length() == 1)
            day = "0" + day;
        buf.append(month).append(day);
        return buf.toString();
    }

    /**
     * amount 차이만큼 날짜를 반환한다.
     * @param amount
     * @return
     */
    public static String getAddHour(int amount) {
        Calendar cal = Calendar.getInstance(Locale.getDefault());
        cal.add(Calendar.HOUR, amount);

        SimpleDateFormat dateprint = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);

        return dateprint.format(cal.getTime());
    }

    /**
     * amount 차이만큼 날짜를 반환한다.
     * @param amount
     * @return
     */
    public static String getAddMonth( int amount ) {
        Calendar cal = Calendar.getInstance(Locale.getDefault());
                 cal.add(Calendar.MONTH, amount);

        StringBuilder buf = new StringBuilder();
        buf.append(Integer.toString(cal.get(1)));
        String month = Integer.toString(cal.get(2) + 1);
        if(month.length() == 1)
            month = "0" + month;
        String day = Integer.toString(cal.get(5));
        if(day.length() == 1)
            day = "0" + day;
        buf.append(month).append(day);
        return buf.toString();
    }

    public static int getMaxDay(int argYear, int argMonth){
        int[] cDate = {29, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31} ;
        int lastday = cDate[ argMonth-0 ] ;
        if( argMonth == 2 && (argYear%4==0 && argYear%100!=0 || argYear%400==0) )
        lastday = cDate[0];

        return lastday;
    }

    /**
     * 해당날짜가 유효한지 확인
     * @param date
     * @return
     */
    public static boolean isDate(String date) {
        boolean result = false ;
        if( !StringUtils.hasLength(date) ) {
            return false;
        }
        if( date.length() != 8  ) {
            return false ;
        }
        int year = Integer.parseInt(date.substring(0,4) ) ;
        int month = Integer.parseInt(date.substring(4,6) ) ;
        int day = Integer.parseInt(date.substring(6) ) ;
        result = isDate( year, month, day);

        return result ;
    }
    /**
     * 해당날짜가 유효한지 확인
     * @param year
     * @param month
     * @param day
     * @return
     */
    public static boolean isDate(int year, int month, int day) {
        boolean result = false ;
        int lastDay = 0 ;
        if( year < 0 || month < 0 || day < 0 ) return false ;
        if ( month > 12 || day > 31 ) return false ;

        String year2 = Integer.toString(year) ;
        String month2 = "00" + month ;

        String yearMonth = year2+month2.substring(month2.length()-2) ;
        lastDay = getLastDayOfMonth(yearMonth);
        if(day > lastDay ) result = false ;
        else result = true ;
        return result ;
    }

    /**
     * 해당월에 마지막 일자 구하기
     * yyyymm
     * @param yearMonth
     * @return
     */
    public static int getLastDayOfMonth( String yearMonth)  {
        Calendar cal = Calendar.getInstance() ;
        int year = Integer.parseInt( yearMonth.substring(0,4) ) ;
        int month = Integer.parseInt( yearMonth.substring(4,6) ) ;

        cal.set(year, month-1,1) ;

        return cal.getActualMaximum(Calendar.DAY_OF_MONTH) ;
    }

    /**
     * <pre>
     * 입력받은 날짜 시간 yyyy-MM-dd HH:mm:ss 형식으로 반한
     * date는 format과 날짜형식이 같아야 한다.
     * </pre>
     * @param date EX)2011-11-11 11:11:11
     * @param format EX) "yyyy-MM-dd HH:mm:ss"
     * @return "yyyy-MM-dd HH:mm:ss"
     * @throws ParseException
     */
    public static String getReqDate(String date, String format) {
        return getCurrentDate(date, format, "yyyy-MM-dd HH:mm:ss");

    }

    /**
     * "yyyy-MM-dd HH:mm:SS"형의 날짜를 반환한다.
    @return yyyy-MM-dd HH:mm:SS 형의 날짜
    */
    public static String getCurrentDate() {
        return getCurrentDate("yyyy-MM-dd HH:mm:ss");
    }

    public static String getCurrentDate(String s) {
        SimpleDateFormat simpledateformat = new SimpleDateFormat(s, java.util.Locale.KOREA);
        return simpledateformat.format(new Date());
    }

    public static String getCurrentDate(String date, String format, String s) {
        SimpleDateFormat simpledateformat = new SimpleDateFormat(s, java.util.Locale.KOREA);
        SimpleDateFormat simpledateformat2 = new SimpleDateFormat(format, java.util.Locale.KOREA);

        try{
            return simpledateformat.format(simpledateformat2.parse(date));
        }catch (ParseException e) {
        	LogUtil.error(e);
            return "";
        }
    }

    public static String getCurrentDate(Date date, String s) {
        SimpleDateFormat simpledateformat = new SimpleDateFormat(s, java.util.Locale.KOREA);
        return simpledateformat.format(date);
    }

    public static int dayOfWeek(String date) {
        Calendar cal = Calendar.getInstance();
        int year = Integer.parseInt(date.substring(0,4) ) ;
        int month = Integer.parseInt(date.substring(4,6) ) ;
        int day = Integer.parseInt(date.substring(6) ) ;

        cal.set( year, month-1, day );
        return cal.get( Calendar.DAY_OF_WEEK );
    }


    public static long getDateDiff(String dataPart, String pIndate1) {

        String pInformat1 = "yyyy-MM-dd HH:mm:ss";
        String pInformat2 = "yyyy-MM-dd HH:mm:ss";

        return getDateDiff(dataPart, pIndate1, pInformat1, getCurrentDate(), pInformat2);
    }


    public static long getDateDiff(String dataPart, String pIndate1, String pIndate2) {

        String pInformat1 = "yyyy-MM-dd HH:mm:ss";
        String pInformat2 = "yyyy-MM-dd HH:mm:ss";

        return getDateDiff(dataPart, pIndate1, pInformat1, pIndate2, pInformat2);
    }
    /**<pre>     *
     * getDataDiff : 년,월,일,시,분,초 로 지난 시간을 (long)로 리턴
     * dataPart(y : 년, m : 월, d : 일, h : 시, n : 분, s : 초)
     * pIndate1 EX)2011-01-01 01:01:01
     * pInformat1 EX)yyyyMMdd hh:mm:ss
     * pIndate2 EX)2011-12-31 01:01:01
     * pInformat2 EX)yyyyMMdd hh:mm:ss
     * pIndate1, pIndate2 값이 "now" 경우 현재 날짜가 들어간다.
     * </pre>
     * @param dataPart
     * @param pIndate1
     * @param pInformat1
     * @param pIndate2
     * @param pInformat2
     * @return
     */
    public static long getDateDiff(String dataPart, String pIndate1, String pInformat1, String pIndate2, String pInformat2) {

        Date now = Calendar.getInstance().getTime();
        SimpleDateFormat nowFormatter =  new SimpleDateFormat ("yyyyMMdd HH:mm:ss", java.util.Locale.KOREA);

        Calendar calendar1 = Calendar.getInstance();
        Calendar calendar2 = Calendar.getInstance();
        
        SimpleDateFormat pInformatter1 =  new SimpleDateFormat (pInformat1, java.util.Locale.KOREA);
        SimpleDateFormat pInformatter2 =  new SimpleDateFormat (pInformat2, java.util.Locale.KOREA);

        String tempIndate1 = pIndate1.equals("now") ? nowFormatter.format(now).toString() : pIndate1;
        String tempIndate2 = pIndate2.equals("now") ? nowFormatter.format(now).toString() : pIndate2;
        String tempInformat2;
        if("now".equals(tempIndate1)) tempIndate1 = "yyyyMMdd HH:mm:ss";
        if("now".equals(pInformat2)) tempInformat2 = "yyyyMMdd HH:mm:ss";
        
        
      //  pInformat1 = "now".equals(pIndate1) ? "yyyyMMdd HH:mm:ss" : pInformat1;
      //  pInformat2 = "now".equals(pIndate2) ? "yyyyMMdd HH:mm:ss" : pInformat2;

        long vDategap = 0;

        try {
            Date vIndate1 = pInformatter1.parse(tempIndate1);
            Date vIndate2 = pInformatter2.parse(tempIndate2);

            calendar1.setTime(vIndate1);
            calendar2.setTime(vIndate2);

            long vDateGapYear   = calendar2.get(Calendar.YEAR) - calendar1.get(Calendar.YEAR);
            long vDateGapMonth  = calendar2.get(Calendar.MONTH) - calendar1.get(Calendar.MONTH);

            if ("y".equals(dataPart))
                vDategap = vDateGapYear;
            else if ("m".equals(dataPart))
                vDategap = vDateGapYear * 12 + vDateGapMonth;
            else if ("d".equals(dataPart))
                vDategap = (calendar2.getTimeInMillis() - calendar1.getTimeInMillis())/(1000*3600*24);
            else if ("h".equals(dataPart))
                vDategap = (calendar2.getTimeInMillis() - calendar1.getTimeInMillis())/(1000*3600);
            else if ("n".equals(dataPart))
                vDategap = (calendar2.getTimeInMillis() - calendar1.getTimeInMillis())/(1000*60);
            else if ("s".equals(dataPart))
                vDategap = (calendar2.getTimeInMillis() - calendar1.getTimeInMillis())/1000;
            else
                vDategap = 0;
        } catch ( ParseException e ) {
            LogUtil.error(e);
            return 0;
        }

        return vDategap;
    }

    /**<pre>     *
     * getDataDiff : 년,월,일,시,분,초 로 지난 시간을 (long)로 리턴
     * dataPart(y : 년, m : 월, d : 일, h : 시, n : 분, s : 초)
     * </pre>
     * @param dataPart
     * @param pIndate1
     * @param pIndate2
     * @return
     */
    public static long getDateDiff(String dataPart, Date pIndate1, Date pIndate2) {

        Calendar calendar1 = Calendar.getInstance();
        Calendar calendar2 = Calendar.getInstance();

        long vDategap = 0;

        calendar1.setTime(pIndate1);
        calendar2.setTime(pIndate2);

        long vDateGapYear = calendar2.get(Calendar.YEAR) - calendar1.get(Calendar.YEAR);
        long vDateGapMonth = calendar2.get(Calendar.MONTH) - calendar1.get(Calendar.MONTH);

        if ("y".equals(dataPart))
            vDategap = vDateGapYear;
        else if ("m".equals(dataPart))
            vDategap = vDateGapYear * 12 + vDateGapMonth;
        else if ("d".equals(dataPart))
            vDategap = (calendar2.getTimeInMillis() - calendar1.getTimeInMillis())/(1000*3600*24);
        else if ("h".equals(dataPart))
            vDategap = (calendar2.getTimeInMillis() - calendar1.getTimeInMillis())/(1000*3600);
        else if ("n".equals(dataPart))
            vDategap = (calendar2.getTimeInMillis() - calendar1.getTimeInMillis())/(1000*60);
        else if ("s".equals(dataPart))
            vDategap = (calendar2.getTimeInMillis() - calendar1.getTimeInMillis())/1000;
        else
            vDategap = 0;

        return vDategap;
    }

    // 해당 년의 몇번째 주인지
     public static int getYearWeek(String thisday) {

      int year = 0;
      int month = 0;
      int day = 0;

      Calendar cDate = Calendar.getInstance();  // Calendar 클래스의 인스턴스 생성
      year = Integer.parseInt(getDateFormat(thisday, "yyyyMMdd", "yyyy" ));
      month = Integer.parseInt(getDateFormat(thisday, "yyyyMMdd", "MM" ));
      day = Integer.parseInt(getDateFormat(thisday, "yyyyMMdd", "dd" ));

      cDate.set(year, month-1, day);

      return cDate.get(Calendar.WEEK_OF_YEAR);
     }


      public static long diffOfDate(String begin, String end) throws Exception
      {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);

        Date beginDate = formatter.parse(begin);
        Date endDate = formatter.parse(end);

        long diff = endDate.getTime() - beginDate.getTime();
        long diffDays = diff / (24 * 60 * 60 * 1000);

        return diffDays;
      }


      public static long diffOfHour(String begin, String end) throws Exception
      {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd", Locale.KOREA );

        Date beginDate = formatter.parse(begin);
        Date endDate = formatter.parse(end);

        long diff = endDate.getTime() - beginDate.getTime();
        long diffDays = diff / (60 * 60 * 1000);

        return diffDays;
      }



     /**
     * <PRE>
     * 1. MethodName    :   firstDateOfWeek
     * 2. Comment       :   해당일의 첫번째 날 리턴
     * 3. 작성자           :   retriver
     * 4. 작성일           :   2012. 4. 20.    오후 5:33:31
     * </PRE>
     *
     *  @param dtPrevDate
     *  @return
     *  @throws Exception
     */
    public static String firstDateOfWeek(String  dtPrevDate) throws Exception
    {
        Calendar cal = Calendar.getInstance(Locale.getDefault());
        cal.setFirstDayOfWeek(Calendar.MONDAY);
        cal.set(Integer.parseInt(dtPrevDate.substring(0, 4)), Integer.parseInt(dtPrevDate.substring(4, 6)) - 1, Integer.parseInt(dtPrevDate.substring(6)));

        int today = cal.get( Calendar.DAY_OF_WEEK);
        int firstDay = cal.getActualMinimum(Calendar.DAY_OF_WEEK);
        cal.add(Calendar.DAY_OF_MONTH, firstDay - today);

        String month = Integer.toString(cal.get(Calendar.MONTH ) + 1);
        if(month.length() == 1)
            month = "0" + month;
        String day = Integer.toString(cal.get(Calendar.DAY_OF_MONTH ));
        if(day.length() == 1)
            day = "0" + day;

        StringBuilder buf = new StringBuilder();
        buf.append(Integer.toString(cal.get(Calendar.YEAR )))
           .append(month)
           .append(day);
        return buf.toString();
    }



    static java.util.Calendar cal = java.util.Calendar.getInstance();

    /**
     * 현재날짜 기준으로 일 계산
     * curDate : yyyyMMdd
     * 주의 => the MONTH time field. Month value is 0-based. e.g., 0 for January
     **/
    public static String differenceDay(String curDate, int diffDay)
    {
        DateUtil.cal.set(Integer.parseInt(curDate.substring(0,4)), Integer.parseInt(curDate.substring(4,6))-1, Integer.parseInt(curDate.substring(6,8)));
        DateUtil.cal.add(DateUtil.cal.DATE, diffDay);


        String sYear = String.valueOf(DateUtil.cal.get(DateUtil.cal.YEAR));
        String sMonth = DateUtil.getTwoDigit(DateUtil.cal.get(DateUtil.cal.MONTH)+1);
        String sDay =  DateUtil.getTwoDigit(DateUtil.cal.get(DateUtil.cal.DATE));

        String sDate = sYear + sMonth + sDay;

        return sDate;
    }
    /**
     * 현재날짜 기준으로 월 계산
     * curDate : yyyyMMdd
     **/
    public static String differenceMonth(String curDate, int diffMonth) {
        DateUtil.cal.set(Integer.parseInt(curDate.substring(0,4)), Integer.parseInt(curDate.substring(4,6))-1, Integer.parseInt(curDate.substring(6,8)));
        DateUtil.cal.add(DateUtil.cal.MONTH, diffMonth);

        String sYear = String.valueOf(DateUtil.cal.get(DateUtil.cal.YEAR));
        String sMonth = DateUtil.getTwoDigit(DateUtil.cal.get(DateUtil.cal.MONTH)+1);
        String sDay =  DateUtil.getTwoDigit(DateUtil.cal.get(DateUtil.cal.DATE));

        if(sMonth.equals("00")) {
            sYear = String.valueOf(Integer.parseInt(sYear) - 1);
            sMonth = "12";
        }
        String sDate = sYear + sMonth + sDay;

        return sDate;
    }
    /**
     * 현재날짜 기준으로 년 계산
     * curDate : yyyyMMdd
     **/
    public static String differenceYear(String curDate, int diffYear) {
        DateUtil.cal.set(Integer.parseInt(curDate.substring(0,4)), Integer.parseInt(curDate.substring(4,6))-1, Integer.parseInt(curDate.substring(6,8)));
        DateUtil.cal.add(DateUtil.cal.YEAR, diffYear);

        String sYear = String.valueOf(DateUtil.cal.get(DateUtil.cal.YEAR));
        String sMonth = DateUtil.getTwoDigit(DateUtil.cal.get(DateUtil.cal.MONTH)+1);
        String sDay =  DateUtil.getTwoDigit(DateUtil.cal.get(DateUtil.cal.DATE));

        if(sMonth.equals("00")) {
            sYear = String.valueOf(Integer.parseInt(sYear) - 1);
            sMonth = "12";
        }
        String sDate = sYear + sMonth + sDay;

        return sDate;
    }
    /**
     * 입력 문자열을 default format 'yyyy-MM-dd' 유형인지 체크
     */
    public static void formatChk(String s) throws Exception
    {
        DateUtil.formatChk(s,"yyyy-MM-dd");
    }
    /**
     * 입력 문자열을 정의된 포맷으로 체크
     * 체크된 것이 유효하지 않으면 예외 처리
     **/
    public static void formatChk(String s, String format) throws java.text.ParseException
    {
        if(s == null) throw new IllegalArgumentException("Date String to Check is Null");
        if(format == null) throw new IllegalArgumentException("Format String to Check is Null");

        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(format, java.util.Locale.KOREA);
        java.util.Date date = null;

        try {
            date = formatter.parse(s);
        } catch(java.text.ParseException e) {
            throw new java.text.ParseException(e.getMessage() + " with format \"" + format + "\"",e.getErrorOffset());
        }

        if(!formatter.format(date).equals(s))
            throw new java.text.ParseException("Out of bound Date:\"" + s + "\" with format \"" + format + "\"", 0);

    }
    
    public static boolean formatChk2(String s, String format) {
    	boolean rtnValue = true;
    	
        if(s == null) rtnValue = false;
        if(format == null) rtnValue = false;
        
        if (rtnValue) {
	        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(format, java.util.Locale.KOREA);
	        java.util.Date date = null;
	
	        try {
	            date = formatter.parse(s);
	        } catch(java.text.ParseException e) {
	        	rtnValue = false;
	        }
	
	        if(!formatter.format(date).equals(s)) rtnValue = false;
        }
        
        return rtnValue;
    }
    
    /**
     * yyyyMMdd 형태의 날짜를 delimeter로 구분하여 보여준다.
     **/
    public static String formatDate(String val, String delimeter)
    {
    	String value = val;
        if(value == null) {
            return "0";
        } else {
        	value = val.trim();
            if(value.indexOf('-') > 0 || value.length() != 8) {
                return value;
            } else {
                StringBuffer sbString = new StringBuffer(value.substring(0,4));
                sbString.append(delimeter).append(value.substring(4,6)).append(delimeter).append(value.substring(6,8));
                return sbString.toString();
            }
        }
    }
    /**
     * HHmmss 형태의 날짜를 delimeter로 구분하여 보여준다.
     **/
    public static String formatTime(String val, String delimeter)
    {
    	String value = val;
        if(value == null) {
            return "0";
        } else {
        	value = val.trim();
            if(value.indexOf('-') > 0 || value.length() != 6) {
                return value;
            } else {
                StringBuffer sbString = new StringBuffer(value.substring(0,2));
                sbString.append(delimeter).append(value.substring(2,4)).append(delimeter).append(value.substring(4,6));
                return sbString.toString();
            }
        }
    }
    /**
     * 여러 Pattern 으로 현재 날짜와 시간의 정수값을 리턴
     **/
    public static int getDateByPattern(String pattern)  // getNumberByPattern
    {
        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(pattern, java.util.Locale.KOREA);
        String dateString = formatter.format(new java.util.Date());
        return Integer.parseInt(dateString);
    }
    /**
     * 'yyyy-MM-dd' 형으로 현재 날짜를 리턴
     **/
    public static String getDateString()
    {
        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd", java.util.Locale.KOREA);
        return formatter.format(new java.util.Date());
    }
    /**
     * 'yyyy-MM-dd HH:mm:ss' 형으로 현재날짜와 시간을 리턴
     **/
    public static int getDay()
    {
        return getDateByPattern("dd");
    }
    /**
     * 해당년월의 마지막 일자를 구한다.
     **/
    public static int getLastDate(int Year, int Month)
    {
        int [] daysInMonth = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        if(Year % 4==0 && Year % 100!=0 || Year % 400==0) daysInMonth[1] = 29;
        return daysInMonth[Month-1];
    }
    /**
     * 'MM' 형의 현재 월을 리턴
     **/
    public static int getMonthMM()
    {
        return getDateByPattern("MM");
    }
    /**
     * 'HHmmss' 형으로 현재 시간을 리턴
     **/
    public static String getShortTimeString()
    {
        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("HHmmss", java.util.Locale.KOREA);
        return formatter.format(new java.util.Date());
    }
    /**
     * 여러 Pattern 으로 현재 날짜와 시간의 스트링값을 리턴
     **/
    public static String getStringDateByPattern(String pattern) // getFormatString
    {
        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(pattern, java.util.Locale.KOREA);
        String dateString = formatter.format(new java.util.Date());
        return dateString;
    }
    /**
     * 'HH:mm:ss' 형으로 현재 시간을 리턴
     **/
    public static String getTimeString()
    {
        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("HH:mm:ss", java.util.Locale.KOREA);
        return formatter.format(new java.util.Date());
    }
    /**
     * 월,일의 경우 1digit 를 2digit으로 변환
     **/
    public static String getTwoDigit(int digit)
    {
        int iTemp;
        String sTemp;
        iTemp = digit;

        sTemp = iTemp >= 10 ? String.valueOf(iTemp) : "0" + iTemp;
        return sTemp;
    }
    /**
     * 월,일의 경우 1digit 를 2digit으로 변환
     **/
    public static String getTwoDigit(String digit)
    {
        int iTemp;
        String sTemp;
        iTemp = Integer.parseInt(digit);

        sTemp = iTemp >= 10 ? String.valueOf(iTemp) : "0" + iTemp;
        return sTemp;
    }
    /**
     * 'yyyy' 형으로 현재 년을 리턴
     **/
    public static int getYearYYYY()
    {
        return getDateByPattern("yyyy");
    }

    /**
     * 'yyyyMMdd' 형으로 현재 날짜를 리턴
     **/
    public static String getShortDateString()
    {
        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd", java.util.Locale.KOREA);
        return formatter.format(new java.util.Date());
    }

    public static String moveDay(String strCurDate, int day) throws IllegalAccessException{

        if(strCurDate == null || !(strCurDate.length() == 8 || strCurDate.length() == 14)) {
            throw new IllegalAccessException();
        }


        int iYear = Integer.parseInt(strCurDate.substring(0, 4));
        int iMonth = Integer.parseInt(strCurDate.substring(4, 6)) - 1;  // 달은 0부터 시작 한다.
        int iDay = Integer.parseInt(strCurDate.substring(6, 8));

        // 시간을 가져온다.
        int iHour = 0;
        int iMin = 0;
        int iSecond = 0;
        String pattern = "yyyyMMdd";
        if(strCurDate.length() == 14) {
            iHour = Integer.parseInt(strCurDate.substring(8, 10));
            iMin = Integer.parseInt(strCurDate.substring(10, 12));
            iSecond = Integer.parseInt(strCurDate.substring(12, 14));
            pattern = "yyyyMMddHHmmssSSS";
        }

        // Calendar객체를 생성하고 날짜와 시간을 설정한다.
        Calendar calCurDate = new GregorianCalendar();
        calCurDate.set(iYear, iMonth, iDay, iHour, iMin, iSecond);

        // 주어진 개월을 더한다.
        int iReturnMonth = calCurDate.get(Calendar.DATE) + day;

        // 달을 설정한다.
        calCurDate.set(Calendar.DATE, iReturnMonth);
        SimpleDateFormat formatter = new SimpleDateFormat (pattern, java.util.Locale.KOREA);

        String strResult = formatter.format(calCurDate.getTime());

        if(strCurDate.length() == 8) {
            strResult = strResult.substring(0, 8);
        }

        return strResult;
    }
    /**
     * @param strCurDate 주어진 날짜
     * @param iMonth 주어진 개월수( ex 1 이면 1개월 후의 날짜를 리턴 -1이면 1개월 이전의 날짜를 리턴)
     * @return 주어진 날짜의 주어진 개월 수 뒤의 날짜
     */
    public static String moveMonth(String strCurDate, int mon) throws IllegalAccessException{

        if(strCurDate == null || !(strCurDate.length() == 8 || strCurDate.length() == 14)) {
            throw new IllegalAccessException();
        }


        int iYear = Integer.parseInt(strCurDate.substring(0, 4));
        int iMonth = Integer.parseInt(strCurDate.substring(4, 6)) - 1;  // 달은 0부터 시작 한다.
        int iDay = Integer.parseInt(strCurDate.substring(6, 8));

        // 시간을 가져온다.
        int iHour = 0;
        int iMin = 0;
        int iSecond = 0;
        String pattern = "yyyyMMdd";
        if(strCurDate.length() == 14) {
            iHour = Integer.parseInt(strCurDate.substring(8, 10));
            iMin = Integer.parseInt(strCurDate.substring(10, 12));
            iSecond = Integer.parseInt(strCurDate.substring(12, 14));
            pattern = "yyyyMMddHHmmssSSS";
        }

        // Calendar객체를 생성하고 날짜와 시간을 설정한다.
        Calendar calCurDate = new GregorianCalendar();
        calCurDate.set(iYear, iMonth, iDay, iHour, iMin, iSecond);

        // 주어진 개월을 더한다.
        int iReturnMonth = calCurDate.get(Calendar.MONTH) + mon;

        // 달을 설정한다.
        calCurDate.set(Calendar.MONTH, iReturnMonth);
        SimpleDateFormat formatter = new SimpleDateFormat (pattern, java.util.Locale.KOREA);

        String strResult = formatter.format(calCurDate.getTime());

        if(strCurDate.length() == 8) {
            strResult = strResult.substring(0, 8);
        }

        return strResult;
    }

    /**
     * 날짜 비교
     * @param d1	날짜		(yyyy-MM-dd)
     * @param d2	비교날짜	(yyyy-MM-dd)
     * @return int (1:크다, -1:작다, 0:같다)
     * @throws ParseException
     */
    public static int dateCompare(String d1, String d2) throws ParseException {

        SimpleDateFormat format = new SimpleDateFormat( "yyyy-MM-dd" , Locale.KOREA);
        Date day1 = format.parse( d1 );
        Date day2 = format.parse( d2 );

        int compare = day1.compareTo( day2 );

        return compare;
    }
    
    /**
     * 날짜+시간 비교
     * @param d1	날짜		(yyyy-MM-dd)
     * @param d2	비교날짜	(yyyy-MM-dd)
     * @return int (1:크다, -1:작다, 0:같다)
     * @throws ParseException
     */
    public static int datetimeCompare(String d1, String d2, String fmt) throws ParseException {
    	
    	SimpleDateFormat format = new SimpleDateFormat( fmt , Locale.KOREA);
    	Date day1 = format.parse( d1 );
    	Date day2 = format.parse( d2 );
    	
    	int compare = day1.compareTo( day2 );
    	
    	return compare;
    }

    /**
     * 현재날짜 비교
     * @param d1			: 날짜
     * @param f				: date format
     * @return boolean 		: 기준 date가 현재 이후일때 true, 아니면 false, 같을 때 true
     * @throws ParseException
     */
    public static boolean getCompareToNowDate(String d1, String f) throws ParseException {

    	boolean rtn;
        SimpleDateFormat format = new SimpleDateFormat( f , Locale.KOREA);
        Date day1 = format.parse( d1 );
        Date day2 = format.parse( getToday(f) );
        
        if (day1.toString().equals(day2.toString())) {
        	rtn = true;
        } else {
        	rtn = day1.after(day2);
        }

        return rtn;
    }

    /**
     * 현재 기준 일 더하기
     * @param format	: Date Format
     * @param i			: 더하기 일
     * @return
     */
    public static String getNowAddDayDate(String format, int i) {
        Calendar cal = new GregorianCalendar(Locale.KOREA);
        cal.setTime(new Date());
        //cal.add(Calendar.YEAR, 1); // 1년을 더한다.
        //cal.add(Calendar.MONTH, 1); // 한달을 더한다.
        cal.add(Calendar.DAY_OF_YEAR, i); // 하루를 더한다.
        //cal.add(Calendar.HOUR, 1); // 시간을 더한다

        SimpleDateFormat fm = new SimpleDateFormat(format, Locale.KOREA);
        String strDate = fm.format(cal.getTime());

        return strDate;
    }

    /**
     * 시간 더하기
     *
     * @programId :
     * @name : getAddDayTime
     * @date : 2018. 3. 22.
     * @author : jh.kim
     * @table :
     * @param d 일시 ('yyyy-MM-dd HH:mm:ss')
     * @param h 시
     * @param m 분
     * @param s 초
     * @return
     * @throws ParseException
     * @description :
     */
    public static String getAddDayTime(String d, int h, int m, int s) throws ParseException {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss" , Locale.KOREA);
        Date dt = format.parse(d);

        Calendar cal = new GregorianCalendar(Locale.KOREA);
        cal.setTime(dt);
        cal.add(Calendar.HOUR_OF_DAY, h); // 시간을 더한다.
        cal.add(Calendar.MINUTE, m); // 분을 더한다.
        cal.add(Calendar.SECOND, s); // 초를 더한다.

        SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
        String strDate = fm.format(cal.getTime());

        return strDate;
    }

    /**
     * 일 더하기
     * @param d		: 날짜
     * @param i		: 더할 일수
     * @return
     * @throws ParseException
     */
    public static String getAddDayDate(String d, int i) throws ParseException {
    	SimpleDateFormat format = new SimpleDateFormat( "yyyy-MM-dd", Locale.KOREA );
        Date dt = format.parse( d );

        Calendar cal = new GregorianCalendar(Locale.KOREA);
        cal.setTime(dt);
        cal.add(Calendar.DAY_OF_YEAR, i); // 일수를 더한다.

        SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
        String strDate = fm.format(cal.getTime());

        return strDate;
    }
    
    /**
     * 일 더하기
     * @param d		: 날짜
     * @param i		: 더할 일수
     * @param f		: format
     * @return
     * @throws ParseException
     */
    public static String getAddDayDate(String d, int i, String f) throws ParseException {
    	SimpleDateFormat format = new SimpleDateFormat( f ,Locale.KOREA);
        Date dt = format.parse( d );

        Calendar cal = new GregorianCalendar(Locale.KOREA);
        cal.setTime(dt);
        cal.add(Calendar.DAY_OF_YEAR, i); // 일수를 더한다.

        SimpleDateFormat fm = new SimpleDateFormat( f , Locale.KOREA);
        String strDate = fm.format(cal.getTime());

        return strDate;
    }

    /**
     * 월 더하기
     * @param d		: 날짜
     * @param i		: 더할 월수
     * @return
     * @throws ParseException
     */
    public static String getAddMonthDate(String d, int i) throws ParseException {
    	SimpleDateFormat format = new SimpleDateFormat( "yyyy-MM-dd" , Locale.KOREA);
        Date dt = format.parse( d );

        Calendar cal = new GregorianCalendar(Locale.KOREA);
        cal.setTime(dt);
        cal.add(Calendar.MONTH, i); // 월수를 더한다.

        SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd" , Locale.KOREA);
        String strDate = fm.format(cal.getTime());

        return strDate;
    }
    
    /**
     * 월 더하기
     * @param d		: 날짜
     * @param i		: 더할 월수
     * @param f		: format
     * @return
     * @throws ParseException
     */
    public static String getAddMonthDate(String d, int i, String f) throws ParseException {
    	SimpleDateFormat format = new SimpleDateFormat( f , Locale.KOREA);
        Date dt = format.parse( d );

        Calendar cal = new GregorianCalendar(Locale.KOREA);
        cal.setTime(dt);
        cal.add(Calendar.MONTH, i); // 월수를 더한다.

        SimpleDateFormat fm = new SimpleDateFormat( f , Locale.KOREA);
        String strDate = fm.format(cal.getTime());

        return strDate;
    }

    /**
     * 해당 날짜의 마지막 월 말일 리턴
     * @param d		: 날짜
     * @return String
     * @throws ParseException
     */
    public static String getLastDayOfMonthDate(String d) throws ParseException  {
    	SimpleDateFormat format = new SimpleDateFormat( "yyyy-MM-dd" , Locale.KOREA);
        Date dt = format.parse( d );

        Calendar cal = new GregorianCalendar(Locale.KOREA);
        cal.setTime(dt);

        int i = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

        cal.set(Calendar.DATE, i);

        SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
        String strDate = fm.format(cal.getTime());

        return strDate;
    }
    
    /**
     * 해당 날짜의 마지막 월 말일 리턴
     * @param d		: 날짜
     * @param f		: format
     * @return String
     * @throws ParseException
     */
    public static String getLastDayOfMonthDate(String d, String f) throws ParseException  {
    	SimpleDateFormat format = new SimpleDateFormat( f ,Locale.KOREA);
        Date dt = format.parse( d );

        Calendar cal = new GregorianCalendar(Locale.KOREA);
        cal.setTime(dt);

        int i = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

        cal.set(Calendar.DATE, i);

        SimpleDateFormat fm = new SimpleDateFormat( f , Locale.KOREA);
        String strDate = fm.format(cal.getTime());

        return strDate;
    }

    /**
     * 해당 날짜의 요일 리턴
     * @param d
     * @param format
     * @return
     * @throws ParseException
     */
    public static int getDayOfWeek(String d) throws ParseException {
    	SimpleDateFormat fm = new SimpleDateFormat( "yyyy-MM-dd" , Locale.KOREA);
        Date dt = fm.parse( d );

        Calendar cal = new GregorianCalendar(Locale.KOREA);
        cal.setTime(dt);

        return cal.get( Calendar.DAY_OF_WEEK );
    }
    
    
    /**
	 * 월일시분초 형태로 날짜 반환 함수
	 * 
	 * @return String
	 */
	public  final static String getMMddHHmmss() {
		SimpleDateFormat sdf = new SimpleDateFormat("MMddHHmmss", java.util.Locale.KOREA);
		return sdf.format(new Date());
	}
	
	/**
	 * 년월일 형태로 날짜 반환 함수
	 * 
	 * @return String
	 */
	public  final static String getyyyyMMdd() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", java.util.Locale.KOREA);
		return sdf.format(new Date());
	}
	
	/**
	 * 날짜 클래스 반환 함수
	 * 
	 * @param year	년
	 * @param month	월
	 * @param day	일
	 * @return Date
	 */
	@SuppressWarnings("deprecation")
	public  final static java.sql.Date getDate(int year, int month, int day) {
		return new java.sql.Date(year - 1900, month - 1, day);
	}		
	
	/**
	 * 현재 시간과 타켓데이터의 시간을 비교하여 날짜 반환 함수
	 * 
	 * @return Date
	 */
	public  final static Date getCurrDate(){ 
        return new java.sql.Timestamp(new java.sql.Date(System.currentTimeMillis()).getTime());
        
		//return new java.sql.Date(System.currentTimeMillis());
	}
		
	/**
	 * 현재 시간과 타켓데이터의 시간을 비교하여 날짜 반환 함수(SNS Type)
	 * 
	 * @param date	대상 날짜
	 * @return String
	 */
	public  final static String getDiffFormat(Date date){
		String rtnValue = " 일전";
		
		Date currentDate = DateUtil.getCurrDate();
        
		int diffInDays = (int) ((currentDate.getTime() - date.getTime()) / (1000 * 60 * 60 * 24));
        
        if(diffInDays <= 0){
        	rtnValue = " 시간 전";
        	
        	int diffInHours = (int) ((currentDate.getTime() - date.getTime()) / (1000 * 60 * 60));
            
        	if(diffInHours <= 0){
        		rtnValue = " 분 전";
        		
        		int diffIMinutes = (int) ((currentDate.getTime() - date.getTime()) / (1000 * 60));
                
        		if(diffIMinutes <= 0){

        			rtnValue = " 방금 전";
        		}
        		else{
        			
        			rtnValue = diffIMinutes + rtnValue;
        		}
        	}
        	else{
        		rtnValue = diffInHours + rtnValue;
        	}
        }
        else{
        	rtnValue = diffInDays + rtnValue;
        }
        
        return rtnValue;
	}
	
	/**
	 * 년/월/일 시:분:초  형태의 날짜 문자열 반환 함수
	 * 
	 * @return String
	 */
	public  final static String getRegDate() {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss", java.util.Locale.KOREA);

		return sdf.format(new Date());

	}	

	
	
	/**
	 * 시분초 형태의 날짜 문자열 반환 함수
	 * 
	 * @return String
	 */
	public  final static String getHHmmss() {
		SimpleDateFormat sdf = new SimpleDateFormat("HHmmss", java.util.Locale.KOREA);
		return sdf.format(new Date());
	}
	
	
	/**
	 * ICNDateUtility 
	 * */
	
	/**	기본 날짜 포맷 */
	public final static  String yyyy ="yyyy";
	public final static  String MM ="MM";
	public final static  String dd ="dd";
	public final static  String HH ="HH";
	public final static  String mm ="mm";
	public final static  String ss ="ss";

	public final static  String yyyyMMdd_DASH = "yyyy-MM-dd";
	public final static  String yyyyMMdd_SLASH = "yyyy/MM/dd";
	public final static  String yyyyMMdd =  "yyyyMMdd";
	public final static  String HHmmss =  "HHmmss";
	
	public final static String yyyyMMddHHmmssSSS ="yyyyMMddHHmmssSSS";
	public final static String yyyyMMddHHmmss = "yyyyMMddHHmmss";

	public final static String DEFAULT_DATE_FORMAT = "yyyyMMddHHmmss";

	public final static String SIMPLE_DATE_FORMAT = "yyyy/MM/dd HH:mm:ss";
	public final static String HANGUL_DATE_FORMAT = "yyyy년 MM월 dd일 HH시 mm분 ss초";
	public final static String HANGUL_SHORT_DATE_FORMAT = "yyyy년 MM월 dd일";

	public final static String SHORT_DATE_FORMAT = "yyyy/MM/dd";


	/** 기본 TimeZone */
	public final static String DEFAULT_TIMEZONE = "JST";

    /**
     * Date를 timezone과 format에 따른 날짜 String으로 변환해서 리턴한다.
     * @param 	date 날짜
     * @param 	format 날짜 포맷 (예) yyyyMMddHHmmss
     * @param 	timezone Timezone (예) JST
     * @return 	날짜 String을 리턴한다. 변환도중 error발생시 null을 리턴한다.
     */
	public static String getFormattedDate(Date date, String format, String timezone) {
			java.util.TimeZone homeTz = java.util.TimeZone.getTimeZone(timezone);
			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(format);
			formatter.setTimeZone(homeTz);
			return formatter.format(date);
	}
	
	

        public static String getFormattedDate(long date) {
                return getFormattedDate(new Date(date), DEFAULT_DATE_FORMAT);
        }

        public static String getFormattedShortDate(long c_date) {
                return getFormattedDate(new Date(c_date), yyyyMMdd);
        }


        public static String getFormattedDate(long date, String format) {
            return getFormattedDate(new Date(date), format);
        }


     /**
      * 프로그램 실행시간 구하기(초)
      * @param start  시작시간(System.currentTimeMillis())
      * @param end   종료시간(System.currentTimeMillis())
      * @return
      */
     public static String getPerformTime_ss(long start , long end ){
         return String.valueOf((start - end) / 1000);
     }

    /**
     * Date의 format을 변경해서 리턴한다.
     * @param 	date 날짜
     * @param 	format1 날짜 포맷 (예) yyyyMMddHHmmss
     * @param 	format2 날짜 포맷 (예) yyyyMMddHHmmss
     * @return 	날짜 String을 리턴한다. 변환도중 error발생시 null을 리턴한다.
     */
	public static String changeForm(String date, String format1, String format2) {
		return getFormattedDate(getDate(date, format1), format2);
	}

	/**
	 * Date를 format에 따른 날짜 String으로 변환해서 리턴한다. (DEFAULT_TIMEZONE을 사용)
     * @param 	date 날짜
     * @param 	format 날짜 포맷 (예) yyyyMMddHHmmss
     * @return 	날짜 String을 리턴한다. 변환도중 error발생시 null을 리턴한다.
     */
	public static String getFormattedDate(Date date, String format) {
		return getFormattedDate(date, format, DEFAULT_TIMEZONE);
	}

	/**
	 * Date를 날짜 String으로 변환해서 리턴한다. (DEFAULT_TIMEZONE과 DEFAULT_DATE_FORMAT을 사용)
     * @param 	date 날짜
     * @return 	날짜 String을 리턴한다. 변환도중 error발생시 null을 리턴한다.
     */
	public static String getFormattedDate(Date date) {
		return getFormattedDate(date, DEFAULT_DATE_FORMAT);
	}

	/**
	 * Date를 yyyyMMdd 에 맞춰 리턴한다.
	 */
	public static String getFormattedShortDate(Date date) {
		return getFormattedDate(date, yyyyMMdd);
	}

	/**
	 * 날짜 String을 Date로 변환해서 리턴한다.
     * @param 	date 날짜 String
     * @param 	format 날짜 포맷
     * @return 	날짜 String을 Date로 변환해서 리턴한다. 변환도중 error발생시 null을 리턴한다.
     */
	public static Date getDate(String date, String format) {

		if (date == null || format == null) return null;
	
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(format);
		return formatter.parse(date, new java.text.ParsePosition(0));
	
	}

	/**
	 * 날짜 String을 Date로 변환해서 리턴한다. (DEFAULT_DATE_FORMAT을 사용)
     * @return 날짜 String을 Date로 변환해서 리턴한다. 변환도중 error발생시 null을 리턴한다.
     */
/*
	public static Date getDate(String date) {
		return getDate(date, DEFAULT_DATE_FORMAT);
	}
*/
	/**
	 * src_date가 시간상 target_date 이전인지를 check한다.
     * @param 	format 날짜 포맷
     * @return 	src_date가 target_date이전이면 true를 그렇지 않으면 false를 리턴한다.
     * @exception 	IllegalArgumentException 날짜 String이 포맷과 맞지 않을 경우 발생한다.
     */
	public static boolean before(String src_date, String target_date, String format) {
		Date src = getDate(src_date, format);
		Date target = getDate(target_date, format);

		if (src == null || target == null) {
			throw new java.lang.IllegalArgumentException();
		}

		return src.before(target);
	}

	/**
	 * src_date가 시간상 target_date 이전인지를 check한다. (DEFAULT_DATE_FORMAT을 사용)
     * @return	src_date가 target_date이전이면 true를 그렇지 않으면 false를 리턴한다.
     * @exception 	IllegalArgumentException 날짜 String이 포맷과 맞지 않을 경우 발생한다.
     */
	public static boolean before(String src_date, String target_date) {
		return before(src_date, target_date, DEFAULT_DATE_FORMAT);
	}

	/**
	 * src_date가 시간상 target_date 이후인지를 check한다.
     * @param	format 날짜 포맷
     * @return	src_date가 target_date이후이면 true를 그렇지 않으면 false를 리턴한다.
     * @exception	IllegalArgumentException 날짜 String이 포맷과 맞지 않을 경우 발생한다.
     */
	public static boolean after(String src_date, String target_date, String format) {
		Date src = getDate(src_date, format);
		Date target = getDate(target_date, format);

		if (src == null || target == null) {
			throw new java.lang.IllegalArgumentException();
		}

		return src.after(target);
	}

	/**
	 * src_date가 시간상 target_date 이후인지를 check한다. (DEFAULT_DATE_FORMAT을 사용)
     * @return	src_date가 target_date이후이면 true를 그렇지 않으면 false를 리턴한다.
     * @exception 	IllegalArgumentException 날짜 String이 포맷과 맞지 않을 경우 발생한다.
     */
	public static boolean after(String src_date, String target_date) {
		return after(src_date, target_date, DEFAULT_DATE_FORMAT);

	}

    /**
     * src_date가 시간상 target_date와 같은지 check한다.
     * @param 	format 날짜 포맷
     * @return 	src_date가 target_date와 같으면 true를 그렇지 않으면 false를 리턴한다.
     * @exception	IllegalArgumentException 날짜 String이 포맷과 맞지 않을 경우 발생한다.
     */
	public static boolean equals(String src_date, String target_date, String format) {
		
		if(src_date == null || target_date == null ) return false;
		
		Date src = getDate(src_date, format);
		Date target = getDate(target_date, format);

		if (src == null || target == null) {
			throw new java.lang.IllegalArgumentException();
		}

		return (src.compareTo(target) == 0) ? true:false;
	}

	/**
	 * src_date가 시간상 target_date와 같은지 check한다.
     * @return 	src_date가 target_date와 같으면 true를 그렇지 않으면 false를 리턴한다.
     * @exception	IllegalArgumentException 날짜 String이 포맷과 맞지 않을 경우 발생한다.
     */
	public static boolean equals(String src_date, String target_date) {
		return equals(src_date, target_date, DEFAULT_DATE_FORMAT);
	}

	/**
	 * start_date와 end_date 사이의 날자 간격을 리턴한다.
	 * @param 	format 날짜 포맷
	 * @exception 	IllegalArgumentException Parameter가 null이거나 날짜 포맷과 맞지 않는 경우 발생
	 */
	public static int difference(String start_date, String end_date, String format) {
		Date start = getDate(start_date, format);
		Date end = getDate(end_date, format);

		if (start == null || end == null) {
			throw new java.lang.IllegalArgumentException();
		}

		long lStart = start.getTime()/(1000*60*60*24);
		long lEnd = end.getTime()/(1000*60*60*24);

		return (int) Math.abs(lStart - lEnd);
	}

	/**
	 * start_date와 end_date 사이의 날자 간격을 리턴한다. (DEFAULT_DATE_FORMAT 사용)
	 * @exception 	IllegalArgumentException Parameter가 null이거나 날짜 포맷과 맞지 않는 경우 발생
	 */
	public static int difference(String start_date, String end_date) {
		return difference(start_date, end_date, DEFAULT_DATE_FORMAT);
	}


	/**
	 * src_date가 시간상 start_date와 end_date 사이에 있는지 check한다.
     * @param 	format 날짜 포맷
     * @return	true if start_data <= src_date <= end_date, otherwise false
     * @exception 	IllegalArgumentException 날짜 String이 포맷과 맞지 않을 경우 발생
     */
	public static boolean between(String src_date, String start_date, String end_date, String format) {
		Date src = getDate(src_date, format);
		Date start = getDate(start_date, format);
		Date end = getDate(end_date, format);

		if (src == null || start == null || end == null) {
			throw new java.lang.IllegalArgumentException();
		}

		return src.compareTo(start) < 0 || src.compareTo(end) > 0 ? false:true;
	}

	/**
	 * src_date가 시간상 start_date와 end_date 사이에 있는지 check한다. (DEFAULT_DATE_FORMAT을 사용)
     * @return	true if start_data <= src_date <= end_date, otherwise false
     * @exception 	IllegalArgumentException 날짜 String이 포맷과 맞지 않을 경우 발생한다.
     */
	public static boolean between(String src_date, String start_date, String end_date) {
		return between(src_date, start_date, end_date, DEFAULT_DATE_FORMAT);
	}

	/**
	 * src_date가 시간상 start_date와 end_date 사이에 있는지 check한다.
     * @return	true if start_data <= src_date <= end_date, otherwise false
     * @exception 	IllegalArgumentException Parameter가 null이거나 날짜 포맷과 맞지 않는 경우 발생
     */
	public static boolean between(Date src_date, Date start_date, Date end_date) {
		if (src_date == null || start_date == null || end_date == null) {
			throw new java.lang.IllegalArgumentException();
		}

		return src_date.compareTo(start_date) < 0 || src_date.compareTo(end_date) > 0 ? false:true;
	}


	/**
	 * date를 기준으로 n 분을 더한 날짜를 리턴한다.
	 * @exception 	IllegalArgumentException date가 null이면 발생
     */
	public static Date addMinute(Date date, int minute) {
		if (date == null) throw new java.lang.IllegalArgumentException();

		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone(DEFAULT_TIMEZONE));
		cal.setTime(date);
		cal.add(Calendar.MINUTE , minute);
		return cal.getTime();
	}

	/**
	 * date를 기준으로 n 시간을 더한 날짜를 리턴한다.
	 * @exception 	IllegalArgumentException date가 null이면 발생
     */
	public static Date addHour(Date date, int hour) {
		if (date == null) throw new java.lang.IllegalArgumentException();

		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone(DEFAULT_TIMEZONE));
		cal.setTime(date);
		cal.add(Calendar.HOUR , hour);
		return cal.getTime();
	}


	 /**
      *두날짜를 비교하여 그 차이를 반환한다.
      *@param  long befor  비교할 date
      *@param  long after   비교할 date
      *@return  String 결과치
      */
    public static String dateDiff(long befor, long after) {
             long diff = after - befor;
		long result = diff / (1000*60*60*24);
	     return String.valueOf(result);
	}



     /**
      *오늘부터 시점일까지의 날짜를 반환한다.
      *ex: 2002/11/18 의 30일전 2002/10/19
      *@param   int term   특정 가간일. ex: 30일-> 30
      *@return   String  특정일의 long값
      */
     public static String dateAdd(int term) {
         Calendar now = Calendar.getInstance();
         return dateAdd(now, term);

     }

    /**
      *특정일부터 시점일까지의 날짜를 반환한다.
      *ex: 2002/11/18 의 30일전 2002/10/19
      *@param   Calendar  특정일
      *@param   int term   특정 가간일. ex: 30일-> 30
      *@return   String      특정일의 long값
      */
    public static String dateAdd(Calendar now, int term) {
            now.add(Calendar.DAY_OF_YEAR, - (term));
            long time = now.getTime().getTime();
            return String.valueOf(time);
	}


	/**
	 * date를 기준으로 n날을 더한 날짜를 리턴한다.
	 * @exception 	IllegalArgumentException date가 null이면 발생
        */
	public static Date addDay(Date date, int day) {
		if (date == null) return null;
		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone(DEFAULT_TIMEZONE));
		cal.setTime(date);
		cal.add(Calendar.DAY_OF_MONTH , day);
		return cal.getTime();
	}

	/**
	 * date를 기준으로 n주를 더한 날짜를 리턴한다.
	 * @exception 	IllegalArgumentException date가 null일 경우 발생
     */
	public static Date addWeek(Date date, int week) {
		if (date == null) throw new java.lang.IllegalArgumentException();

		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone(DEFAULT_TIMEZONE));
		cal.setTime(date);
		cal.add(Calendar.WEEK_OF_YEAR, week);
		return cal.getTime();
	}

	/**
	 * date를 기준으로 n달을 더한 날짜를 리턴한다.
	 * @exception 	IllegalArgumentException date가 null일 경우 발생
     */
	public static Date addMonth(Date date, int month) {
		if (date == null) throw new java.lang.IllegalArgumentException();

		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone(DEFAULT_TIMEZONE));
		cal.setTime(date);
		cal.add(Calendar.MONTH, month);
		return cal.getTime();
	}

	/**
	 * 특정월(수)를 더한 달의 마지막 날짜를 구한다. 예: 2016-12-07이후 10개월이 지난 달의 마지막 날짜. 결과일자: 2017-10-31
	 * @param date
	 * @param month
	 * @exception 	IllegalArgumentException date가 null일 경우 발생
	 * @return
	 */
	public static Date getMonthLastDate(Date date, int addMonth){
		return getMonthLastDate(date, addMonth, DEFAULT_TIMEZONE);
	}

	/**
	 * 특정월(수)를 더한 달의 마지막 날짜를 구한다. 예: 2016-12-07이후 10개월이 지난 달의 마지막 날짜. 결과일자: 2017-10-31
	 * @param date
	 * @param addMonth
	 * @param timezone "JST"
	 * @return
	 */
	public static Date getMonthLastDate(Date date, int addMonth, String timezone){
		if (date == null) return null;
		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone(timezone));
		cal.setTime(date);
		cal.add(Calendar.MONTH, addMonth);

	  return getLastDayCalendar(cal).getTime();

	}


	/**
	 * date를 기준으로 n년을 더한 날짜를 리턴한다.
	 * @exception 	IllegalArgumentException date가 null일 경우 발생
     */
	public static Date addYear(Date date, int year) {
		if (date == null) throw new java.lang.IllegalArgumentException();
		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone(DEFAULT_TIMEZONE));
		cal.setTime(date);
		cal.add(Calendar.YEAR, year);
		return cal.getTime();
	}

	/**
	  * DEFAULT_DATE_FORMAT형태의 String Data를 SIMPLE_DATE_FORMAT형태의
	  * String Format 으로 리턴한다
	  */
	public static String toPrintForm(String date) {
	        Date dt = getDate(date);
	        return getFormattedDate(dt, SIMPLE_DATE_FORMAT);
	}

	/**
	  * DEFAULT_DATE_FORMAT형태의 String Data를 SHORT_DATE_FORMAT형태의
	  * String Format 으로 리턴한다
	  */
	public static String toShortForm(String date) {
        Date dt = getDate(date);
        return getFormattedDate(dt, SHORT_DATE_FORMAT);
	}

	/**
	  * SIMPLE_DATE_FORMAT형태의 String Data를 DEFAULT_DATE_FORMAT형태의
	  * String Format 으로 리턴한다
	  */
	public static String toDateForm(String date) {
	        Date dt = getDate(date, SIMPLE_DATE_FORMAT);
	        return getFormattedDate(dt);
	}

	/**
	  * 현재시간을 long값으로 으로 리턴한다
	  */
	public static long getTime() {
    		Date date = new Date();
		return date.getTime();
	}



	/**
	 * 지정된 일자의 마지막날짜를 가져온다
	 * @param s date
	 */
	public static String getLastDayOfMonth(String day , String pattern ){
		String p = getPattern(pattern);
		DateFormat dtFormat = 	new SimpleDateFormat(p, Locale.KOREA);
		String d = null;
		d = removeChar(day);
		Calendar cal = new GregorianCalendar(	Integer.parseInt(d.substring(0,4)),
												Integer.parseInt(d.substring(4,6))-1,
												Integer.parseInt(d.substring(6))
											 );
		return dtFormat.format(getLastDayCalendar(cal).getTime());
	}

	private static String removeChar(String str){
		if(str == null || str.trim().equals("")) return "";
		if(str.length() <= 8 ) return str;
		else return str.substring(0,4)+str.substring(5,7)+str.substring(8);

	}




	/**
	 * 지정된 일자의 첫날짜를 가져온다
	 * @param s date
	 * @return String 예: 2009-02-01
	 */
	public static String getFirstDayOfMonth(String day , String pattern ){
		String p = getPattern(pattern);
		DateFormat dtFormat = 	new SimpleDateFormat(p,Locale.KOREA);
		String d = null;
		d = removeChar(day);
		Calendar cal = new GregorianCalendar(	Integer.parseInt(d.substring(0,4)),
												Integer.parseInt(d.substring(4,6))-1,
												Integer.parseInt(d.substring(6))
											);

		return dtFormat.format(getFirstDayCalendar(cal).getTime());
	}


	public static String getPattern(String pattern){
		String p = null;
		p = pattern;
		if(p == null || p.trim().equals("")) p = "yyyy-MM-dd";
		return p;
	}

	/**
	 * 현재달의 첫날짜를 가져온다 예: 2009-02-01
	 * @param pattern String  yyyy-MM-dd
	 * @return String 예: 2009-02-01
	 */
	public static String getFirstDayOfCurrentMonth(String pattern) {
		String p = getPattern(pattern);
		DateFormat dtFormat = 	new SimpleDateFormat(p, Locale.KOREA);
    	return dtFormat.format(getFirstDayCalendar(Calendar.getInstance()).getTime());
	}


	private static Calendar getFirstDayCalendar(Calendar curCal){

		return new GregorianCalendar(	curCal.get(Calendar.YEAR),
			   							curCal.get(Calendar.MONTH),
			   							curCal.getActualMinimum ( Calendar.DATE )
			  						);

	}


	private static Calendar getLastDayCalendar(Calendar curCal){
		return new GregorianCalendar(	curCal.get(Calendar.YEAR),
			   							curCal.get(Calendar.MONTH),
			   							curCal.getActualMaximum ( Calendar.DATE )
			  						);

	}



	/**
	 * 현재달의 마지막날짜를 가져온다 예: 2009-02-28
	 * @param pattern String  yyyy-MM-dd
	 * @return String 예: 2009-02-28
	 */
	public static String getLastDayOfCurrentMonth(String pattern) {
		String p = getPattern(pattern);
		DateFormat dtFormat = new SimpleDateFormat(p, Locale.KOREA);
		return dtFormat.format(getLastDayCalendar(Calendar.getInstance()).getTime());

	}

////////////////////////////////////////////////////////////////////////////
	  // 일년 간 달력의 월별 날짜수 배열을 구한다.
	  //
	  public static int[] getMonthDaysArray(int yr) {
	    int[] a1 = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
	    int[] a2 = { 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

	    if (yr <= 1582) {
	      if (yr % 4 == 0) {
	        if (yr == 4) {
	          return a1;
	        }
	        return a2;
	      }
	    }
	    else {
	      if (yr % 4 == 0 && yr % 100 != 0) {
	        return a2;
	      }
	      else if (yr % 400 == 0) {
	        return a2;
	      }
	    }

	    return a1;
	  }


	  ////////////////////////////////////////////////////////////////////////////
	  // 지정된 년도와 달에 따른 요일 편차를 구한다.
	  //
	  public static int addWeekDays(int y, int m) {
	    int[] b1 = { 3, 0, 3, 2, 3, 2, 3, 3, 2, 3, 2, 3 };
	    int[] b2 = { 3, 1, 3, 2, 3, 2, 3, 3, 2, 3, 2, 3 };
	    int i = 0;
	    int rval = 0;

	    if (y <= 1582) {
	      if (y % 4 == 0) {
	        if (y == 4) {
	          for (i = 0; i < m - 1; i++)
	            rval += b1[i];
	        }
	        else {
	          for (i = 0; i < m - 1; i++)
	            rval += b2[i];
	        }
	      }
	      else {
	        for (i = 0; i < m - 1; i++)
	          rval += b1[i];
	      }
	    }
	    else {
	      if (y % 4 == 0 && y % 100 != 0) {
	        for (i = 0; i < m - 1; i++)
	          rval += b2[i];
	      }
	      else if (y % 400 == 0) {
	        for (i = 0; i < m - 1; i++)
	          rval += b2[i];
	      }
	      else {
	        for (i = 0; i < m - 1; i++)
	          rval += b1[i];
	      }
	    }

	    return rval;
	  }


	  ////////////////////////////////////////////////////////////////////////////
	  // 지정한 년도의 총 날짜 수를 구한다.
	  //
	  public static int getDaysInYear(int y) {
	    if (y > 1582) {
	        if (y % 400 == 0)
	            return 366;
	        else if (y % 100 == 0)
	            return 365;
	        else if (y % 4 == 0)
	            return 366;
	        else
	            return 365;
	    }
	    else if (y == 1582)
	        return 355;
	    else if (y > 4) {
	        if (y % 4 == 0)
	            return 366;
	        else
	            return 365;
	    }
	    else if (y > 0)
	        return 365;
	    else
	        return 0;
	  }


	  ////////////////////////////////////////////////////////////////////////////
	  // 지정한 년도, 지정한 월의 총 날짜 수를 구한다.
	  //
	  public static int getDaysInMonth(int m, int y) {
	    if (m < 1 || m > 12)
	        throw new IllegalArgumentException("Invalid month: " + m);

	    int[] b = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
	    if (m != 2 && m >= 1 && m <= 12 && y != 1582)
	        return b[m - 1];
	    if (m != 2 && m >= 1 && m <= 12 && y == 1582)
	        if (m != 10)
	            return b[m - 1];
	        else
	            return b[m - 1] - 10;

	    if (m != 2)
	        return 0;

	    // m == 2 (즉 2월)
	    if (y > 1582) {
	        if (y % 400 == 0)
	            return 29;
	        else if (y % 100 == 0)
	            return 28;
	        else if (y % 4 == 0)
	            return 29;
	        else
	            return 28;
	    }
	    else if (y == 1582)
	        return 28;
	    else if (y > 4) {
	        if (y % 4 == 0)
	            return 29;
	        else
	            return 28;
	    }
	    else if (y > 0)
	        return 28;
	    else
	        throw new IllegalArgumentException("Invalid year: " + y);
	  }


	  ////////////////////////////////////////////////////////////////////////////
	  // 지정한 년도의 지정한 월의 첫날 부터 지정한 날 까지의 날짜 수를 구한다.
	  //
	  public static int getDaysFromMonthFirst(int d, int m, int y) {
	    if (m < 1 || m > 12)
	        throw new IllegalArgumentException("Invalid month " + m + " in " + d + "/" + m + "/" + y);

	    int max = getDaysInMonth(m, y);
	    if (d >= 1 && d <= max)
	        return d;
	    else
	        throw new IllegalArgumentException("Invalid date " + d + " in " + d + "/" + m + "/" + y);
	  }


	  ////////////////////////////////////////////////////////////////////////////
	  // 지정한 년도의 첫날 부터 지정한 월의 지정한 날 까지의 날짜 수를 구한다.
	  //
	  public static int getDaysFromYearFirst(int d, int m, int y) {
	    if (m < 1 || m > 12)
	        throw new IllegalArgumentException("Invalid month " + m + " in " + d + "/" + m + "/" + y);

	    int max = getDaysInMonth(m, y);
	    if (d >= 1 && d <= max) {
	        int sum = d;
	        for (int j = 1; j < m; j++)
	            sum += getDaysInMonth(j, y);
	        return sum;
	    }
	    else
	        throw new IllegalArgumentException("Invalid date " + d + " in " + d + "/" + m + "/" + y);
	  }

	  ////////////////////////////////////////////////////////////////////////////
	  // 2000년 1월 1일 부터 지정한 년, 월, 일 까지의 날짜 수를 구한다.
	  // 2000년 1월 1일 이전의 경우에는 음수를 리턴한다.
	  //
	  public static int getDaysFrom21Century(int d, int m, int y) {
	    if (y >= 2000) {
	        int sum = getDaysFromYearFirst(d, m, y);
	        for (int j = y - 1; j >= 2000; j--)
	            sum += getDaysInYear(j);
	        return sum - 1;
	    }
	    else if (y > 0 && y < 2000) {
	        int sum = getDaysFromYearFirst(d, m, y);
	        for (int j = 1999; j >= y; j--)
	             sum -= getDaysInYear(y);
	        return sum - 1;
	    }
	    else
	        throw new IllegalArgumentException("Invalid year " + y + " in " + d + "/" + m + "/" + y);
	  }



	  ////////////////////////////////////////////////////////////////////////////
	  // 지정한 년도의 지정한 월의 첫날 부터 지정한 날 까지의 날짜 수를 구한다.
	  //
	  public static int getDaysFromMonthFirst(String s) {
	    int d, m, y;
	    if (s.length() == 8) {
	        y = Integer.parseInt(s.substring(0, 4));
	        m = Integer.parseInt(s.substring(4, 6));
	        d = Integer.parseInt(s.substring(6));
	        return getDaysFromMonthFirst(d, m, y);
	    }
	    else if (s.length() == 10) {
	        y = Integer.parseInt(s.substring(0, 4));
	        m = Integer.parseInt(s.substring(5, 7));
	        d = Integer.parseInt(s.substring(8));
	        return getDaysFromMonthFirst(d, m, y);
	    }
	    else if (s.length() == 11) {
	        d = Integer.parseInt(s.substring(0, 2));
	        String strM = s.substring(3, 6).toUpperCase();
	        String[] monthNames = { "JAN", "FEB", "MAR", "APR", "MAY", "JUN",
	                                "JUL", "AUG", "SEP", "OCT", "NOV", "DEC" };
	        m = 0;
	        for (int j = 1; j <= 12; j++) {
	            if (strM.equals(monthNames[j-1])) {
	                m = j;
	                break;
	            }
	        }
	        if (m < 1 || m > 12)
	            throw new IllegalArgumentException("Invalid month name: " + strM + " in " + s);
	        y = Integer.parseInt(s.substring(7));
	        return getDaysFromMonthFirst(d, m, y);
	    }
	    else
	        throw new IllegalArgumentException("Invalid date format: " + s);
	  }


	  ////////////////////////////////////////////////////////////////////////////
	  // 지정한 년도의 첫날 부터 지정한 월의 지정한 날 까지의 날짜 수를 구한다.
	  //
	  public static int getDaysFromYearFirst(String s) {
	    int d, m, y;
	    if (s.length() == 8) {
	        y = Integer.parseInt(s.substring(0, 4));
	        m = Integer.parseInt(s.substring(4, 6));
	        d = Integer.parseInt(s.substring(6));
	        return getDaysFromYearFirst(d, m, y);
	    }
	    else if (s.length() == 10) {
	        y = Integer.parseInt(s.substring(0, 4));
	        m = Integer.parseInt(s.substring(5, 7));
	        d = Integer.parseInt(s.substring(8));
	        return getDaysFromYearFirst(d, m, y);
	    }
	    else if (s.length() == 11) {
	        d = Integer.parseInt(s.substring(0, 2));
	        String strM = s.substring(3, 6).toUpperCase();
	        String[] monthNames = { "JAN", "FEB", "MAR", "APR", "MAY", "JUN",
	                                "JUL", "AUG", "SEP", "OCT", "NOV", "DEC" };
	        m = 0;
	        for (int j = 1; j <= 12; j++) {
	            if (strM.equals(monthNames[j-1])) {
	                m = j;
	                break;
	            }
	        }
	        if (m < 1 || m > 12)
	            throw new IllegalArgumentException("Invalid month name: " + strM + " in " + s);
	        y = Integer.parseInt(s.substring(7));
	        return getDaysFromYearFirst(d, m, y);
	    }
	    else
	        throw new IllegalArgumentException("Invalid date format: " + s);
	  }


	  //////////////////////////////////////////////////////////////////////
	  // 2000년 1월 1일 부터 지정한 년, 월, 일 까지의 날짜 수를 구한다.
	  // 2000년 1월 1일 이전의 경우에는 음수를 리턴한다.
	  //
	  public static int getDaysFrom21Century(String s) {
	    int d, m, y;
	    if (s.length() == 8) {
	        y = Integer.parseInt(s.substring(0, 4));
	        m = Integer.parseInt(s.substring(4, 6));
	        d = Integer.parseInt(s.substring(6));
	        return getDaysFrom21Century(d, m, y);
	    }
	    else if (s.length() == 10) {
	        y = Integer.parseInt(s.substring(0, 4));
	        m = Integer.parseInt(s.substring(5, 7));
	        d = Integer.parseInt(s.substring(8));
	        return getDaysFrom21Century(d, m, y);
	    }
	    else if (s.length() == 11) {
	        d = Integer.parseInt(s.substring(0, 2));
	        String strM = s.substring(3, 6).toUpperCase();
	        String[] monthNames = { "JAN", "FEB", "MAR", "APR", "MAY", "JUN",
	                                "JUL", "AUG", "SEP", "OCT", "NOV", "DEC" };
	        m = 0;
	        for (int j = 1; j <= 12; j++) {
	            if (strM.equals(monthNames[j-1])) {
	                m = j;
	                break;
	            }
	        }
	        if (m < 1 || m > 12)
	            throw new IllegalArgumentException("Invalid month name: " + strM + " in " + s);
	        y = Integer.parseInt(s.substring(7));
	        return getDaysFrom21Century(d, m, y);
	    }
	    else
	        throw new IllegalArgumentException("Invalid date format: " + s);
	  }


	  /////////////////////////////////////////////
	  // (양 끝 제외) 날짜 차이 구하기
	  //
	  public static int getDaysBetween(String s1, String s2) {
	    int y1 = getDaysFrom21Century(s1);
	    int y2 = getDaysFrom21Century(s2);
	    return y1 - y2 - 1;
	  }


	  /////////////////////////////////////////////
	  // 날짜 차이 구하기
	  //
	  public static int getDaysDiff(String s1, String s2) {
	    int y1 = getDaysFrom21Century(s1);
	    int y2 = getDaysFrom21Century(s2);
	    return y1 - y2;
	  }


	  /////////////////////////////////////////////
	  // (양 끝 포함) 날짜 차이 구하기
	  //
	  public static int getDaysFromTo(String s1, String s2) {
	    int y1 = getDaysFrom21Century(s1);
	    int y2 = getDaysFrom21Century(s2);
	    return y1 - y2 + 1;
	  }


	  ////////////////////////////////////////////////////////////////////////////
	  // 지정한 년도, 지정한 월에 지정한 요일이 들어 있는 회수를 구한다.
	  //
	  public static int getWeekdaysInMonth(int weekDay, int m, int y) {
	    int week = (weekDay - 1) % 7;
	    int days = getDaysInMonth(m, y);
	    int sum = 6;   // 2000년 1월 1일은 토요일
	    if (y >= 2000) {
	      for (int i = 2000; i < y; i++)
	        sum += getDaysInYear(i);
	    }
	    else {
	      for (int i = y; i < 2000; i++)
	        sum -= getDaysInYear(i);
	    }
	    for (int i = 1; i < m; i++)
	      sum += getDaysInMonth(i, y);

	    // if (sum < 0)
	    //  sum += 350*3000;

	    int firstWeekDay = sum % 7;
	    if (firstWeekDay < 0) {
	        firstWeekDay += 7;
	    }

	    // firstWeekDay += 1;
	    int n = firstWeekDay + days;
	    int counter = (n / 7) + n % 7 > week ? 1 : 0;
	    if (firstWeekDay > week)
	      counter--;

	    return counter;
	  }


	  ////////////////////////////////////////////////////////////////////////////
	  // 지정한 년도의 지정한 달에 지정한 요일이 들어 있는 회수를 구한다.
	  //
	  public static int getWeekdaysInMonth(String weekName, int m, int y) {
	    StringBuffer weekNames1 = new StringBuffer("일월화수목금토");
	    StringBuffer weekNames2 = new StringBuffer("日月火水木金土");
	    String[] weekNames3 = { "sun", "mon", "tue", "wed", "thu", "fri", "sat" };

	    int n = weekNames1.indexOf(weekName);
	    if (n < 0)
	      n = weekNames2.indexOf(weekName);
	    if (n < 0) {
	      String str = weekName.toLowerCase();
	      for (int i = 0; i < weekNames3.length; i++) {
	        if (str.equals(weekNames3[i])) {
	          n = i;
	          break;
	        }
	      }
	    }
	    // System.out.println("n = " + n);

	    if (n < 0)
	      throw new IllegalArgumentException("Invalid week name: " + weekName);

	    return getWeekdaysInMonth(n + 1, m, y);
	  }


	  ////////////////////////////////////////////////////////////////////////////
	  // 2000년 1월 1일 기준을 n일 경과한 날짜 구하기
	  //
	  // @return  yyyy-mm-dd 양식의 String 타입
	  public static String getDateStringFrom21Century(int elapsed) {
	    int y = 2000;
	    int m = 1;
	    int d = 1;

	    int n = elapsed + 1;
	    int j = 2000;
	    if (n > 0) {
	      while (n > getDaysInYear(j)) {
	        n -= getDaysInYear(j);
	        j++;
	      }
	      y = j;

	      int i = 1;
	      while (n > getDaysInMonth(i, y)) {
	        n -= getDaysInMonth(i, y);
	        i++;
	      }
	      m = i;
	      d = n;
	    }
	    else if (n < 0) {
	      while (n < 0) {
	        n += getDaysInYear(j - 1);
	        j--;
	      }
	      y = j;

	      int i = 1;
	      while (n > getDaysInMonth(i, y)) {
	        n -= getDaysInMonth(i, y);
	        i++;
	      }
	      m = i;
	      d = n;
	    }

	    String strY = Integer.toString(y);
	    String strM = "";
	    String strD = "";

	    if (m < 10)
	      strM = "0" + m;
	    else
	      strM = Integer.toString(m);

	    if (d < 10)
	      strD = "0" + d;
	    else
	      strD = Integer.toString(d);

	    return strY + "-" + strM + "-" + strD;
	  }

      /**
	   * 지정한 날짜를 offset일 경과한 날짜 구하기
	   * @param offset
	   * @param d
	   * @param m
	   * @param y
	   * @return yyyy-mm-dd 양식의 String 타입
	   */
	  public static String addDate(int offset, int d, int m, int y) {
	    int z = getDaysFrom21Century(d, m, y);
	    int n = z + offset;
	    return getDateStringFrom21Century(n);
	  }


	  ///////////////////
	  // 지정한 날짜를 offset일 경과한 날짜 구하기
	  //
	  // @return  yyyy-mm-dd 양식의 String 타입
	  public static String addDate(int offset, String date) {
	    int z = getDaysFrom21Century(date);
	    int n = z + offset;
	    return getDateStringFrom21Century(n);
	  }


	  /**
	   *  달 차이 구하기
	   * @param s1
	   * @param s2
	   * @return int
	   */
	   public static int getMonthBetween(String s1, String s2) {
		  int day = getDaysBetween(s1, s2);
	      int month = day/30;
	    return month;
	  }

	  /**
	   * 지정된 몇달 후의 일자를 가져온다.  format : yyyy-mm-dd 예: 2월13일 기준 1달후는 3월13일
	   * @param date 시작일
	   * @param term 몇달 후
	   * @return String  yyyy-mm-dd
	   */
	  public static String getAfterMonth(Date date, int term) {
		  //return getFormattedDate(addMonth(date, term), yyyyMMdd_DASH);
		  return getAfterMonth(date, term, yyyyMMdd_DASH);
	  }


	  /**
	   * 지정된 날부터 몇달 후의 일자를 가져온다.  format : yyyy-mm-dd  예: 2월13일 기준 1달후는 3월13일
	   * @param date 시작일
	   * @param term 몇달 후
	   * @return String  yyyy-mm-dd
	   */
	  public static String getAfterMonth(Date date, int term, String pattern) {

		  return getFormattedDate( addMonth(date, term) , pattern);
	  }

	  /**
	   * 지정된 날부터 몇달 후의 일자를 가져온다.  format : yyyy-mm-dd  예: 2월13일 기준 1달후는 3월12일
	   * @param date 시작일
	   * @param term 몇달 후
	   * @return String  yyyy-mm-dd
	   */
	  public static String getAfterMonthBus(Date date, int term, String pattern) {
		  Date ad = addMonth(date, term);
		  return getFormattedDate( addDay(ad, -1) , pattern);
	  }


	  /**
	   * 지정된 몇달 후의 일자를 가져온다.  format : yyyy-mm-dd 	예: 2월13일 기준 1달후는 3월12일
	   * @param date 시작일
	   * @param term 몇달 후
	   * @return String  yyyy-mm-dd
	   */
	  public static String getAfterMonthBus(Date date, int term) {
		  //return getFormattedDate(addMonth(date, term), yyyyMMdd_DASH);
		  return getAfterMonthBus(date, term, yyyyMMdd_DASH);
	  }


	  /**
	   * 해당일의 요일을 가져온다. 일요일-> 1.
	   *
	   * @param date  yyyyMMdd형식의 문자열
	   * @return int
	   */
	/* public static int getDayOfWeek(String date ){
		 Date d = DateUtil.getDate(date, yyyyMMdd);
		 Calendar cal = Calendar.getInstance();
		 cal.setTime(d);
		return cal.get(Calendar.DAY_OF_WEEK);
	 }
*/

	 /**
	   * 해당월이 몇주까지 있는지를 가져온다.  예: 20090301 -> 5
	   *
	   * @param date  yyyyMMdd형식의 문자열
	   * @return int
	   */
//	 public static int getCountWeekOfMonth(String date ){
//		 String lastDate = DateUtil.getLastDayOfMonth(date, yyyyMMdd);
//		 Date d = DateUtil.getDate(lastDate, yyyyMMdd);
//		 Calendar cal = Calendar.getInstance();
//		 cal.setTime(d);
//		return cal.get(Calendar.WEEK_OF_MONTH);
//	 }
//
//


	 /**
	  * 달 및 일짜의  문자열 2자리형식으로 리턴한다. 1월 -> 01, 2월 -> 02
	  * @param month
	  * @return
	  */
	public static String getMD2CipherFormat(int month){
		String result = null;
		result = month < 10 ? "0"+month:String.valueOf(month);
		return result;

	}

     /**
      * 시분초 제외된 Date 가져오기
      * @param localDate
      * @return
      */
	 public static Date asDate(LocalDate localDate) {
		    return Date.from(localDate.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());
	  }
	 
	 
	 public static Date asDate(LocalDateTime localDateTime) {
		    return Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
	 }

	 public static LocalDate asLocalDate(Date date) {
		    return Instant.ofEpochMilli(date.getTime()).atZone(ZoneId.systemDefault()).toLocalDate();
	 }

	 public static LocalDateTime asLocalDateTime(Date date) {
		    return Instant.ofEpochMilli(date.getTime()).atZone(ZoneId.systemDefault()).toLocalDateTime();
	 }


	
	public static void main(String args[]){
		
		
		//System.out.println(getFormattedDate(new Date(), yyyyMMdd));
		//System.out.println(getFormattedDate(new Date(), HHmmss));
		
		/*Date date = asDate(LocalDate.now());
		System.out.println(date);
		
		
		LocalDate today = LocalDate.now();
		
		System.out.println(today);
		
		System.out.println(addDay(new Date(), -1));*/
		
		/*System.out.println(DateUtil.getFormattedDate(new Date(), DateUtil.yyyy));
		System.out.println(DateUtil.getFormattedDate(new Date(), DateUtil.MM));
		System.out.println(DateUtil.getFormattedDate(new Date(), DateUtil.dd));
		System.out.println(DateUtil.getFormattedDate(new Date(), DateUtil.HH));
		System.out.println(DateUtil.getFormattedDate(new Date(), DateUtil.mm));
		System.out.println(DateUtil.getFormattedDate(new Date(), DateUtil.ss));
		*/
		//System.out.println(addDate(1,DateUtil.getLastDayOfMonth("2009-04-01", DateUtil.yyyyMMdd_DASH)));
	//	System.out.println(getCountWeekOfMonth("20090501"));
	//System.out.println(	getDaysDiff("2009-04-03", "2009-03-30"));
		/*
		//String startDate = null;
		String endDate = null;
		//String terms = "3";
		//DateFormat dtFormat = new SimpleDateFormat("yyyyMMddHHMMSS");
		Date dt = new Date();
	    DateFormat dtFormat = new SimpleDateFormat("yyyyMMdd");
	  //  Calendar cal = Calendar.getInstance();
	    //System.out.println("curCal.DAY_OF_WEEK: " + cal.DAY_OF_WEEK);
	   //System.out.println("cal.getFirstDayOfWeek(): "  + cal.getFirstDayOfWeek());
	   //System.out.println(cal.add(field, amount)

	   	String startDate = dtFormat.format(Calendar.getInstance().getTime());
	   //	 System.out.println("cal.getTime(): "+ cal.getTime());
	 //  	System.out.println("startDate: "+startDate);
//	   	cal.add(cal.MONTH, -(Integer.parseInt(terms)));
//	   	cal.add(cal.DAY_OF_WEEK, -(cal.get(Calendar.DAY_OF_MONTH)-1));
//	   	startDate = dtFormat.format(cal.getTime());
//	   	System.out.println("startDate: "+startDate);
	   	System.out.println(dtFormat.format(dt));



	   	Calendar curCal = Calendar.getInstance();
	  //	curCal.add(curCal.DAY_OF_WEEK,-(curCal.get(Calendar.DAY_OF_MONTH)));
	   	curCal.add(curCal.DAY_OF_WEEK, -(curCal.get(Calendar.DAY_OF_MONTH)) +1);

	   	// nextMonth = curCal.add(curCal.MONTH, 1);
	    String firstDate = dtFormat.format(curCal.getTime());
	    	System.out.println("firstDate: "+ firstDate);
	//    curCal.add(curCal.getActualMaximum(field), 1);
	   //  endDate = dtFormat.format(curCal.getTime());
    	System.out.println("endDate: "+ curCal.getActualMaximum ( Calendar.DATE ));
    	System.out.println("endDate: "+ curCal.getActualMinimum ( Calendar.DATE ));
    	int year = curCal.get(curCal.YEAR);
    	System.out.println("year: " + year);

    	int month = curCal.get(curCal.MONTH);
    	System.out.println("month: " + month);

    	int last_date = curCal.getActualMaximum ( Calendar.DATE );
    	int first_date = curCal.getActualMinimum ( Calendar.DATE );
    //	Date date = new Date(year, month, day)
    	Calendar cal1 = new GregorianCalendar(year, month, first_date);
    	String fDate = dtFormat.format(cal1.getTime());

	    	System.out.println("firstDate: "+ fDate);
	    	Calendar cal2 = new GregorianCalendar(year, month, last_date);
	    	String lDate = dtFormat.format(cal2.getTime());
	    	System.out.println("lastDate: " + lDate);
    	*/
	//	System.out.println("getFirstDayOfMonth: " + getFirstDayOfMonth("20091201", "yyyy-MM-dd"));
	//	System.out.println("getLastDayOfMonth: " + getLastDayOfMonth("2009-12-03", "yyyy-MM-dd"));



	//	System.out.println("getFirstDayOfCurrentMonth: " + getFirstDayOfCurrentMonth( "yyyy-MM-dd"));
	//	System.out.println("getLastDayOfCurrentMonth: " + getLastDayOfCurrentMonth( "yyyy-MM-dd"));
	//	Date date = new Date();
	//	System.out.println("getAfterMonth: " + getAfterMonth(new Date(), 1));
		//String str = "adf\"'";



		//System.out.println(str.replaceAll("\"", "'"));


		//유효시작일 구하기
//		Date vaildStartDate = addDay(getDate("2016-11-30", DateUtil.yyyyMMdd_DASH), 5);
//		System.out.println("유효시작일: " + vaildStartDate);
//
//
//		//특정월수를 더한 달의 마지막 날짜 구하기.(소멸예정일 구하기)
//		Date lastDate = getMonthLastDate( vaildStartDate, 12);
//		System.out.println("소명예정일: " + lastDate);


	//	String test_date = "20170120";
	//	System.out.println(getDate(test_date, DateUtil.yyyyMMdd));

	}




	/**
	 * 날짜 String을 Date로 변환해서 리턴한다. (DEFAULT_DATE_FORMAT을 사용)
	 * @author knlee
	 * @param date
     * @return 날짜 String을 Date로 변환해서 리턴한다. 변환도중 error발생시 null을 리턴한다.
     */
	public  final static Date getDate(String date) {
		return getDate(StringUtil.extNumber(date), "yyyyMMdd");
	}

	
	
}

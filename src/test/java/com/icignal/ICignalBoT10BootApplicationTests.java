package com.icignal;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class ICignalBoT10BootApplicationTests {

	@Test
	void contextLoads() {
	}

	public static void main(String[] args) {
		StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
		encryptor.setPassword("9pwc3dke");
//		System.out.println(encryptor.encrypt("com.mysql.cj.jdbc.MysqlDataSource"));
//		System.out.println(encryptor.encrypt("sfaadmin"));
//		System.out.println(encryptor.encrypt("P@ssw0rd1!"));
//		System.out.println(encryptor.encrypt("jdbc:log4jdbc:mysql://app-sfa.cilpkhhykq9i.ap-northeast-2.rds.amazonaws.com:3306/sfa"));

//		encryptor.decrypt("mkLHc+mOf1u2UsGy7cwzrXais9BV3ZUklDwffKJevg9Py08Ww7+q9MxfZZq5uHq6KAy00j+oek75d5/YtO+AKvMTWz6Fa/sRnIyq1Rk5+v9e3zeyVOXa4+fCAnMYv94b");

		System.out.println("==========================");
		System.out.println("==========================");
		System.out.println("LOCAL");
		System.out.println(encryptor.encrypt("com.mysql.cj.jdbc.Driver"));
		System.out.println(encryptor.encrypt("root"));
		System.out.println(encryptor.encrypt("1234"));
		System.out.println(encryptor.encrypt("jdbc:log4jdbc:mysql://localhost:3306/com?serverTimezone=Asia/Seoul&useSSL=false"));
		System.out.println(encryptor.encrypt("com.mysql.cj.jdbc.Driver"));

//		System.out.println("==========================");
//		System.out.println("==========================");
//		System.out.println("APP");
//		System.out.println(encryptor.decrypt("h3Busy61d1eyysAkO7gMHp4jO2prlAL7cSiDjL7v0jGD0maMqK/Vvw=="));
//		System.out.println(encryptor.decrypt("vnWPiwSsZiI+hIjlu+J9H9otoaPsjuYIsOWAhNfv0tqn9IJIXJmR5HhWrGjX6+XJjxJyYkbfgiJOZvEFalXp+v55mnfSiJUNYl7aqgqwAvtScYc+PzY0FQoQ96V1aU3N"));
//		System.out.println(encryptor.decrypt("RT41PADiVqfZrTaxjxJse/md+NWSLfa6"));
//		System.out.println(encryptor.decrypt("qGkoJDYtlPC8CbN50ZvOGN5p19J7oq3x"));
//
//
//		System.out.println("==========================");
//		System.out.println("==========================");
//		System.out.println("SBOX");
//		System.out.println(encryptor.decrypt("DPYcTnoNRiLYuD9S0cwULy1B41f2BIFK/dBBhiAcH1aYi6NW7Lc5SpGMYBjPLbksFB5pdf5JFcJH0exx7XXB6BfH6LDyZeculT/Wvaq/O785YXVJFPM0HTZ8MT53itm7KsPHOg18bh8="));
//		System.out.println(encryptor.decrypt("RT41PADiVqfZrTaxjxJse/md+NWSLfa6"));
//		System.out.println(encryptor.decrypt("qGkoJDYtlPC8CbN50ZvOGN5p19J7oq3x"));
//
//
//		System.out.println("==========================");
//		System.out.println("==========================");
//		System.out.println("PROD");
//		System.out.println(encryptor.decrypt("fywh7rq24cxOmFK0p/JPnYNaiyHDSfuD1UEMvUOqCs9H8xktYMtQ+uI6s58lnvzwrdIH6hBwbqzeQ49EF8SSNOsv+QaIUqX/NeI4Jng2JDsTWiurHgtz3OARZdZgvK9J"));

	}

}

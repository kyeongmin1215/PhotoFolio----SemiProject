package kh.com.photofolio.utils;

import java.math.BigInteger;
import java.security.MessageDigest;

public class EncryptionUtils {

	public static String getSHA512(String pw) {
		MessageDigest md;
		try {
			md = MessageDigest.getInstance("SHA-512");
			md.reset();
			md.update(pw.getBytes("utf-8"));
			pw=String.format("%0128x", new BigInteger(1,md.digest()));
		}catch(Exception e) {
			e.printStackTrace();
		}
		return pw;
	}
}

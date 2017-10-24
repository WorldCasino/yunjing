package com.cicada.commons.utils;

import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;
import java.security.Key;

import com.cicada.pojo.Token;
import io.jsonwebtoken.*;

import java.util.Date;

/**
 * token帮助类（JWT标准）
 * {@link com.cicada.commons.utils.AesTokenUtil}
 *
 * Created by Administrator on 2017/5/17.
 */
@Deprecated
public class TokenUtil {
    private static final String issuer = "caiecai";
    private static final String keySecret = "abcd@369852147#wxyz";
    private static final int ttlMillis = 1000 * 3600 * 24 * 180;

    /**
     * 生成token
     * 需引用包 使用io.jsonwebtoken jjwt
     * @param userId
     * @return
     */
    public static String createJwtToken(String userId) {

        SignatureAlgorithm signatureAlgorithm = SignatureAlgorithm.HS256;

        long nowMillis = System.currentTimeMillis();
        Date now = new Date(nowMillis);

        byte[] apiKeySecretBytes = DatatypeConverter.parseBase64Binary(TokenUtil.keySecret);
        Key signingKey = new SecretKeySpec(apiKeySecretBytes, signatureAlgorithm.getJcaName());

        JwtBuilder builder = Jwts.builder().setId(userId)
                .setIssuedAt(now)
                .setSubject(userId)
                .setIssuer(userId)
                .signWith(signatureAlgorithm, signingKey);

        if (TokenUtil.ttlMillis >= 0) {
            long expMillis = nowMillis + TokenUtil.ttlMillis;
            Date exp = new Date(expMillis);
            builder.setExpiration(exp);
        }

        return builder.compact();
    }

    /**
     * 解密token
     * 需引用包 使用io.jsonwebtoken jjwt
     * @param tokenStr
     * @return
     */
    public static Token parseJwtToken(String tokenStr) {
        Claims claims = Jwts.parser()
                .setSigningKey(DatatypeConverter.parseBase64Binary(TokenUtil.keySecret))
                .parseClaimsJws(tokenStr).getBody();

        Token token = new Token();
        token.setUserId(Integer.parseInt(claims.getIssuer()));
        token.setExpireTime(claims.getExpiration());

        return token;

//        System.out.println("ID: " + claims.getId());
//        System.out.println("Subject: " + claims.getSubject());
//        System.out.println("Issuer: " + claims.getIssuer());
//        System.out.println("Expiration: " + claims.getExpiration());
    }


//    public static Token parseToken(String accessToken) throws ParseException{
//        JWT jwt = JWTParser.parse(accessToken);
//
//        JWTClaimsSet claims = jwt.getJWTClaimsSet();
//        Map<String, Object> customClaims = claims.getClaims();
//
//        Token token = new Token();
//        token.setUserId((int)customClaims.get("user"));
//        token.setExpireTime((long)customClaims.get("expire"));
//
//        return token;
//    }
//
//    public static String createAccessToken(Integer userId) throws JOSEException, NoSuchAlgorithmException {
//        KeyPairGenerator keyGenerator = KeyPairGenerator.getInstance("RSA");
//        keyGenerator.initialize(1024);
//
//        KeyPair kp = keyGenerator.genKeyPair();
//        RSAPublicKey publicKey = (RSAPublicKey)kp.getPublic();
//        RSAPrivateKey privateKey = (RSAPrivateKey)kp.getPrivate();
//
//        JWSSigner signer = new RSASSASigner(privateKey);
//
//        JWTClaimsSet claimsSet = new JWTClaimsSet.Builder()
//                .subject(userId.toString())
//                .issuer(userId.toString())
//                .expirationTime(new Date(new Date().getTime() + 60 * 1000 * 60 * 24))
//                .build();
//
//        SignedJWT signedJWT = new SignedJWT(
//                new JWSHeader(JWSAlgorithm.RS256),
//                claimsSet);
//
//        signedJWT.sign(signer);
//
//        return signedJWT.serialize();
//    }
//
//    public static void test(String userId) throws NoSuchAlgorithmException, JOSEException, ParseException {
//        KeyPairGenerator keyGenerator = KeyPairGenerator.getInstance("RSA");
//        keyGenerator.initialize(1024);
//
//        KeyPair kp = keyGenerator.genKeyPair();
//        RSAPublicKey publicKey = (RSAPublicKey)kp.getPublic();
//        RSAPrivateKey privateKey = (RSAPrivateKey)kp.getPrivate();
//
//        JWSSigner signer = new RSASSASigner(privateKey);
//
//        JWTClaimsSet claimsSet = new JWTClaimsSet.Builder()
//                .subject(userId)
//                .issuer(userId)
//                .expirationTime(new Date(new Date().getTime() + 60 * 1000))
//                .build();
//
//        SignedJWT signedJWT = new SignedJWT(
//                new JWSHeader(JWSAlgorithm.RS256),
//                claimsSet);
//
//        signedJWT.sign(signer);
//
//        String s = signedJWT.serialize();
//
//        s="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoicmZ0IiwiZXhwaXJlIjoxNTI2NTI5NTc0NzE4fQ.xIl9JPryUSIX7O2y_bPRr8QgLQDaiCrzr35osNFWpx4";
//        signedJWT = SignedJWT.parse(s);
//
//        JWSVerifier verifier = new RSASSAVerifier(publicKey);
//        boolean rtn = signedJWT.verify(verifier);
////        assertEquals("alice", signedJWT.getJWTClaimsSet().getSubject());
////        assertEquals("https://c2id.com", signedJWT.getJWTClaimsSet().getIssuer());
////        assertTrue(new Date().before(signedJWT.getJWTClaimsSet().getExpirationTime());
//
//    }
}

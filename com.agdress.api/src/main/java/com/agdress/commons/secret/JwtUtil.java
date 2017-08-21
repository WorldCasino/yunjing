package com.agdress.commons.secret;

import java.util.Date;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import com.agdress.commons.utils.ConstantInterface;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class JwtUtil {
    @Value("${config.auth.jwt.key}")
    private String JWT_KEY;
    @Value("${config.auth.jwt.issuer}")
    private String JWT_ISSUER;

    public String getJWT_KEY() {
        return JWT_KEY;
    }

    public String getJWT_ISSUER() {
        return JWT_ISSUER;
    }

    /**
     * 由字符串生成加密key
     * @return
     */
    public SecretKey    generalKey(){
        String stringKey = JWT_KEY + ConstantInterface.JWT_SECRET;
        byte[] encodedKey = Base64.decodeBase64(stringKey);
        SecretKey key = new SecretKeySpec(encodedKey, 0, encodedKey.length, "AES");
        return key;
    }

    /**
     * 创建jwt
     * @param userId 用户ID
     * @param bgUserId
     * @param bgLoginId
     * @param ttlMillis 过期时间
     * @return
     * @throws Exception
     */
    public String createJWT(long userId, long bgUserId, String bgLoginId, long ttlMillis) throws Exception {
        //The JWT signature algorithm we will be using to sign the token
        SignatureAlgorithm signatureAlgorithm = SignatureAlgorithm.HS256;

        long nowMillis = System.currentTimeMillis();
        Date now = new Date(nowMillis);

        //We will sign our JWT with our ApiKey secret
        SecretKey signingKey = generalKey();

        //Let's set the JWT Claims
        JwtBuilder builder = Jwts.builder().setId(String.valueOf(userId))
                .setIssuedAt(now)
                .setSubject(bgLoginId)
                .setIssuer(JWT_ISSUER)
                .setAudience(String.valueOf(bgUserId))
                .signWith(signatureAlgorithm, signingKey);

        //if it has been specified, let's add the expiration
        if (ttlMillis >= 0) {
            long expMillis = nowMillis + ttlMillis;
            Date exp = new Date(expMillis);
            builder.setExpiration(exp);
        }

        //Builds the JWT and serializes it to a compact, URL-safe string
        return builder.compact();
    }

    /**
     * 解密jwt
     * @param jwt
     * @return
     * @throws Exception
     */
    public Claims parseJWT(String jwt) throws Exception{
        SecretKey key = generalKey();
        Claims claims = Jwts.parser()
                .setSigningKey(key)
                .parseClaimsJws(jwt).getBody();

        return claims;
    }
}

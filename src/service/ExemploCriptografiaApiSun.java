package service;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.net.URLEncoder;
import java.util.Base64;

/**
 * Created by pkgoncalves on 10/4/16.
 */
public class ExemploCriptografiaApiSun {

    private static final String CHAVE_PRIVADA_PARCEIRO = "ilUQARocJEjIFcKa";

    public static void main(java.lang.String[] main) throws Exception {
    	String[] dds = {"21","22","24","27","28","11","12","13","14","15","17","18","19","16","31","32","35","37","38","33","34","68","82","92","97","96","71","73","74","75","77","85","88","61","61","62","64","98","99","67","65","66","91","93","94","83","81","87","86","89","41","42","43","44","45","46","84","69","95","51","53","54","55","47","48","49","79","63"};
    	for (String ddd  : dds) {
    		// Parâmetro sem criptografia.
            String parametroQueryString = ddd;

            // Chave de criptografia randômica. Calculada para cada requisição.
            String chavePrivadaRequisicao = calcularStringRandomica();

            // Parâmetro query string criptografado com a chave randômica gerada.
            String parametroCriptografado = ExemploCriptografiaApiSun.cipher(chavePrivadaRequisicao, parametroQueryString);

            // Chave randômica criptografada com a chave privada fornecida pela Before.
            String sunRequestKey = ExemploCriptografiaApiSun.cipher(CHAVE_PRIVADA_PARCEIRO, chavePrivadaRequisicao);

            System.out.println("DDD: "+parametroQueryString+" DDD criptogafado: "+parametroCriptografado+ " key: "+sunRequestKey);
        }
    }

    /**
     *
     * @param message
     * @return
     * @throws Exception
     */
    public static String cipher(String key, String message) throws Exception {
        Cipher cipher = Cipher.getInstance("Blowfish/ECB/PKCS5Padding");
        byte[] passDigest = key.getBytes("utf-8");
        SecretKey secretKey = new SecretKeySpec(passDigest, "Blowfish");
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);

        byte[] cipheredBytes = cipher.doFinal(message.getBytes("utf-8"));

        return Base64.getEncoder().encodeToString(cipheredBytes);
    }

    /**
     *
     * @return
     */
    private static String calcularStringRandomica() throws Exception {
        KeyGenerator keyGen = KeyGenerator.getInstance("Blowfish");
        keyGen.init(32);
        byte[] bytes = keyGen.generateKey().getEncoded();

        return Base64.getEncoder().encodeToString(bytes);
    }

    /**
     *
     * @return
     * @throws Exception
     */
    private static String montarUrl(String parametroCriptografado) throws Exception {
        return "https://sun-api-hmg.before.com.br/planos?ddd=" + URLEncoder.encode(parametroCriptografado, "utf-8");
    }
}


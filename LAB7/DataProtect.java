//Shivambu Dev Pandey 
//23BCS123
//03/10/2024
//L7 OOP

import java.util.ArrayList;
import java.math.BigInteger;
import java.util.Random;

public class DataProtect {
    private int n, limit, e, d;
    
    public void generateProtection(int p, int q) {
        n = p * q;
        limit = (p - 1) * (q - 1);
        e = getE(limit);
        d = getD(e, limit);
    }

    private int getE(int limit) {
        for (int i = 2; i < limit; i++) {
            if (gcd(i, limit) == 1) return i;
        }
        return 2;
    }

    private int getD(int e, int limit) {
        for (int i = 1; i < limit; i++) {
            if ((e * i) % limit == 1) return i;
        }
        return 1; 
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
    
    public ArrayList<Integer> protectData(ArrayList<Integer> data) {
        ArrayList<Integer> codedData = new ArrayList<>();
        for (int dataElement : data) {
            BigInteger dataBig = BigInteger.valueOf(dataElement);
            BigInteger codedElement = dataBig.pow(e).mod(BigInteger.valueOf(n));  
            codedData.add(codedElement.intValue());
        }
        return codedData;
    }
    
    public ArrayList<Integer> showData(ArrayList<Integer> protectedData) {
        ArrayList<Integer> decodedData = new ArrayList<>();
        for (int dataElement : protectedData) {
            BigInteger dataBig = BigInteger.valueOf(dataElement);
            BigInteger decodedElement = dataBig.pow(d).mod(BigInteger.valueOf(n));  
            decodedData.add(decodedElement.intValue());
        }
        return decodedData;
    }
}

class DataProtectTestDrive {
    private static Random rand = new Random();

    private static int getRandomPrime() {
        int[] primes = {11, 13, 17, 19, 23}; 
        return primes[rand.nextInt(primes.length)];
    }

    public static void main(String[] args) {
        DataProtect dp = new DataProtect();
        
        int p = getRandomPrime();
        int q = getRandomPrime();
        
        dp.generateProtection(p, q);

        ArrayList<Integer> data = new ArrayList<>();
        data.add(60); 
        data.add(61); 
        data.add(62); 

        ArrayList<Integer> encryptedData = dp.protectData(data);
        System.out.println("Encrypted Data: " + encryptedData);

        ArrayList<Integer> decryptedData = dp.showData(encryptedData);
        System.out.println("Decrypted Data: " + decryptedData);
    }
}

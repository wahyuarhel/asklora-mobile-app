package utils;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;

import java.util.concurrent.ThreadLocalRandom;

    /**
     * Reference: <a href="https://github.com/BinanGit/HKID/blob/master/src/test/java/org/test/methods/HKIDchecking_Methods.java">HKID Generator</a>
     */

public class HKIDGenerator {
    public String HKIDgenerated;

    /*
     * Generate random integer between specific range
     * @param {number}  min - Minimum value
     * @param {number}  max - Maximum value
     * @returns  {number}
     */
    public int getRandomInt(int min, int max) {
        return ThreadLocalRandom.current().nextInt(min, max + 1);
    }

    public String calculateCheckDigit (String charPart, String numPart) {
        // Maximum alphabet should be 2
        if (charPart.length() > 3 || numPart.length() != 6) {
            return "false";
        }

        // Calculate checksum for character part
        String strValidChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

        System.out.println("Checking..charPart = " + charPart + " & numPart = " + numPart);
        int checkSum = 0;
        if (charPart.length() == 2) {
            checkSum += 9 * (10 + strValidChars.indexOf(charPart.charAt(0)));
            checkSum += 8 * (10 + strValidChars.indexOf(charPart.charAt(1)));
        } else {
            checkSum += 9 * 36;
            checkSum += 8 * (10 + strValidChars.indexOf(charPart));
        }

        int checkSumNum = 0;
        // Calculate checksum for numeric part
        for (int i = 0, j = 7; i < numPart.length(); i++, j--) {
            checkSum += j * Integer.parseInt(String.valueOf(numPart.charAt(i)));
        }
        System.out.println("Char for numPart; check Sum in total = " + checkSum);

        // Verify the check digit
        int remaining = checkSum % 11;
        System.out.println("Remainder = " + remaining);
        String verify = (remaining == 0) ? "0" : ((11 - remaining == 10) ? "A" : Integer.toString(11 - remaining));
        System.out.println("Verify check digit; verify = " + verify);

        return verify;
    }


    public String getHKIDgenerated() {
        System.out.println("Generating HKID...");

        // Generate a random number between 1 - 10
        double hkidMode = getRandomInt(1, 10);

        // Generate A - Z from ASCII otpCode 65 - 90
        String randomAlphabet = Character.toString((char) getRandomInt(65, 90));
        if (hkidMode == 10) {
            randomAlphabet += Character.toString((char)getRandomInt(65, 90));
        }

        int [] randomDigit = new int[6];
        String randomNumber = null;
        // Generate 6 Number
        for (int i = 0; i < 6; i++) {
            randomDigit[i] = getRandomInt(0,9);
            randomNumber = StringUtils.join(ArrayUtils.toObject(randomDigit),"");
        }

        // Calculate check digit
        String checkdigit = calculateCheckDigit(randomAlphabet, randomNumber);

        HKIDgenerated = randomAlphabet + randomNumber + checkdigit;

        System.out.println("HKID generated = " + HKIDgenerated);
        return HKIDgenerated;
    }

    public void verifyHKID (String hkid) {
        String regEx = "^[A-Z]{1,2}[0-9]{6}[0-9A]$";
        String temp = hkid.replaceAll("[()]", "");
        System.out.println("The HKID = " + temp);
        System.out.println("Matches regEx? " + temp.matches(regEx));
        boolean result;

        if (!hkid.matches(regEx)){
            return;
        }

        int len = temp.length();
        System.out.println("Length is " + len);

        int sum = (len == 9)
                ? 9 * (temp.codePointAt(0) - 55) + 8 * (temp.codePointAt(1) - 55)
                : 8 * (temp.codePointAt(0) - 55) + 36 * 9;
        System.out.println("Sum of Alphabetic Char = " + sum);

        StringBuffer arrange = new StringBuffer(temp).reverse();
        String arrToString = arrange.substring(1,7);
        System.out.println("Rearrange to String = " + arrToString);

        String[] arrStringArray = arrToString.split("");
        int [] arrArray = new int[arrStringArray.length];

        for (int i = 0; i < arrStringArray.length; i++) {
            arrArray [i] = Integer.parseInt(arrStringArray[i]);
        }

        int[] arrMultiple = {2, 3, 4, 5, 6, 7};
        for (int i = 0; i < arrArray.length; i++) {
            sum += arrArray[i] * arrMultiple[i];}

        int lastCode = temp.codePointAt(len-1);

        if (lastCode == 65) {
            lastCode = temp.codePointAt(len-1) - 55;
        } else
            lastCode = temp.codePointAt(len-1) - 48;
        System.out.println("Last Code = " + lastCode);

        int mod = sum % 11;
        System.out.println("The Modulus = " + mod);

        int checkCode = 11 - mod;
        System.out.println("Checking otpCode = " + checkCode);

        result = mod == 0 && lastCode == 0 || mod == 10 && lastCode == 1 || checkCode > 1 && checkCode < 10 && lastCode == checkCode;
        System.out.println("Modulus = " + mod + " & Checking digit = " + temp.charAt(len-1));
        System.out.println("The HKID of " + hkid + " is " + result);
        if (!result) {
            if (mod == 0) {
                System.out.println("i.e. Verify otpCode should be 0");
            } else {
                if (checkCode == 10) {
                    System.out.println("i.e. Verify otpCode should be A");
                } else {
                    System.out.println("Verify otpCode should be " + checkCode);
                }
            }
        }
    }

}

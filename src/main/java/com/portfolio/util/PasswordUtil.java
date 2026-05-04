package com.portfolio.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility class for BCrypt password hashing and verification.
 * Cost factor 12 provides a good balance of security vs. performance.
 */
public class PasswordUtil {

    private static final int COST = 12;

    /** Hashes a plain-text password using BCrypt. */
    public static String hash(String plainText) {
        return BCrypt.hashpw(plainText, BCrypt.gensalt(COST));
    }

    /** Returns true if the plain-text password matches the stored hash. */
    public static boolean verify(String plainText, String hash) {
        return BCrypt.checkpw(plainText, hash);
    }

    private PasswordUtil() {
    } // prevent instantiation
}
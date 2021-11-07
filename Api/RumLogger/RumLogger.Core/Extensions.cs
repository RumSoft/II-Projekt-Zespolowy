﻿namespace RumLogger.Core
{
    public static class Extensions
    {
        public static bool IsNullOrWhiteSpace(this string value) => string.IsNullOrWhiteSpace(value);

        public static bool IsNullOrEmpty(this string value) => string.IsNullOrEmpty(value);

        public static bool IsNotCorrectId(this int value) => value <= 0;
    }
}

class ZodiacDataHandler {
  String targetZodiac;
  DateTime targetDate;

  void _getZodiacFromDate() {
    // Aquarius (January 20 - February 18)
    if (targetDate.isAfter(DateTime(targetDate.year, 1, 19)) &&
        targetDate.isBefore(DateTime(targetDate.year, 2, 19))) {
      targetZodiac = 'aquarius';
    }
    // Pisces (February 19 - March 20)
    else if (targetDate.isAfter(DateTime(targetDate.year, 2, 18)) &&
        targetDate.isBefore(DateTime(targetDate.year, 3, 21))) {
      targetZodiac = 'pisces';
    }
    // Aries (March 21 - April 19)
    else if (targetDate.isAfter(DateTime(targetDate.year, 3, 20)) &&
        targetDate.isBefore(DateTime(targetDate.year, 4, 20))) {
      targetZodiac = 'aries';
    }
    // Taurus (April 20 - May 20)
    else if (targetDate.isAfter(DateTime(targetDate.year, 4, 19)) &&
        targetDate.isBefore(DateTime(targetDate.year, 5, 21))) {
      targetZodiac = 'taurus';
    }
    // Gemini (May 21 - June 20)
    else if (targetDate.isAfter(DateTime(targetDate.year, 5, 20)) &&
        targetDate.isBefore(DateTime(targetDate.year, 6, 21))) {
      targetZodiac = 'gemini';
    }
    // Cancer (June 21 - July 22)
    else if (targetDate.isAfter(DateTime(targetDate.year, 6, 20)) &&
        targetDate.isBefore(DateTime(targetDate.year, 7, 23))) {
      targetZodiac = 'cancer';
    }
    // Leo (July 23 - August 22)
    else if (targetDate.isAfter(DateTime(targetDate.year, 7, 22)) &&
        targetDate.isBefore(DateTime(targetDate.year, 8, 23))) {
      targetZodiac = 'leo';
    }
    // Virgo (August 23 - September 22)
    else if (targetDate.isAfter(DateTime(targetDate.year, 8, 22)) &&
        targetDate.isBefore(DateTime(targetDate.year, 9, 23))) {
      targetZodiac = 'virgo';
    }
    // Libra (September 23 - October 22)
    else if (targetDate.isAfter(DateTime(targetDate.year, 9, 22)) &&
        targetDate.isBefore(DateTime(targetDate.year, 10, 23))) {
      targetZodiac = 'libra';
    }
    // Scorpio (October 23 - November 21)
    else if (targetDate.isAfter(DateTime(targetDate.year, 10, 22)) &&
        targetDate.isBefore(DateTime(targetDate.year, 11, 22))) {
      targetZodiac = 'scorpio';
    }
    // Sagittarius (November 22 - December 21)
    else if (targetDate.isAfter(DateTime(targetDate.year, 11, 21)) &&
        targetDate.isBefore(DateTime(targetDate.year, 12, 22))) {
      targetZodiac = 'sagittarius';
    }
    // Capricorn (December 22 - January 19)
    else {
      targetZodiac = 'capricorn';
    }
  }

  void get targetZodiacForAPi {
    return _getZodiacFromDate();
  }
}

ZodiacDataHandler zodiacData = new ZodiacDataHandler();

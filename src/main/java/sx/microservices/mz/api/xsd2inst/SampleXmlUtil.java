/*   Copyright 2004 The Apache Software Foundation
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *  limitations under the License.
 */

package sx.microservices.mz.api.xsd2inst;

/*
 * TODO:
 *  Comment on enumerations?
 *  Comment on facets?
 *  Have a verbose option?
 *  Have a sample data option, would create valid instance with sample data?
 *  Add the pattern facet; this is tricky, considering the relationship with length
 */

import org.apache.xmlbeans.*;
import org.apache.xmlbeans.soap.SOAPArrayType;
import org.apache.xmlbeans.soap.SchemaWSDLArrayType;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.namespace.QName;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.*;

public class SampleXmlUtil {
    private final boolean _soapEnc;
    private static final int MAX_ELEMENTS = 1000;
    private int _nElements;
    private final Map<String, TypeInfo> types = new HashMap<>();

    private SampleXmlUtil(boolean soapEnc) {
        _soapEnc = soapEnc;
    }

    public static XmlInstance createSampleForType(SchemaType sType) {
        XmlObject object = XmlObject.Factory.newInstance();
        XmlCursor cursor = object.newCursor();
        // Skip the document node
        cursor.toNextToken();
        // Using the type and the cursor, call the utility method to get a
        // sample XML payload for that Schema element
        Map<String, TypeInfo> types = new SampleXmlUtil(false).createSampleForType(sType, cursor);
        // Cursor now contains the sample payload
        // Pretty print the result.  Note that the cursor is positioned at the
        // end of the doc so we use the original xml object that the cursor was
        // created upon to do the xmlText() against.
        XmlOptions options = new XmlOptions();
        options.setSavePrettyPrint();
        options.setSavePrettyPrintIndent(2);
        options.setSaveAggressiveNamespaces();

        XmlInstance instance = new XmlInstance();
        instance.setXml(object.xmlText(options));
        instance.setTypes(types);
        return instance;
    }

    Random _picker = new Random(1);

    /**
     * Cursor position
     * Before:
     * <theElement>^</theElement>
     * After:
     * <theElement><lots of stuff/>^</theElement>
     */
    private Map<String, TypeInfo> createSampleForType(SchemaType stype, XmlCursor xmlc) {
        if (_typeStack.contains(stype)) {
            return this.types;
        }

        _typeStack.add(stype);

        try {
            if (stype.isSimpleType() || stype.isURType()) {
                processSimpleType(stype, xmlc);
                return this.types;
            }

            // complex Type
            // <theElement>^</theElement>
            processAttributes(stype, xmlc);

            // <theElement attri1="string">^</theElement>
            switch (stype.getContentType()) {
                case SchemaType.NOT_COMPLEX_TYPE:
                case SchemaType.EMPTY_CONTENT:
                    // noop
                    break;
                case SchemaType.SIMPLE_CONTENT: {
                    processSimpleType(stype, xmlc);
                }
                break;
                case SchemaType.MIXED_CONTENT:
                    xmlc.insertChars(pick(WORDS) + " ");
                    if (stype.getContentModel() != null) {
                        processParticle(stype.getContentModel(), xmlc, true);
                    }
                    xmlc.insertChars(pick(WORDS));
                    break;
                case SchemaType.ELEMENT_CONTENT:
                    if (stype.getContentModel() != null) {
                        processParticle(stype.getContentModel(), xmlc, false);
                    }
                    break;
            }
        } finally {
            _typeStack.remove(_typeStack.size() - 1);
        }
        return this.types;
    }

    private void processSimpleType(SchemaType stype, XmlCursor xmlc) {
        String sample = sampleDataForSimpleType(stype);
        xmlc.insertChars(sample);
    }

    private String sampleDataForSimpleType(SchemaType sType) {
        return UUID.randomUUID().toString();
    }

    // a bit from the Aenid
    private static final String[] WORDS = {
            "ipsa", "iovis", "rapidum", "iaculata", "e", "nubibus", "ignem",
            "disiecitque", "rates", "evertitque", "aequora", "ventis",
            "illum", "exspirantem", "transfixo", "pectore", "flammas",
            "turbine", "corripuit", "scopuloque", "infixit", "acuto",
            "ast", "ego", "quae", "divum", "incedo", "regina", "iovisque",
            "et", "soror", "et", "coniunx", "una", "cum", "gente", "tot", "annos",
            "bella", "gero", "et", "quisquam", "numen", "iunonis", "adorat",
            "praeterea", "aut", "supplex", "aris", "imponet", "honorem",
            "talia", "flammato", "secum", "dea", "corde", "volutans",
            "nimborum", "in", "patriam", "loca", "feta", "furentibus", "austris",
            "aeoliam", "venit", "hic", "vasto", "rex", "aeolus", "antro",
            "luctantis", "ventos", "tempestatesque", "sonoras",
            "imperio", "premit", "ac", "vinclis", "et", "carcere", "frenat",
            "illi", "indignantes", "magno", "cum", "murmure", "montis",
            "circum", "claustra", "fremunt", "celsa", "sedet", "aeolus", "arce",
            "sceptra", "tenens", "mollitque", "animos", "et", "temperat", "iras",
            "ni", "faciat", "maria", "ac", "terras", "caelumque", "profundum",
            "quippe", "ferant", "rapidi", "secum", "verrantque", "per", "auras",
            "sed", "pater", "omnipotens", "speluncis", "abdidit", "atris",
            "hoc", "metuens", "molemque", "et", "montis", "insuper", "altos",
            "imposuit", "regemque", "dedit", "qui", "foedere", "certo",
            "et", "premere", "et", "laxas", "sciret", "dare", "iussus", "habenas",
        };


    private static final String[] DNS1 = new String[]{"corp", "your", "my", "sample", "company", "test", "any"};
    private static final String[] DNS2 = new String[]{"com", "org", "com", "gov", "org", "com", "org", "com", "edu"};

    private int pick(int n) {
        return _picker.nextInt(n);
    }

    private String pick(String[] a) {
        return a[pick(a.length)];
    }

    private int pickLength(SchemaType sType) {
        XmlInteger length = (XmlInteger) sType.getFacet(SchemaType.FACET_LENGTH);
        if (length != null) {
            return length.getBigIntegerValue().intValue();
        }
        XmlInteger min = (XmlInteger) sType.getFacet(SchemaType.FACET_MIN_LENGTH);
        XmlInteger max = (XmlInteger) sType.getFacet(SchemaType.FACET_MAX_LENGTH);
        int minInt, maxInt;
        if (min == null) {
            minInt = 0;
        } else {
            minInt = min.getBigIntegerValue().intValue();
        }
        if (max == null) {
            maxInt = Integer.MAX_VALUE;
        } else {
            maxInt = max.getBigIntegerValue().intValue();
        }
        // We try to keep the length of the array within reasonable limits,
        // at least 1 item and at most 3 if possible
        if (minInt == 0 && maxInt >= 1) {
            minInt = 1;
        }
        if (maxInt > minInt + 2) {
            maxInt = minInt + 2;
        }
        if (maxInt < minInt) {
            maxInt = minInt;
        }
        return minInt + pick(maxInt - minInt);
    }

    /**
     * Formats a given string to the required length, using the following operations:
     * - append the source string to itself as necessary to pass the minLength;
     * - truncate the result of previous step, if necessary, to keep it within minLength.
     */
    private String formatToLength(String s, SchemaType sType) {
        String result = s;
        try {
            SimpleValue min = (SimpleValue) sType.getFacet(SchemaType.FACET_LENGTH);
            if (min == null) {
                min = (SimpleValue) sType.getFacet(SchemaType.FACET_MIN_LENGTH);
            }
            if (min != null) {
                int len = min.getIntValue();
                while (result.length() < len) {
                    result = result + result;
                }
            }
            SimpleValue max = (SimpleValue) sType.getFacet(SchemaType.FACET_LENGTH);
            if (max == null) {
                max = (SimpleValue) sType.getFacet(SchemaType.FACET_MAX_LENGTH);
            }
            if (max != null) {
                int len = max.getIntValue();
                if (result.length() > len) {
                    result = result.substring(0, len);
                }
            }
        } catch (Exception ignored) {
            // intValue can be out of range
        }
        return result;
    }

    private String formatDecimal(String start, SchemaType sType) {
        BigDecimal result = new BigDecimal(start);
        XmlDecimal xmlD;
        xmlD = (XmlDecimal) sType.getFacet(SchemaType.FACET_MIN_INCLUSIVE);
        BigDecimal min = xmlD != null ? xmlD.getBigDecimalValue() : null;
        xmlD = (XmlDecimal) sType.getFacet(SchemaType.FACET_MAX_INCLUSIVE);
        BigDecimal max = xmlD != null ? xmlD.getBigDecimalValue() : null;
        boolean minInclusive = true, maxInclusive = true;
        xmlD = (XmlDecimal) sType.getFacet(SchemaType.FACET_MIN_EXCLUSIVE);
        if (xmlD != null) {
            BigDecimal minExcl = xmlD.getBigDecimalValue();
            if (min == null || min.compareTo(minExcl) < 0) {
                min = minExcl;
                minInclusive = false;
            }
        }
        xmlD = (XmlDecimal) sType.getFacet(SchemaType.FACET_MAX_EXCLUSIVE);
        if (xmlD != null) {
            BigDecimal maxExcl = xmlD.getBigDecimalValue();
            if (max == null || max.compareTo(maxExcl) > 0) {
                max = maxExcl;
                maxInclusive = false;
            }
        }
        xmlD = (XmlDecimal) sType.getFacet(SchemaType.FACET_TOTAL_DIGITS);
        int totalDigits = -1;
        if (xmlD != null) {
            totalDigits = xmlD.getBigDecimalValue().intValue();

            StringBuilder sb = new StringBuilder(totalDigits);
            for (int i = 0; i < totalDigits; i++) {
                sb.append('9');
            }
            BigDecimal digitsLimit = new BigDecimal(sb.toString());
            if (max != null && max.compareTo(digitsLimit) > 0) {
                max = digitsLimit;
                maxInclusive = true;
            }
            digitsLimit = digitsLimit.negate();
            if (min != null && min.compareTo(digitsLimit) < 0) {
                min = digitsLimit;
                minInclusive = true;
            }
        }

        int sigMin = min == null ? 1 : result.compareTo(min);
        int sigMax = max == null ? -1 : result.compareTo(max);
        boolean minOk = sigMin > 0 || sigMin == 0 && minInclusive;
        boolean maxOk = sigMax < 0 || sigMax == 0 && maxInclusive;

        // Compute the minimum increment
        xmlD = (XmlDecimal) sType.getFacet(SchemaType.FACET_FRACTION_DIGITS);
        int fractionDigits = -1;
        BigDecimal increment;
        if (xmlD == null) {
            increment = new BigDecimal(1);
        } else {
            fractionDigits = xmlD.getBigDecimalValue().intValue();
            if (fractionDigits > 0) {
                StringBuilder sb = new StringBuilder("0.");
                for (int i = 1; i < fractionDigits; i++) {
                    sb.append('0');
                }
                sb.append('1');
                increment = new BigDecimal(sb.toString());
            } else {
                increment = BigDecimal.ONE;
            }
        }

        //noinspection StatementWithEmptyBody
        if (minOk && maxOk) {
            // OK
        } else if (minOk && !maxOk) {
            // TOO BIG
            if (maxInclusive) {
                result = max;
            } else {
                result = max.subtract(increment);
            }
        } else if (!minOk && maxOk) {
            // TOO SMALL
            if (minInclusive) {
                result = min;
            } else {
                result = min.add(increment);
            }
        } else {
            // MIN > MAX!!
        }

        // We have the number
        // Adjust the scale according to the totalDigits and fractionDigits
        int digits = 0;
        BigDecimal ONE = new BigDecimal(BigInteger.ONE);
        for (BigDecimal n = result; n.abs().compareTo(ONE) >= 0; digits++) {
            n = n.movePointLeft(1);
        }

        if (fractionDigits > 0) {
            if (totalDigits >= 0) {
                result = result.setScale(Math.max(fractionDigits, totalDigits - digits));
            } else {
                result = result.setScale(fractionDigits);
            }
        } else if (fractionDigits == 0) {
            result = result.setScale(0);
        }

        return result.toString();
    }

    private String formatDuration(SchemaType sType) {
        XmlDuration d =
            (XmlDuration) sType.getFacet(SchemaType.FACET_MIN_INCLUSIVE);
        GDuration minInclusive = null;
        if (d != null) {
            minInclusive = d.getGDurationValue();
        }

        d = (XmlDuration) sType.getFacet(SchemaType.FACET_MAX_INCLUSIVE);
        GDuration maxInclusive = null;
        if (d != null) {
            maxInclusive = d.getGDurationValue();
        }

        d = (XmlDuration) sType.getFacet(SchemaType.FACET_MIN_EXCLUSIVE);
        GDuration minExclusive = null;
        if (d != null) {
            minExclusive = d.getGDurationValue();
        }

        d = (XmlDuration) sType.getFacet(SchemaType.FACET_MAX_EXCLUSIVE);
        GDuration maxExclusive = null;
        if (d != null) {
            maxExclusive = d.getGDurationValue();
        }

        GDurationBuilder gdurb = new GDurationBuilder();

        gdurb.setSecond(pick(800000));
        gdurb.setMonth(pick(20));

        // Years
        // Months
        // Days
        // Hours
        // Minutes
        // Seconds
        // Fractions
        if (minInclusive != null) {
            if (gdurb.getYear() < minInclusive.getYear()) {
                gdurb.setYear(minInclusive.getYear());
            }
            if (gdurb.getMonth() < minInclusive.getMonth()) {
                gdurb.setMonth(minInclusive.getMonth());
            }
            if (gdurb.getDay() < minInclusive.getDay()) {
                gdurb.setDay(minInclusive.getDay());
            }
            if (gdurb.getHour() < minInclusive.getHour()) {
                gdurb.setHour(minInclusive.getHour());
            }
            if (gdurb.getMinute() < minInclusive.getMinute()) {
                gdurb.setMinute(minInclusive.getMinute());
            }
            if (gdurb.getSecond() < minInclusive.getSecond()) {
                gdurb.setSecond(minInclusive.getSecond());
            }
            if (gdurb.getFraction().compareTo(minInclusive.getFraction()) < 0) {
                gdurb.setFraction(minInclusive.getFraction());
            }
        }

        if (maxInclusive != null) {
            if (gdurb.getYear() > maxInclusive.getYear()) {
                gdurb.setYear(maxInclusive.getYear());
            }
            if (gdurb.getMonth() > maxInclusive.getMonth()) {
                gdurb.setMonth(maxInclusive.getMonth());
            }
            if (gdurb.getDay() > maxInclusive.getDay()) {
                gdurb.setDay(maxInclusive.getDay());
            }
            if (gdurb.getHour() > maxInclusive.getHour()) {
                gdurb.setHour(maxInclusive.getHour());
            }
            if (gdurb.getMinute() > maxInclusive.getMinute()) {
                gdurb.setMinute(maxInclusive.getMinute());
            }
            if (gdurb.getSecond() > maxInclusive.getSecond()) {
                gdurb.setSecond(maxInclusive.getSecond());
            }
            if (gdurb.getFraction().compareTo(maxInclusive.getFraction()) > 0) {
                gdurb.setFraction(maxInclusive.getFraction());
            }
        }

        if (minExclusive != null) {
            if (gdurb.getYear() <= minExclusive.getYear()) {
                gdurb.setYear(minExclusive.getYear() + 1);
            }
            if (gdurb.getMonth() <= minExclusive.getMonth()) {
                gdurb.setMonth(minExclusive.getMonth() + 1);
            }
            if (gdurb.getDay() <= minExclusive.getDay()) {
                gdurb.setDay(minExclusive.getDay() + 1);
            }
            if (gdurb.getHour() <= minExclusive.getHour()) {
                gdurb.setHour(minExclusive.getHour() + 1);
            }
            if (gdurb.getMinute() <= minExclusive.getMinute()) {
                gdurb.setMinute(minExclusive.getMinute() + 1);
            }
            if (gdurb.getSecond() <= minExclusive.getSecond()) {
                gdurb.setSecond(minExclusive.getSecond() + 1);
            }
            if (gdurb.getFraction().compareTo(minExclusive.getFraction()) <= 0) {
                gdurb.setFraction(minExclusive.getFraction().add(new BigDecimal("0.001")));
            }
        }

        if (maxExclusive != null) {
            if (gdurb.getYear() > maxExclusive.getYear()) {
                gdurb.setYear(maxExclusive.getYear());
            }
            if (gdurb.getMonth() > maxExclusive.getMonth()) {
                gdurb.setMonth(maxExclusive.getMonth());
            }
            if (gdurb.getDay() > maxExclusive.getDay()) {
                gdurb.setDay(maxExclusive.getDay());
            }
            if (gdurb.getHour() > maxExclusive.getHour()) {
                gdurb.setHour(maxExclusive.getHour());
            }
            if (gdurb.getMinute() > maxExclusive.getMinute()) {
                gdurb.setMinute(maxExclusive.getMinute());
            }
            if (gdurb.getSecond() > maxExclusive.getSecond()) {
                gdurb.setSecond(maxExclusive.getSecond());
            }
            if (gdurb.getFraction().compareTo(maxExclusive.getFraction()) > 0) {
                gdurb.setFraction(maxExclusive.getFraction());
            }
        }

        gdurb.normalize();
        return gdurb.toString();
    }

    private String formatDate(SchemaType sType) {
        GDateBuilder gdateb = new GDateBuilder(new Date(1000L * pick(365 * 24 * 60 * 60) + (30L + pick(20)) * 365 * 24 * 60 * 60 * 1000));
        GDate min = null, max = null;

        // Find the min and the max according to the type
        switch (sType.getPrimitiveType().getBuiltinTypeCode()) {
            case SchemaType.BTC_DATE_TIME: {
                XmlDateTime x = (XmlDateTime) sType.getFacet(SchemaType.FACET_MIN_INCLUSIVE);
                if (x != null) {
                    min = x.getGDateValue();
                }
                x = (XmlDateTime) sType.getFacet(SchemaType.FACET_MIN_EXCLUSIVE);
                if (x != null) {
                    if (min == null || min.compareToGDate(x.getGDateValue()) <= 0) {
                        min = x.getGDateValue();
                    }
                }

                x = (XmlDateTime) sType.getFacet(SchemaType.FACET_MAX_INCLUSIVE);
                if (x != null) {
                    max = x.getGDateValue();
                }
                x = (XmlDateTime) sType.getFacet(SchemaType.FACET_MAX_EXCLUSIVE);
                if (x != null) {
                    if (max == null || max.compareToGDate(x.getGDateValue()) >= 0) {
                        max = x.getGDateValue();
                    }
                }
                break;
            }
            case SchemaType.BTC_TIME: {
                XmlTime x = (XmlTime) sType.getFacet(SchemaType.FACET_MIN_INCLUSIVE);
                if (x != null) {
                    min = x.getGDateValue();
                }
                x = (XmlTime) sType.getFacet(SchemaType.FACET_MIN_EXCLUSIVE);
                if (x != null) {
                    if (min == null || min.compareToGDate(x.getGDateValue()) <= 0) {
                        min = x.getGDateValue();
                    }
                }

                x = (XmlTime) sType.getFacet(SchemaType.FACET_MAX_INCLUSIVE);
                if (x != null) {
                    max = x.getGDateValue();
                }
                x = (XmlTime) sType.getFacet(SchemaType.FACET_MAX_EXCLUSIVE);
                if (x != null) {
                    if (max == null || max.compareToGDate(x.getGDateValue()) >= 0) {
                        max = x.getGDateValue();
                    }
                }
                break;
            }
            case SchemaType.BTC_DATE: {
                XmlDate x = (XmlDate) sType.getFacet(SchemaType.FACET_MIN_INCLUSIVE);
                if (x != null) {
                    min = x.getGDateValue();
                }
                x = (XmlDate) sType.getFacet(SchemaType.FACET_MIN_EXCLUSIVE);
                if (x != null) {
                    if (min == null || min.compareToGDate(x.getGDateValue()) <= 0) {
                        min = x.getGDateValue();
                    }
                }

                x = (XmlDate) sType.getFacet(SchemaType.FACET_MAX_INCLUSIVE);
                if (x != null) {
                    max = x.getGDateValue();
                }
                x = (XmlDate) sType.getFacet(SchemaType.FACET_MAX_EXCLUSIVE);
                if (x != null) {
                    if (max == null || max.compareToGDate(x.getGDateValue()) >= 0) {
                        max = x.getGDateValue();
                    }
                }
                break;
            }
            case SchemaType.BTC_G_YEAR_MONTH: {
                XmlGYearMonth x = (XmlGYearMonth) sType.getFacet(SchemaType.FACET_MIN_INCLUSIVE);
                if (x != null) {
                    min = x.getGDateValue();
                }
                x = (XmlGYearMonth) sType.getFacet(SchemaType.FACET_MIN_EXCLUSIVE);
                if (x != null) {
                    if (min == null || min.compareToGDate(x.getGDateValue()) <= 0) {
                        min = x.getGDateValue();
                    }
                }

                x = (XmlGYearMonth) sType.getFacet(SchemaType.FACET_MAX_INCLUSIVE);
                if (x != null) {
                    max = x.getGDateValue();
                }
                x = (XmlGYearMonth) sType.getFacet(SchemaType.FACET_MAX_EXCLUSIVE);
                if (x != null) {
                    if (max == null || max.compareToGDate(x.getGDateValue()) >= 0) {
                        max = x.getGDateValue();
                    }
                }
                break;
            }
            case SchemaType.BTC_G_YEAR: {
                XmlGYear x = (XmlGYear) sType.getFacet(SchemaType.FACET_MIN_INCLUSIVE);
                if (x != null) {
                    min = x.getGDateValue();
                }
                x = (XmlGYear) sType.getFacet(SchemaType.FACET_MIN_EXCLUSIVE);
                if (x != null) {
                    if (min == null || min.compareToGDate(x.getGDateValue()) <= 0) {
                        min = x.getGDateValue();
                    }
                }

                x = (XmlGYear) sType.getFacet(SchemaType.FACET_MAX_INCLUSIVE);
                if (x != null) {
                    max = x.getGDateValue();
                }
                x = (XmlGYear) sType.getFacet(SchemaType.FACET_MAX_EXCLUSIVE);
                if (x != null) {
                    if (max == null || max.compareToGDate(x.getGDateValue()) >= 0) {
                        max = x.getGDateValue();
                    }
                }
                break;
            }
            case SchemaType.BTC_G_MONTH_DAY: {
                XmlGMonthDay x = (XmlGMonthDay) sType.getFacet(SchemaType.FACET_MIN_INCLUSIVE);
                if (x != null) {
                    min = x.getGDateValue();
                }
                x = (XmlGMonthDay) sType.getFacet(SchemaType.FACET_MIN_EXCLUSIVE);
                if (x != null) {
                    if (min == null || min.compareToGDate(x.getGDateValue()) <= 0) {
                        min = x.getGDateValue();
                    }
                }

                x = (XmlGMonthDay) sType.getFacet(SchemaType.FACET_MAX_INCLUSIVE);
                if (x != null) {
                    max = x.getGDateValue();
                }
                x = (XmlGMonthDay) sType.getFacet(SchemaType.FACET_MAX_EXCLUSIVE);
                if (x != null) {
                    if (max == null || max.compareToGDate(x.getGDateValue()) >= 0) {
                        max = x.getGDateValue();
                    }
                }
                break;
            }
            case SchemaType.BTC_G_DAY: {
                XmlGDay x = (XmlGDay) sType.getFacet(SchemaType.FACET_MIN_INCLUSIVE);
                if (x != null) {
                    min = x.getGDateValue();
                }
                x = (XmlGDay) sType.getFacet(SchemaType.FACET_MIN_EXCLUSIVE);
                if (x != null) {
                    if (min == null || min.compareToGDate(x.getGDateValue()) <= 0) {
                        min = x.getGDateValue();
                    }
                }

                x = (XmlGDay) sType.getFacet(SchemaType.FACET_MAX_INCLUSIVE);
                if (x != null) {
                    max = x.getGDateValue();
                }
                x = (XmlGDay) sType.getFacet(SchemaType.FACET_MAX_EXCLUSIVE);
                if (x != null) {
                    if (max == null || max.compareToGDate(x.getGDateValue()) >= 0) {
                        max = x.getGDateValue();
                    }
                }
                break;
            }
            case SchemaType.BTC_G_MONTH: {
                XmlGMonth x = (XmlGMonth) sType.getFacet(SchemaType.FACET_MIN_INCLUSIVE);
                if (x != null) {
                    min = x.getGDateValue();
                }
                x = (XmlGMonth) sType.getFacet(SchemaType.FACET_MIN_EXCLUSIVE);
                if (x != null) {
                    if (min == null || min.compareToGDate(x.getGDateValue()) <= 0) {
                        min = x.getGDateValue();
                    }
                }

                x = (XmlGMonth) sType.getFacet(SchemaType.FACET_MAX_INCLUSIVE);
                if (x != null) {
                    max = x.getGDateValue();
                }
                x = (XmlGMonth) sType.getFacet(SchemaType.FACET_MAX_EXCLUSIVE);
                if (x != null) {
                    if (max == null || max.compareToGDate(x.getGDateValue()) >= 0) {
                        max = x.getGDateValue();
                    }
                }
                break;
            }
        }

        if (min != null && max == null) {
            if (min.compareToGDate(gdateb) >= 0) {
                // Reset the date to min + (1-8) hours
                Calendar c = gdateb.getCalendar();
                c.add(Calendar.HOUR_OF_DAY, pick(8));
                gdateb = new GDateBuilder(c);
            }
        } else if (min == null && max != null) {
            if (max.compareToGDate(gdateb) <= 0) {
                // Reset the date to max - (1-8) hours
                Calendar c = gdateb.getCalendar();
                c.add(Calendar.HOUR_OF_DAY, -pick(8));
                gdateb = new GDateBuilder(c);
            }
        } else if (min != null && max != null) {
            if (min.compareToGDate(gdateb) >= 0 || max.compareToGDate(gdateb) <= 0) {
                // Find a date between the two
                Calendar c = min.getCalendar();
                Calendar cmax = max.getCalendar();
                c.add(Calendar.HOUR_OF_DAY, 1);
                if (c.after(cmax)) {
                    c.add(Calendar.HOUR_OF_DAY, -1);
                    c.add(Calendar.MINUTE, 1);
                    if (c.after(cmax)) {
                        c.add(Calendar.MINUTE, -1);
                        c.add(Calendar.SECOND, 1);
                        if (c.after(cmax)) {
                            c.add(Calendar.SECOND, -1);
                            c.add(Calendar.MILLISECOND, 1);
                            if (c.after(cmax)) {
                                c.add(Calendar.MILLISECOND, -1);
                            }
                        }
                    }
                }
                gdateb = new GDateBuilder(c);
            }
        }

        gdateb.setBuiltinTypeCode(sType.getPrimitiveType().getBuiltinTypeCode());
        if (pick(2) == 0) {
            gdateb.clearTimeZone();
        }
        return gdateb.toString();
    }

    private SchemaType closestBuiltin(SchemaType sType) {
        while (!sType.isBuiltinType()) {
            sType = sType.getBaseType();
        }
        return sType;
    }

    /**
     * Cracks a combined QName of the form URL:localname
     */
    public static QName crackQName(String qName) {
        String ns;
        String name;

        int index = qName.lastIndexOf(':');
        if (index >= 0) {
            ns = qName.substring(0, index);
            name = qName.substring(index + 1);
        } else {
            ns = "";
            name = qName;
        }

        return new QName(ns, name);
    }


    /**
     * Cursor position:
     * Before this call:
     * <outer><foo/>^</outer>  (cursor at the ^)
     * After this call:
     * <<outer><foo/><bar/>som text<etc/>^</outer>
     */
    private void processParticle(SchemaParticle sp, XmlCursor xmlc, boolean mixed) {
        int loop = determineMinMaxForSample(sp, xmlc);

        while (loop-- > 0) {
            switch (sp.getParticleType()) {
                case (SchemaParticle.ELEMENT):
                    processElement(sp, xmlc, mixed);
                    break;
                case (SchemaParticle.SEQUENCE):
                    processSequence(sp, xmlc, mixed);
                    break;
                case (SchemaParticle.CHOICE):
                    processChoice(sp, xmlc, mixed);
                    break;
                case (SchemaParticle.ALL):
                    processAll(sp, xmlc, mixed);
                    break;
                case (SchemaParticle.WILDCARD):
                    processWildCard(sp, xmlc, mixed);
                    break;
                default:
                    // throw new Exception("No Match on Schema Particle Type: " + String.valueOf(sp.getParticleType()));
            }
        }
    }

    private int determineMinMaxForSample(SchemaParticle sp, XmlCursor xmlc) {
        int minOccurs = sp.getIntMinOccurs();
        int maxOccurs = sp.getIntMaxOccurs();

        if (minOccurs == maxOccurs) {
            return minOccurs;
        }

        int result = minOccurs;
        if (result == 0 && _nElements < MAX_ELEMENTS) {
            result = 1;
        }

        if (sp.getParticleType() != SchemaParticle.ELEMENT) {
            return result;
        }

        // it probably only makes sense to put comments in front of individual elements that repeat

        if (sp.getMaxOccurs() == null) {
            // xmlc.insertComment("The next " + getItemNameOrType(sp, xmlc) + " may be repeated " + minOccurs + " or more times");
            if (minOccurs == 0) {
                xmlc.insertComment("Zero or more repetitions:");
            } else {
                xmlc.insertComment(minOccurs + " or more repetitions:");
            }
        } else if (sp.getIntMaxOccurs() > 1) {
            xmlc.insertComment(minOccurs + " to " + sp.getMaxOccurs() + " repetitions:");
        } else {
            xmlc.insertComment("Optional:");
        }
        return result;
    }

    private void processElement(SchemaParticle sp, XmlCursor xmlc, boolean mixed) {
        // cast as schema local element
        SchemaLocalElement element = (SchemaLocalElement) sp;
        /// ^  -> <elemenname></elem>^
        if (_soapEnc) {
            xmlc.insertElement(element.getName().getLocalPart()); // soap encoded? drop namespaces.
        } else {
            xmlc.insertElement(element.getName().getLocalPart(), element.getName().getNamespaceURI());
        }
        _nElements++;
        /// -> <elem>^</elem>
        xmlc.toPrevToken();
        // -> <elem>stuff^</elem>

        SchemaType elementType = element.getType();
        createSampleForType(elementType, xmlc);

        if (elementType.isSimpleType() || elementType.isURType() ||
                elementType.getContentType() == SchemaType.SIMPLE_CONTENT){
            String uuid = xmlc.getDomNode().getFirstChild().getNodeValue();
            putType(uuid, elementType, element);
        }

        xmlc.toNextToken();

    }

    private void putType(String uuid, SchemaType elementType, SchemaAnnotated element){
        String type;
        SchemaType primitiveType = elementType.getPrimitiveType();
        if (primitiveType == null){ // всякие unions
            if (elementType.isNumeric()){
                type = "XmlDecimal";
            }else {
                type = "XmlString";
            }
        }else {
            type = elementType.getPrimitiveType().getShortJavaName();
        }
        if ("XmlDecimal".equals(type)){
            int size = elementType.getDecimalSize();
            if (size == SchemaType.SIZE_LONG){
                type = "XmlLong";
            }else if (size == SchemaType.SIZE_INT || size == SchemaType.SIZE_SHORT || size == SchemaType.SIZE_BYTE) {
                type = "XmlInt";
            }
        }

        String description = retrieveDescription(element);
        if (description == null){
            description = retrieveDescription(elementType);
        }

        TypeInfo typeInfo = new TypeInfo();

        if (elementType.getEnumerationValues() != null && elementType.getEnumerationValues().length != 0){
            XmlAnySimpleType[] values = elementType.getEnumerationValues();
            List<String> vals = new ArrayList<>();
            Arrays.stream(values).forEach(v -> vals.add(v.getStringValue()));
            typeInfo.setEnumeration(vals);
        }

        SchemaField field = (SchemaField) element;

        boolean required = field.getMinOccurs().intValue() > 0;

        typeInfo.setUuid(uuid);
        typeInfo.setDescription(description);
        typeInfo.setType(type);
        typeInfo.setRequired(required);
        types.put(uuid, typeInfo);
    }

    private String retrieveDescription(SchemaAnnotated element){
        SchemaAnnotation annotation = element.getAnnotation();
        if (annotation == null) return null;
        StringBuilder sb = new StringBuilder();
        Arrays.stream(annotation.getUserInformation()).forEach(xmlObject -> {
            Node docInfo = xmlObject.getDomNode();
            NodeList list = docInfo.getChildNodes();
            for (int i = 0; i < list.getLength(); i++){
                Node c = list.item(i);
                if (c.getNodeType() == Node.TEXT_NODE) {
                    String str = c.getNodeValue();
                    sb.append(str.trim());
                    break;
                }
            }
        });
        return sb.length() != 0 ? sb.toString() : null;
    }

    private static String formatQName(XmlCursor xmlc, QName qName) {
        XmlCursor parent = xmlc.newCursor();
        parent.toParent();
        String prefix = parent.prefixForNamespace(qName.getNamespaceURI());
        parent.dispose();
        String name;
        if (prefix == null || prefix.length() == 0) {
            name = qName.getLocalPart();
        } else {
            name = prefix + ":" + qName.getLocalPart();
        }
        return name;
    }

    private static final QName HREF = new QName("href");
    private static final QName ID = new QName("id");
    private static final QName XSI_TYPE = new QName("http://www.w3.org/2001/XMLSchema-instance", "type");
    private static final QName ENC_ARRAYTYPE = new QName("http://schemas.xmlsoap.org/soap/encoding/", "arrayType");
    private static final QName ENC_OFFSET = new QName("http://schemas.xmlsoap.org/soap/encoding/", "offset");

    private static final Set<QName> SKIPPED_SOAP_ATTRS = new HashSet<>(Arrays.asList(HREF, ID, ENC_OFFSET));

    private void processAttributes(SchemaType stype, XmlCursor xmlc) {
        if (_soapEnc) {
            QName typeName = stype.getName();
            if (typeName != null) {
                xmlc.insertAttributeWithValue(XSI_TYPE, formatQName(xmlc, typeName));
            }
        }

        SchemaLocalAttribute[] attributes = stype.getAttributeModel().getAttributes();
        for (SchemaLocalAttribute attr : attributes) {
            if (_soapEnc) {
                if (SKIPPED_SOAP_ATTRS.contains(attr.getName())) {
                    continue;
                }
                if (ENC_ARRAYTYPE.equals(attr.getName())) {
                    SOAPArrayType arrayType = ((SchemaWSDLArrayType) stype.getAttributeModel().getAttribute(attr.getName())).getWSDLArrayType();
                    if (arrayType != null) {
                        xmlc.insertAttributeWithValue(attr.getName(), formatQName(xmlc, arrayType.getQName()) + arrayType.soap11DimensionString());
                    }
                    continue;
                }
            }
            String defaultValue = attr.getDefaultText();
            String uuid = sampleDataForSimpleType(attr.getType());
            xmlc.insertAttributeWithValue(attr.getName(),uuid);
            putType(uuid, attr.getType(), attr);
        }
    }

    private void processSequence(SchemaParticle sp, XmlCursor xmlc, boolean mixed) {
        SchemaParticle[] spc = sp.getParticleChildren();
        for (int i = 0; i < spc.length; i++) {
            /// <parent>maybestuff^</parent>
            processParticle(spc[i], xmlc, mixed);
            //<parent>maybestuff...morestuff^</parent>
            if (mixed && i < spc.length - 1) {
                xmlc.insertChars(pick(WORDS));
            }
        }
    }

    private void processChoice(SchemaParticle sp, XmlCursor xmlc, boolean mixed) {
        SchemaParticle[] spc = sp.getParticleChildren();
        xmlc.insertComment("You have a CHOICE of the next " + spc.length + " items at this level");
        for (SchemaParticle schemaParticle : spc) {
            processParticle(schemaParticle, xmlc, mixed);
        }
    }

    private void processAll(SchemaParticle sp, XmlCursor xmlc, boolean mixed) {
        SchemaParticle[] spc = sp.getParticleChildren();
        // xmlc.insertComment("You may enter the following " + String.valueOf(spc.length) + " items in any order");
        for (int i = 0; i < spc.length; i++) {
            processParticle(spc[i], xmlc, mixed);
            if (mixed && i < spc.length - 1) {
                xmlc.insertChars(pick(WORDS));
            }
        }
    }

    private void processWildCard(SchemaParticle sp, XmlCursor xmlc, boolean mixed) {
        xmlc.insertComment("You may enter ANY elements at this point");
        xmlc.insertElement("AnyElement");
    }

    private final ArrayList<SchemaType> _typeStack = new ArrayList<>();
}

/**
 * Write your info here
 *
 * @name Ahmed Lokma
 * @id 46-3494
 * @labNumber 08
 */


grammar Task10;

@members {
    private enum State {
        INCREASING, DECREASING
    }

    public static int compare(int x, int y) {
        if (x > y) {
            return 1;
        } else if (x < y) {
            return -1;
        } else {
            return 0;
        }
    }

    public static boolean isBitonic(String sequence) {
        sequence = sequence.trim();

        if (sequence.isEmpty()) {
            return true;
        }

        if (sequence.endsWith(",")) {
            sequence = sequence.substring(0, sequence.length() - 1);
        }

        return isBitonicRecursive(sequence, State.DECREASING, false) || isBitonicRecursive(sequence, State.INCREASING, false);
    }

    private static boolean isBitonicRecursive(String sequence, State state, boolean hasSwitched) {
        if (sequence.isEmpty()) {
            return true;
        }

        int commaIndex = sequence.indexOf(',');
        if (commaIndex == -1) {
            return true;
        }

        String currentElement = sequence.substring(0, commaIndex).trim();
        String remainingSequence = sequence.substring(commaIndex + 1).trim();

        if (remainingSequence.isEmpty()) {
            return true;
        }

        int nextCommaIndex = remainingSequence.indexOf(',');
        String nextElement = nextCommaIndex == -1 ? remainingSequence.trim() : remainingSequence.substring(0, nextCommaIndex).trim();

        if (state == State.INCREASING) {
            if (compare(Integer.parseInt(currentElement), Integer.parseInt(nextElement)) > 0) {
                if(hasSwitched) {
                    return false;
                } else {
                    state = State.DECREASING;
                    hasSwitched = true;
                }
            }
        } else if (state == State.DECREASING) {
            if (compare(Integer.parseInt(currentElement), Integer.parseInt(nextElement)) < 0) {
                if(hasSwitched) {
                    return false;
                } else {
                    state = State.INCREASING;
                    hasSwitched = true;
                }
            }
        }

        return isBitonicRecursive(remainingSequence, state, hasSwitched);
    }
}

s returns [boolean val]:
    sequence=elements EOF {$val = isBitonic($sequence.val);};

elements returns [String val]:
    first=element { $val = $first.val; }
    (',' next=element { $val += ", " + $next.val; })*;

element returns [String val]:
    digits=Digit+
    {
        $val = $digits.text;
    };

Digit : [0-9]+;
